/datum/discipline_power/vtr/auspex/lay_open_the_mind
	name = "Lay Open The Mind"
	desc = "Allows you to discover the closely guarded secrets of another."

	level = 4
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7
	cooldown_length = 60 SECONDS
	var/list/question_list = list(
		"Are you a diablerist?" = PROC_REF(ask_diablerie),
		"What are your memories?" = PROC_REF(ask_memories),
		"What are your connections?" = PROC_REF(ask_connections),
		"Is there anything controlling you?" = PROC_REF(ask_prompt),
		"What is your deepest desire?" = PROC_REF(ask_prompt),
		"What is your biggest regret?" = PROC_REF(ask_prompt),
		"Who did you last kill?" = PROC_REF(ask_prompt),
		"Out of everyone, who do you hate the most?" = PROC_REF(ask_prompt),
		"Out of everyone, who are you closest to?" = PROC_REF(ask_prompt),
		"What mortal are you closest to?" = PROC_REF(ask_prompt)
	)

/datum/discipline_power/vtr/auspex/lay_open_the_mind/pre_activation_checks(mob/living/carbon/human/target)
	var/mypower = owner.get_wits() + discipline.level
	var/theirpower = target.get_resolve() + target.get_potency()

	to_chat(owner, span_danger("You probe [target]'s mind..."))

	if(!do_mob(owner, owner, 1 SECONDS))
		return FALSE

	var/trait_bonus = (HAS_TRAIT(target, TRAIT_EMERSONIAN)?TRAIT_EMERSONIAN_MOD:0) + (HAS_TRAIT(target, TRAIT_PREGNABLE_MIND)?TRAIT_PREGNABLE_MIND_MOD:0)
	if(!SSroll.opposed_roll(owner, target, mypower, theirpower+trait_bonus, show_player_b = FALSE, alert_atom = target))
		do_cooldown(TRUE)
		owner.update_action_buttons()
		return FALSE
	return TRUE

/datum/discipline_power/vtr/auspex/lay_open_the_mind/activate(atom/target)
	. = ..()
	var/selection = tgui_input_list(owner, "[target]'s soul", "What question would you like to ask?", question_list, null)
	if(selection)
		INVOKE_ASYNC(src, question_list[selection], target, selection)


/datum/discipline_power/vtr/auspex/lay_open_the_mind/proc/ask_diablerie(mob/living/carbon/human/target, var/question)
	var/response = "You hear a response: "
	if(HAS_TRAIT(target, TRAIT_DIABLERIE))
		response = span_danger(response + "You can sense the depraived taint of diablerie on [target].")
	else
		response = span_notice(response + "You feel that [target] is not a diablerist.")
	to_chat(owner, response)

/datum/discipline_power/vtr/auspex/lay_open_the_mind/proc/ask_memories(mob/living/carbon/human/target, var/question)
	if(!target.mind)
		to_chat(owner, span_notice("[target] doesn't have very interesting memories..."))
		return
	target.mind.invade_mind(owner)

/datum/discipline_power/vtr/auspex/lay_open_the_mind/proc/ask_connections(mob/living/carbon/human/target, var/question)
	if(!target.mind)
		to_chat(owner, span_notice("[target] has no interesting connections..."))
		return

	if(!length(target.mind.character_connections))
		to_chat(owner, span_notice("[target] has no strong connections..."))
		return

	for(var/datum/character_connection/connection in target.mind.character_connections)
		if(connection.hidden)
			continue

		to_chat(owner, span_notice("You hear [target]'s voice: \"[connection.connection_desc]\""))


/datum/discipline_power/vtr/auspex/lay_open_the_mind/proc/ask_prompt(mob/living/carbon/human/target, var/question)
	if(!target.mind)
		to_chat(owner, span_notice("[target] doesn't have a particularly interesting response..."))
		return
	var/response = "You hear a response: "
	response += tgui_input_text(target, question+" (Answer Honestly)", "Your mind has been read!", "", MAX_MESSAGE_LEN, TRUE, FALSE)
	to_chat(owner, span_notice("You hear: \"[response]\""))
	log_admin("[owner] asked [target] an auspex command. Question: '[question]', Answer: '[response]'")
