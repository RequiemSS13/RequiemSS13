//PASSION
/datum/discipline_power/vtr/nightmare/face_of_terror
	name = "Face of Terror"
	desc = "Paralyze your victim with fear at a glance."

	level = 1

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/vtr/nightmare/face_of_terror/pre_activation_checks(mob/living/target)
	if(get_dir(target, owner) != target.dir)
		to_chat(owner, span_warning("[target] must be looking at you to use this ability!"))
		return FALSE

	owner.dir = get_dir(owner, target)
	var/trait_bonus = (HAS_TRAIT(target, TRAIT_EMERSONIAN)?TRAIT_EMERSONIAN_MOD:0) + (HAS_TRAIT(target, TRAIT_PREGNABLE_MIND)?TRAIT_PREGNABLE_MIND_MOD:0)
	if(SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_wits() + discipline.level,
		dice_b = target.get_resolve() + target.get_potency() + trait_bonus, 
		alert_atom = target)) //TODO HEX: Tie to blood_potency
		return TRUE
	to_chat(owner, span_warning("[target] resists the horror of what they see!"))
	if(target.mind)
		to_chat(target, span_userdanger("As you look at [owner] you see your horrors made manifest, but you resist!"))
		target.Jitter(10)
	do_cooldown(TRUE)
	owner.update_action_buttons()
	return FALSE


/datum/discipline_power/vtr/nightmare/face_of_terror/activate(mob/living/carbon/human/target)
	. = ..()

	apply_discipline_affliction_overlay(target, "dementation", 1)

	target.Stun(1 SECONDS, TRUE)
	target.Jitter(20)
	target.emote("cry")
	to_chat(target, span_userdanger("As you look at [owner]'s face, you recoil in terror!"))
	owner.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

/datum/discipline_power/vtr/nightmare/face_of_terror/deactivate(mob/living/carbon/human/target)
	. = ..()
	overlay_end(target)
