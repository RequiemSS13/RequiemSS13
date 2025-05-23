/datum/discipline_power/vtr/majesty/awe
	name = "Awe"
	desc = "Become the center of attention."
	level = 1

	cancelable = TRUE
	duration_length = 1 MINUTES
	var/charmed_status_debuff = 3
/datum/discipline_power/vtr/majesty/awe/activate()
	. = ..()
	for(var/mob/living/target in viewers(7,owner) - owner)
		if(!SSroll.opposed_roll(
			owner,
			target,
			dice_a = owner.get_total_charisma() + discipline.level,
			dice_b = target.get_total_composure() + target.blood_potency - HAS_TRAIT_FROM(target, TRAIT_CHARMED, owner) ? charmed_status_debuff : 0, 
			alert_atom = target,
			show_player_a = TRUE,
			show_player_b = FALSE))
			to_chat(target, "You resist the urge to stare at [owner]'s magnificence.")
			continue

		to_chat(target, "[owner] in this moment is utterly magnificent; it is hard to turn your eyes away.")
		target.playsound_local(owner, activate_sound, 50, FALSE)
		apply_discipline_affliction_overlay(target, "presence", 1, 5 SECONDS)

		if(target.mind)
			target.mind.AddComponent(/datum/component/enraptured, owner, src)
		else
			target.AddComponent(/datum/component/enraptured_npc, owner, src)


/datum/discipline_power/vtr/majesty/awe/deactivate()
	. = ..()
	SEND_SIGNAL(src, COMSIG_COMPONENT_ENRAPTURE_REMOVE)