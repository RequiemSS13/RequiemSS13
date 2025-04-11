/datum/discipline_power/vtr/majesty/green_eyes
	name = "Green Eyes"
	desc = "Direct the emotions of those around you, particularly the ones you have charmed"
	level = 2

	range = 7

	var/green_eyes_range = 4

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_PLAYER|TARGET_LIVING|TARGET_SELF

	var/guidelines = "Elge write a guideline document for this open-ended command."
	var/player_consent = "Elge write a disclaimer for this consent form"

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
	for(var/mob/living/victim in viewers(green_eyes_range, owner))
		
		if(!SSroll.opposed_roll(
			owner,
			victim,
			dice_a = owner.get_total_social() + discipline.level,
			dice_b = victim.get_total_social() + victim.get_total_blood() - HAS_TRAIT_FROM(victim, TRAIT_CHARMED, owner) ? charmed_status_debuff : 0, 
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


