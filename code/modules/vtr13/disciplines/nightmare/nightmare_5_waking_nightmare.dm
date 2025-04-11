/datum/discipline_power/vtr/nightmare/waking_nightmare
	name = "Waking Nightmare"
	desc = "Subject a victim to a horrendous, visceral experience."
	
	level = 5
	
	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7

	multi_activate = TRUE
	cooldown_length = 30 SECONDS
	duration_length = 3 MINUTES
	var/overlay_time = 5 SECONDS
	var/hallucination_refresh = 10 SECONDS

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
	
	apply_discipline_affliction_overlay(target, "dementation", 1, 5 SECONDS)
	target.emote("scream")
	target.Jitter(60)
	if(!target.mind)
		return
	ADD_TRAIT(target, TRAIT_ATTENDING_CARNIVAL, NIGHTMARE_4_TRAIT)
	target.add_client_colour(/datum/client_colour/glass_colour/darkred)
	
	mounting_hallucinations(target)

	target.AddComponent(/datum/component/meatworld_component, src)
	target.AddElement(/datum/element/ui_button_shake_inventory_group, 1)
	target.AddElement(/datum/element/ui_button_shake_wide_button_group, 1)
	
	to_chat(target, span_userdanger("The world has gone mad!"))
	target.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

/datum/discipline_power/vtr/nightmare/waking_nightmare/overlay_end(mob/living/carbon/human/target)
	. = ..()
	if(!.)
		return

	SEND_SOUND(target, sound('code/modules/wod13/sounds/nosferatu.ogg'))


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
	target.RemoveElement(/datum/element/ui_button_shake_inventory_group)
	target.RemoveElement(/datum/element/ui_button_shake_wide_button_group)
	target.remove_client_colour(/datum/client_colour/glass_colour/darkred)