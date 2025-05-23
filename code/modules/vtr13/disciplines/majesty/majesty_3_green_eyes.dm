/datum/discipline_power/vtr/majesty/green_eyes
	name = "Green Eyes"
	desc = "Direct the emotions of those around you, particularly the ones you have charmed"
	level = 2

	range = 7

	var/green_eyes_range = 4

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_PLAYER|TARGET_LIVING|TARGET_SELF

	var/guidelines = "On a successful roll, Green Eyes allows you to instill a certain emotion towards your target. The instilled emotion should be relatively simple, as Green Eyes is not mind control. All characters whose emotions would be influenced by Green Eyes can choose to reject your influence for any reason- please ensure your influence is not boring, uncomfortable, or against the rules. The text of your influence is readable by staff. Please keep our consent guidelines in mind while using this power."
	var/player_consent = "If you accept this command, you will begin to feel the targeted emotion towards the target. These emotions will slowly fade over the span of many minutes, as you naturally calm down. This does not inherently compel you to do anything, and our consent rules continue to apply. If you do not consent to this command, it will appear as though a failed roll. You do not have to justify rejecting this command to anyone, including staff. Consenting to this command does not remove your ability to revoke consent later for any reason."

	var/current_emotion

	//dice lost by being affected by the charmed status
	var/charmed_status_debuff = 3

	var/power_in_use = FALSE

/datum/discipline_power/vtr/majesty/green_eyes/pre_activation_check_no_spend(atom/target)
	if(power_in_use)
		to_chat(owner, span_warning("You are already attempting to use this power!"))
		return FALSE

	power_in_use = TRUE
	current_emotion = majesty_tgui_input_text(owner, guidelines, "Choose an emotion to instill, eg: Anger, Envy, Appreciation, etc. :", "Majesty", null, 50, FALSE, FALSE, 1)
	power_in_use = FALSE

	if(!current_emotion)
		to_chat(owner, span_warning("You think better of manipulating those around you."))
		return FALSE

	return TRUE

/datum/discipline_power/vtr/majesty/green_eyes/activate(mob/living/carbon/human/target)
	. = ..()

	var/the_emotion = current_emotion
	current_emotion = null
	for(var/mob/living/victim in viewers(green_eyes_range, owner) - list(owner, target))

		if(!SSroll.opposed_roll(
			owner,
			victim,
			dice_a = owner.get_total_charisma() + discipline.level,
			dice_b = target.get_total_composure() + target.blood_potency - HAS_TRAIT_FROM(victim, TRAIT_CHARMED, owner) ? charmed_status_debuff : 0,
			alert_atom = victim,
			show_player_a = FALSE,
			show_player_b = FALSE))
			continue

		consent_ping(victim)
		if(!consent_prompt(victim, "[owner] is trying to manipulate your emotions towards [target]! The emotion instilled:", "Majesty Consent Form", player_consent, the_emotion))
			log_admin("[victim] rejected consent for Majesty [level] from [owner]. Target:[target], Emotion: '[the_emotion]'")
			to_chat(victim, span_notice("You do not consent to manipulation."))
			return

		to_chat(victim, span_notice("You consent to emotional manipulation. Consent may be retracted at any time."))
		log_admin("[victim] was affected by Majesty [level] from [owner]. Target:[target], Emotion: '[the_emotion]'")
		to_chat(victim, "<span class='userlove'>Something about this situation fills you with [the_emotion] for [target]!</span>")
		victim.playsound_local(target, activate_sound, 50, FALSE)


