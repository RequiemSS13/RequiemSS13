/datum/discipline_power/vtr/auspex/telepathy
	name = "Major Telepathy"
	desc = "Allows you to discover the closely guarded secrets of another."

	level = 4
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7
	cooldown_length = 60 SECONDS
	var/list/question_list = list(
		"Are you a diablerist?" = PROC_REF(ask_diablerie),
		"Is there anything controlling you?" = PROC_REF(ask_prompt)
	)

/datum/discipline_power/vtr/auspex/telepathy/pre_activation_checks(mob/living/carbon/human/target)
	var/mypower = owner.get_total_mentality() + discipline.level
	var/theirpower = target.get_total_mentality() + target.get_total_blood() //TODO HEX: Tie to blood_potency

	to_chat(owner, span_danger("You probe [target]'s mind..."))
	var/their_successes = target.storyteller_roll(theirpower, 6, TRUE, "" ,FALSE)
	var/my_successes = owner.storyteller_roll(mypower, 6, TRUE, "Mentality+Auspex vs [their_successes] successes")

	if(their_successes >= my_successes)
		return FALSE
	return TRUE


/datum/discipline_power/vtr/auspex/telepathy/activate(atom/target)
	. = ..()
	

	var/selection = tgui_input_list(owner, "[target]'s soul", "What question would you like to ask?", question_list, null)
	if(selection)
		INVOKE_ASYNC(src, question_list[selection], target, selection)


/datum/discipline_power/vtr/auspex/telepathy/proc/ask_diablerie(mob/living/carbon/human/target, var/question)
	var/response = "You hear a response: "
	if(target.diablerist)
		response += span_danger("You can sense the depraived taint of diablerie on [target].")
	else
		response += span_notice("You feel that [target] is not a diablerist.")
	to_chat(owner, response)

/datum/discipline_power/vtr/auspex/telepathy/proc/ask_prompt(mob/living/carbon/human/target, var/question)
	if(!target.mind)
		to_chat(owner, span_notice("[target] doesn't have a particularly interesting response..."))
		return
	var/response = "You hear a response: "
	response += tgui_input_text(target, question+" (Answer Honestly)", "Your mind has been read!", "", MAX_MESSAGE_LEN, TRUE, FALSE)
	to_chat(owner, span_notice(response))