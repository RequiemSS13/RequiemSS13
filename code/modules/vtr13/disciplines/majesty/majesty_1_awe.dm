/datum/discipline_power/vtr/majesty/awe
	name = "Awe"
	desc = "Become the center of attention."
	level = 1

	cancelable = TRUE
	duration_length = 1 MINUTES

/datum/discipline_power/vtr/majesty/awe/activate()
	. = ..()
	for(var/mob/living/target in oviewers(7,owner))
		to_chat(target, "[owner] begins to look more magnificent, in whatever they are doing.")
		if(!SSroll.opposed_roll(
			owner,
			target,
			dice_a = owner.get_total_social() + discipline.level,
			dice_b = target.get_total_social() + target.get_total_blood(), 
			alert_atom = target,
			show_player_a = TRUE,
			show_player_b = FALSE))
			continue
		
		target.playsound_local(owner, activate_sound, 50, FALSE)

		if(target.mind)
			target.mind.AddComponent(/datum/component/enraptured, owner, src)
		else
			target.AddComponent(/datum/component/enraptured_npc, owner, src)

/datum/discipline_power/vtr/majesty/awe/deactivate()
	. = ..()
	SEND_SIGNAL(src, COMSIG_COMPONENT_ENRAPTURE_REMOVE)