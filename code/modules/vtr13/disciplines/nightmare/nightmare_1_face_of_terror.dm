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
	if(owner.opposed_roll(
		owner,
		target,
		dice_a = owner.get_total_mentality() + discipline.level,
		dice_b = target.get_total_mentality() + target.get_total_blood(),
		stat_test_a_header = "Mentality + Nightmare",
		stat_test_b_header = "Mentality + Blood")) //TODO HEX: Tie to blood_potency
		return TRUE	
	to_chat(owner, span_warning("[target] resists the horror of what they see!"))
	if(target.mind)
		to_chat(target, span_userdanger("As you look at [owner] you see your horrors made manifest, but you resist!"))
		target.Jitter(10)
	return FALSE


/datum/discipline_power/vtr/nightmare/face_of_terror/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	
	
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	target.Stun(1 SECONDS, TRUE)
	target.Jitter(20)
	target.emote("cry")
	to_chat(target, span_userdanger("As you look at [owner]'s face, you recoil in terror!"))
	owner.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

/datum/discipline_power/vtr/nightmare/face_of_terror/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)