/datum/discipline_power/vtr/nightmare/phantom_trauma
	name = "Phantom Trauma"
	desc = "Cause the victim's whole body to tremble with fear."
	
	level = 2

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 30 SECONDS

/datum/discipline_power/vtr/nightmare/phantom_trauma/pre_activation_checks(mob/living/carbon/human/target)
	if(SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_total_mentality() + discipline.level,
		dice_b = target.get_total_mentality() + target.get_total_blood(), 
		alert_atom = target)) //TODO HEX: Tie to blood_potency
		return TRUE	
	to_chat(owner, span_warning("[target] resists the the chill going up their spine!"))
	if(target.mind)
		to_chat(target, span_userdanger("A dreadful cold overtakes you, but you suppress the urge to shiver!"))
		target.Jitter(10)
	return FALSE

/datum/discipline_power/vtr/nightmare/phantom_trauma/activate(mob/living/carbon/human/target)
	. = ..()

	apply_discipline_affliction_overlay(target, "dementation", 1)

	target.Jitter(15)
	ADD_TRAIT(target, TRAIT_NO_QUICK_EQUIP, NIGHTMARE_2_TRAIT)
	owner.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)
	to_chat(target, span_userdanger("You find yourself in the final moments of a horror you cannot remember. The danger has passed, but your body trembles like a leaf from the stress."))
	if(target.mind)
		target.AddElement(/datum/element/ui_button_shake_inventory_group, 16)
		target.AddElement(/datum/element/ui_button_shake_wide_button_group, 1)
		target.RemoveElement(/datum/element/ui_button_shake_wide_button_group)
	do_cooldown(TRUE)
	owner.update_action_buttons()

/datum/discipline_power/vtr/nightmare/phantom_trauma/deactivate(mob/living/carbon/human/target)
	. = ..()
	overlay_end(target)

	REMOVE_TRAIT(target, TRAIT_NO_QUICK_EQUIP, NIGHTMARE_2_TRAIT)
	to_chat(target, span_warning("You regain control of your senses."))
	target.RemoveElement(/datum/element/ui_button_shake_inventory_group)