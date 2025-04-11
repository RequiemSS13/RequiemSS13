SUBSYSTEM_DEF(roll)
	name = "Dice Rolling"
	flags = SS_NO_INIT | SS_NO_FIRE

/**
 * Rolls a number of dice according to Storyteller system rules to find
 * success or number of successes.
 *
 * Rolls a number of 10-sided dice, counting them as a "success" if
 * they land on a number equal to or greater than the difficulty. Dice
 * that land on 1 subtract a success from the total, and the minimum
 * difficulty is 2. The number of successes is returned if numerical
 * is true, or the roll outcome (botch, failure, success) as a defined
 * number if false.
 *
 * Arguments:
 * * dice - number of 10-sided dice to roll.
 * * difficulty - the number that a dice must come up as to count as a success.
 * * numerical - whether the proc returns number of successes or outcome (botch, failure, success)
 * * mobs_to_show_output - mobs shown the result
 * * alert_atom - the atom over which balloon alerts should appear
 */

/datum/controller/subsystem/roll/proc/storyteller_roll(dice = 1, difficulty = 6, numerical = FALSE, list/mobs_to_show_output = list(), atom/alert_atom = null)
	var/list/rolled_dice = roll_dice(dice)
	if(!islist(mobs_to_show_output))
		mobs_to_show_output = list(mobs_to_show_output)
	
	var/list/mobs_to_tell = list()
	for(var/mob/player_mob as anything in mobs_to_show_output)
		if(player_mob?.client?.prefs.chat_toggles && player_mob.client.prefs.chat_toggles & CHAT_ROLL_INFO)
			mobs_to_tell += player_mob

	
	var/success_count = 0
	var/output 
	if(mobs_to_tell.len)
		var/list/output_text = list()
		output_text += span_notice("Rolling [length(rolled_dice)] dice against difficulty [difficulty]. \n")
		success_count = count_success(rolled_dice, difficulty, output_text)
		output = roll_answer(success_count, numerical, output_text)
		for(var/mob/player_mob as anything in mobs_to_tell)
			if(player_mob?.client?.prefs.chat_toggles && player_mob.client.prefs.chat_toggles & CHAT_ROLL_INFO)
				to_chat(player_mob, jointext(output_text, ""), trailing_newline = FALSE)
		
	else
		success_count = count_success_basic(rolled_dice, difficulty)
		output = roll_answer_basic(success_count, numerical)
	

	if(alert_atom)
		var/alert_text
		if(success_count >= 1)
			alert_text = "<span style='color: #14a833;'>+[success_count]</span>"
		else
			alert_text = "<span style='color: #ff0000;'>[success_count]</span>"
		for(var/mob/show_mob in mobs_to_show_output)
			alert_atom.balloon_alert(show_mob, alert_text, TRUE)

	return output

/datum/controller/subsystem/roll/proc/opposed_roll(mob/player_a, mob/player_b, dice_a = 1, dice_b = 1, difficulty=6, show_player_a=TRUE, show_player_b=TRUE, atom/alert_atom = null, draw_goes_to_b=TRUE, numerical=FALSE)
	var/list/rolled_dice_a = roll_dice(dice_a)
	var/list/rolled_dice_b = roll_dice(dice_b)
	
	var/can_tell_player_a = player_a?.client?.prefs.chat_toggles && (player_a.client.prefs.chat_toggles & CHAT_ROLL_INFO)
	var/can_tell_player_b = player_b?.client?.prefs.chat_toggles && (player_b.client.prefs.chat_toggles & CHAT_ROLL_INFO)

	var/list/output_text_a
	var/list/output_text_b

	var/success_count_a = 0
	if(can_tell_player_a && show_player_a)
		output_text_a = list()
		success_count_a = count_success(rolled_dice_a, difficulty, output_text_a)
	else
		success_count_a = count_success_basic(rolled_dice_a, difficulty)

	var/success_count_b = 0
	if(can_tell_player_b && show_player_b)
		output_text_b = list()
		success_count_b = count_success(rolled_dice_b, difficulty, output_text_b)
	else
		success_count_b = count_success_basic(rolled_dice_b, difficulty)

	var/player_a_succeeded = FALSE
	if(success_count_a > success_count_b || (success_count_a == success_count_b && !draw_goes_to_b))
		player_a_succeeded = TRUE

	if(can_tell_player_a && show_player_a)
		output_text_a.Insert(1, span_notice("Rolling [length(rolled_dice_a)] dice against difficulty [difficulty]. Successes to beat: [success_count_b]\n"))
		if(player_a_succeeded)
			output_text_a += span_nicegreen("\n You Succeed!")
		else
			output_text_a += span_danger("\n You Fail!")
		to_chat(player_a, jointext(output_text_a, ""), trailing_newline = FALSE)

	if(can_tell_player_b && show_player_b)
		output_text_b.Insert(1, span_notice("Rolling [length(rolled_dice_b)] dice against difficulty [difficulty]. Successes to beat: [success_count_a]\n"))
		if(!player_a_succeeded)
			output_text_b += span_nicegreen("\n You Succeed!")
		else
			output_text_b += span_danger("\n You Fail!")
		to_chat(player_b, jointext(output_text_b, ""), trailing_newline = FALSE)
	
	if(alert_atom)
		var/is_zero = ((success_count_a - success_count_b) == 0)
		if(show_player_a)
			var/alert_text
			if(player_a_succeeded)
				alert_text = "<span style='color: #14a833;'>[is_zero ?"":"+"][success_count_a - success_count_b]</span>"
			else
				alert_text = "<span style='color: #ff0000;'>[success_count_a - success_count_b]</span>"
			alert_atom.balloon_alert(player_a, alert_text, TRUE)
		if(show_player_b)
			var/alert_text
			if(!player_a_succeeded)
				alert_text = "<span style='color: #14a833;'>[is_zero ?"":"+"][success_count_b - success_count_a]</span>"
			else
				alert_text = "<span style='color: #ff0000;'>[success_count_b - success_count_a]</span>"
			alert_atom.balloon_alert(player_b, alert_text, TRUE)
	
	if(numerical)
		return success_count_a - success_count_b
	else
		return player_a_succeeded

//Roll each ten sided die, see what numbers we get.
/datum/controller/subsystem/roll/proc/roll_dice(dice)
	if(dice < 1)
		dice = 1
	var/list/rolled_dice = list()
	for(var/i in 1 to dice)
		rolled_dice += rand(1, 10)
	return rolled_dice

//Count the number of successes.
/datum/controller/subsystem/roll/proc/count_success(list/rolled_dice, difficulty, output_text)
	var/success_count = 0
	for(var/roll as anything in rolled_dice)
		if(roll >= difficulty)
			output_text += span_nicegreen("[get_dice_char(roll)]")
			success_count++
		else if(roll == 1)
			output_text += span_bold(span_danger("[get_dice_char(roll)]"))
			success_count--
		else
			output_text += span_danger("[get_dice_char(roll)]")
		output_text += " "
	return success_count

/datum/controller/subsystem/roll/proc/count_success_basic(list/rolled_dice, difficulty)
	var/success_count = 0
	for(var/roll as anything in rolled_dice)
		if(roll >= difficulty)
			success_count++
		else if(roll == 1)
			success_count--
	return success_count

/datum/controller/subsystem/roll/proc/roll_answer(success_count, numerical, output_text)
	if(numerical)
		return success_count
	else
		if(success_count < 0)
			output_text += span_bold(span_danger(("\n Botch!")))
			return ROLL_BOTCH
		else if(success_count == 0)
			output_text += span_danger("\n Failure!")
			return ROLL_FAILURE
		else
			output_text += span_nicegreen("\n Success!")
			return ROLL_SUCCESS

/datum/controller/subsystem/roll/proc/roll_answer_basic(success_count, numerical)
	if(numerical)
		return success_count
	else
		if(success_count < 0)
			return ROLL_BOTCH
		else if(success_count == 0)
			return ROLL_FAILURE
		else
			return ROLL_SUCCESS



/datum/controller/subsystem/roll/proc/get_dice_char(var/input)
	switch(input)
		if(1)
			return "❶"
		if(2)
			return "❷"
		if(3)
			return "❸"
		if(4)
			return "❹"
		if(5)
			return "❺"
		if(6)
			return "❻"
		if(7)
			return "❼"
		if(8)
			return "❽"
		if(9)
			return "❾"
		if(10)
			return "❿"
		else
			return "⓿"
