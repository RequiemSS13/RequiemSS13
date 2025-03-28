/datum/discipline_power/vtr/nightmare/waking_nightmare
	name = "Waking Nightmare"
	desc = "Subject a victim to a horrendous, visceral experience."
	
	level = 4
	
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 1 MINUTES
	var/overlay_time = 5 SECONDS
	var/hallucination_refresh = 10 SECONDS

	var/datum/component/meatworld_component/tracked_meatworld

/datum/discipline_power/vtr/nightmare/waking_nightmare/pre_activation_checks(mob/living/target)
	if(HAS_TRAIT(target, TRAIT_ATTENDING_CARNIVAL))
		to_chat(owner, span_warning("You have already sent [target] to the Carnival!"))
	if(SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_total_mentality() + discipline.level,
		dice_b = target.get_total_mentality() + target.get_total_blood(), 
		alert_atom = target)) //TODO HEX: Tie to blood_potency
		return TRUE
	to_chat(owner, span_warning("[target] holds onto their senses!"))
	if(target.mind)
		to_chat(target, span_userdanger("You briefly begin to dissociate, but wrench your mind back to clarity at the last moment!"))
		target.Jitter(5)
	do_cooldown(TRUE)
	owner.update_action_buttons()
	return FALSE


/datum/discipline_power/vtr/nightmare/waking_nightmare/activate(mob/living/carbon/human/target)
	. = ..()
	if(!target.mind)
		return
	
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('code/modules/wod13/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	
	
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)
	addtimer(CALLBACK(src, PROC_REF(overlay_end_early),target),overlay_time)
	target.emote("scream")
	target.Jitter(60)
	if(!target.mind)
		return
	ADD_TRAIT(target, TRAIT_ATTENDING_CARNIVAL, NIGHTMARE_4_TRAIT)
	target.add_client_colour(/datum/client_colour/glass_colour/darkred)
	
	mounting_hallucinations(target)

	tracked_meatworld = target.AddComponent(/datum/component/meatworld_component)
	target.AddElement(/datum/element/ui_button_shake_inventory_group, 1)
	target.AddElement(/datum/element/ui_button_shake_wide_button_group, 1)
	
	to_chat(target, span_userdanger("The world has gone mad!"))
	target.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

/datum/discipline_power/vtr/nightmare/waking_nightmare/proc/overlay_end_early(mob/living/carbon/human/target)
	target.remove_overlay(MUTATIONS_LAYER)


/datum/discipline_power/vtr/nightmare/waking_nightmare/proc/mounting_hallucinations(mob/living/carbon/human/target)
	if(!HAS_TRAIT(target, TRAIT_ATTENDING_CARNIVAL))
		return
	var/halpick = pickweight(GLOB.hallucination_list_unweighted)
	new halpick(target, FALSE)
	addtimer(CALLBACK(src, PROC_REF(mounting_hallucinations),target),hallucination_refresh)
	

/datum/discipline_power/vtr/nightmare/waking_nightmare/deactivate(mob/living/carbon/human/target)
	. = ..()

	if(!target.mind)
		return

	REMOVE_TRAIT(target, TRAIT_ATTENDING_CARNIVAL, NIGHTMARE_4_TRAIT)
	to_chat(target, span_warning("At long last, the horrors begin to fade."))
	SEND_SIGNAL(target, COMSIG_MEATWORLD_REMOVE_COMPONENT)
	target.RemoveElement(/datum/element/ui_button_shake_inventory_group)
	target.RemoveElement(/datum/element/ui_button_shake_wide_button_group)
	target.hallucination = 0
	owner.remove_client_colour(/datum/client_colour/glass_colour/darkred)