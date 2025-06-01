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
	var/trait_bonus = (HAS_TRAIT(target, TRAIT_EMERSONIAN)?TRAIT_EMERSONIAN_MOD:0) + (HAS_TRAIT(target, TRAIT_PREGNABLE_MIND)?TRAIT_PREGNABLE_MIND_MOD:0)
	if(SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_wits() + discipline.level,
		dice_b = target.get_resolve() + target.get_potency() + trait_bonus, 
		alert_atom = target)) //TODO HEX: Tie to blood_potency
		return TRUE
	to_chat(owner, span_warning("[target] keeps their eyes open!"))
	if(target.mind)
		to_chat(target, span_userdanger("The walls are pressing in- but you push back! You prevent the darkness from closing in!"))
		target.Jitter(5)
	do_cooldown(TRUE)
	owner.update_action_buttons()
	return FALSE


/datum/discipline_power/vtr/nightmare/hysterical_blindness/activate(mob/living/carbon/human/target)
	. = ..()
	apply_discipline_affliction_overlay(target, "dementation", 1)

	ADD_TRAIT(target, TRAIT_BLIND, NIGHTMARE_3_TRAIT)
	ADD_TRAIT(target, TRAIT_DEAF, NIGHTMARE_3_TRAIT)
	target.update_blindness()
	target.Jitter(20)
	to_chat(target, span_userdanger("THE WALLS ARE PUSHING IN, THE LIGHT FADES, THE SOUND GOES BLURRY!"))
	owner.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

/datum/discipline_power/vtr/nightmare/hysterical_blindness/deactivate(mob/living/carbon/human/target)
	. = ..()
	overlay_end(target)

	to_chat(target, span_warning("Your sight returns to you."))
	REMOVE_TRAIT(target, TRAIT_BLIND, NIGHTMARE_3_TRAIT)
	REMOVE_TRAIT(target, TRAIT_DEAF, NIGHTMARE_3_TRAIT)

	target.update_blindness()
