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
 * * mobs_to_show_output - mobs shown the result
 * * alert_atom - the atom over which balloon alerts should appear
 */

/datum/controller/subsystem/roll/proc/storyteller_roll(dice = 2, difficulty = 2, list/mobs_to_show_output = list(), atom/alert_atom = null)

	if(!islist(mobs_to_show_output) && mobs_to_show_output)
		mobs_to_show_output = list(mobs_to_show_output)

	var/success_count = roll_dice(dice)

	if(alert_atom)
		var/alert_text
		if(!success_count || success_count < difficulty)
			alert_text = "<span style='color: #ff0000;'>[success_count]</span>"
		else
			alert_text = "<span style='color: #14a833;'>[success_count]</span>"

		for(var/mob/show_mob in mobs_to_show_output)
			alert_atom.balloon_alert(show_mob, alert_text, TRUE)

	return success_count

/datum/controller/subsystem/roll/proc/opposed_roll(mob/player_a, mob/player_b, dice_a = 1, dice_b = 1, show_player_a=TRUE, show_player_b=TRUE, atom/alert_atom = null, draw_goes_to_b=TRUE, numerical=FALSE)
	var/success_count_a = roll_dice(dice_a)
	var/success_count_b = roll_dice(dice_b)

	var/player_a_succeeded = FALSE
	if(success_count_a > success_count_b || (success_count_a == success_count_b && !draw_goes_to_b))
		player_a_succeeded = TRUE

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

//Flip each coin, see what numbers we get.
/datum/controller/subsystem/roll/proc/roll_dice(dice)
	if(dice < 1)
		dice = 1
	var/rolled_dice
	for(var/i in 1 to dice)
		rolled_dice += rand(0, 1)
	return rolled_dice