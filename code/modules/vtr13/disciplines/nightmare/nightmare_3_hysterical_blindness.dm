/datum/discipline_power/vtr/nightmare/hysterical_blindness
	name = "Hysterical Blindness"
	desc = "Make someone go blind and deaf temporarily from traumatic stress."
	level = 3

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 10 SECONDS

/datum/discipline_power/vtr/nightmare/hysterical_blindness/pre_activation_checks(mob/living/target)
	if(owner.opposed_roll(
		owner,
		target,
		dice_a = owner.get_total_mentality() + discipline.level,
		dice_b = target.get_total_mentality() + target.get_total_blood(),
		stat_test_a_header = "Mentality + Nightmare",
		stat_test_b_header = "Mentality + Blood")) //TODO HEX: Tie to blood_potency
		return TRUE	
	to_chat(owner, span_warning("[target] keeps their eyes open!"))
	if(target.mind)
		to_chat(target, span_userdanger("The walls are pressing in- but you push back! You prevent the darkness from closing in!"))
		target.Jitter(5)
	return FALSE


/datum/discipline_power/vtr/nightmare/hysterical_blindness/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	
	
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	ADD_TRAIT(target, TRAIT_BLIND, NIGHTMARE_3_TRAIT)
	ADD_TRAIT(target, TRAIT_DEAF, NIGHTMARE_3_TRAIT)
	target.update_blindness()
	target.Jitter(20)
	to_chat(target, span_userdanger("THE WALLS ARE PUSHING IN, THE LIGHT FADES, THE SOUND GOES BLURRY!"))
	owner.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

/datum/discipline_power/vtr/nightmare/hysterical_blindness/deactivate(mob/living/carbon/human/target)
	. = ..()
	to_chat(target, span_warning("Your sight returns to you."))
	target.remove_overlay(MUTATIONS_LAYER)
	REMOVE_TRAIT(target, TRAIT_BLIND, NIGHTMARE_3_TRAIT)
	REMOVE_TRAIT(target, TRAIT_DEAF, NIGHTMARE_3_TRAIT)
	target.update_blindness()