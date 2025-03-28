//AURA PERCEPTION
/datum/discipline_power/vtr/auspex/uncanny_perception
	name = "Minor Telepathy"
	desc = "Allows you to pick out the secrets from a target."


	level = 2
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7
	cooldown_length = 10 SECONDS
	var/list/question_list = list(
		"Who are you?" = PROC_REF(ask_name),
		"What was the last thing this person said?" = PROC_REF(ask_last_words),
		"Are you blood bonded to anyone?" = PROC_REF(ask_bonds),
		"What are you feeling right now?" = PROC_REF(ask_prompt),
		"What are you most afraid of right now?" = PROC_REF(ask_prompt),
		"What do you want out of this interaction?" = PROC_REF(ask_prompt),
		"Are you willing to resort to violence right now?" = PROC_REF(ask_prompt),
		"Are you trying to take advantage of someone right now?" = PROC_REF(ask_prompt)
	)

/datum/discipline_power/vtr/auspex/uncanny_perception/pre_activation_checks(mob/living/carbon/human/target)
	var/mypower = owner.get_total_mentality() + discipline.level
	var/theirpower = target.get_total_mentality() + target.get_total_blood() //TODO HEX: Tie to blood_potency

	to_chat(owner, span_danger("You probe [target]'s mind..."))
	if(!SSroll.opposed_roll(owner, target, mypower, theirpower, show_player_b = FALSE, alert_atom = target))
		do_cooldown(TRUE)
		owner.update_action_buttons()
		return FALSE
	return TRUE

/datum/discipline_power/vtr/auspex/uncanny_perception/activate(atom/target)
	. = ..()
	var/selection = tgui_input_list(owner, "[target]'s soul", "What question would you like to ask?", question_list, null)
	if(selection)
		INVOKE_ASYNC(src, question_list[selection], target, selection)

/datum/discipline_power/vtr/auspex/uncanny_perception/proc/ask_last_words(mob/living/carbon/human/target, question)
	if(target.last_words)
		to_chat(owner, span_notice("You see a phrase in the air: \"[target.last_words]\""))
	else
		to_chat(owner, span_notice("You feel [target] hasn't said anything interesting lately."))


/datum/discipline_power/vtr/auspex/uncanny_perception/proc/ask_name(mob/living/carbon/human/target, question)
	to_chat(owner, span_notice("A name whispers on the wind: \"[target.true_real_name]\""))

/datum/discipline_power/vtr/auspex/uncanny_perception/proc/ask_bonds(mob/living/carbon/human/target, question)
	if(!target.mind)
		to_chat(owner, span_notice("[target] doesn't have any remarkable ..."))
		return
	var/bonds_spoken = FALSE
	for(var/datum/character_connection/connection in target.mind.character_connections)
		if(connection.member_type == MEMBER_TYPE_THRALL)
			if(!bonds_spoken)
				bonds_spoken = TRUE
			to_chat(owner, span_notice("You hear [target]'s voice: \"[connection.connection_desc]\""))
	if(!bonds_spoken)
		to_chat(owner, span_notice("[target] has no blood bonds."))

/datum/discipline_power/vtr/auspex/uncanny_perception/proc/ask_prompt(mob/living/carbon/human/target, question)
	if(!target.mind)
		to_chat(owner, span_notice("[target] doesn't have a particularly interesting response..."))
		return
	var/response = "You hear a response: "
	response += tgui_input_text(target, question + " (Answer Honestly)", "Your mind has been read!", "", MAX_MESSAGE_LEN, TRUE, FALSE)
	to_chat(owner, span_notice("You hear: \"[response]\""))