/datum/discipline_power/vtr/nightmare/carneval
	name = "Carneval"
	desc = "NOT DONE AT ALL."
	
	level = 4
	
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 30 SECONDS
	var/overlay_time = 5 SECONDS


/datum/discipline_power/vtr/nightmare/carneval/pre_activation_checks(mob/living/target)
	if(owner.opposed_roll(
		owner,
		target,
		dice_a = owner.get_total_mentality() + discipline.level,
		dice_b = target.get_total_mentality() + target.get_total_blood(),
		stat_test_a_header = "Mentality + Nightmare",
		stat_test_b_header = "Mentality + Blood")) //TODO HEX: Tie to blood_potency
		return TRUE	
	to_chat(owner, span_warning("[target] holds onto their senses!"))
	if(target.mind)
		to_chat(target, span_userdanger("You briefly begin to dissociate, but wrench your mind back to clarity at the last moment!"))
		target.Jitter(5)
	return FALSE


/datum/discipline_power/vtr/nightmare/carneval/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	
	
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	
	to_chat(target, span_userdanger("The world has gone mad!"))
	owner.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

	addtimer(CALLBACK(src, PROC_REF(overlay_end_early),target),overlay_time)

/datum/discipline_power/vtr/nightmare/carneval/proc/overlay_end_early(mob/living/carbon/human/target)
	target.remove_overlay(MUTATIONS_LAYER)

/datum/discipline_power/vtr/nightmare/carneval/deactivate(mob/living/carbon/human/target)
	. = ..()
	to_chat(target, span_warning("At long last, the horrors fade."))