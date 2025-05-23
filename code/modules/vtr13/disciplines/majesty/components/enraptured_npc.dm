/datum/component/enraptured_npc
	dupe_mode = COMPONENT_DUPE_SELECTIVE

	var/mob/living/carbon/human/vip
	var/datum/discipline_power/vtr/source_power
	var/mob/living/living_target
	var/in_sight = TRUE

/datum/component/enraptured_npc/Initialize(mob/living/new_vip, datum/discipline_power/vtr/new_source_power)
	
	source_power = new_source_power
	if(!source_power)
		return COMPONENT_INCOMPATIBLE

	living_target = parent
	vip = new_vip
	if(!living_target || !vip || !isliving(vip))
		return COMPONENT_INCOMPATIBLE
	

	RegisterSignal(vip, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))
	RegisterSignal(vip, COMSIG_LIVING_DEATH, PROC_REF(destroy_component))
	
	RegisterSignal(source_power, COMSIG_COMPONENT_ENRAPTURE_REMOVE, PROC_REF(destroy_component))

	living_target.setDir(get_vip_direction())

	RegisterSignal(living_target, COMSIG_LIVING_DIR_CHANGE, PROC_REF(set_dir_override))
	RegisterSignal(living_target, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))
	RegisterSignal(living_target, COMSIG_LIVING_DEATH, PROC_REF(destroy_component))

/datum/component/enraptured_npc/proc/get_vip_direction()
	return get_dir(get_turf(living_target), get_turf(vip))

/datum/component/enraptured_npc/proc/destroy_component()
	SIGNAL_HANDLER
	UnregisterSignal(living_target, list(COMSIG_LIVING_DIR_CHANGE, COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DEATH))
	UnregisterSignal(vip, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DEATH, COMSIG_COMPONENT_ENRAPTURE_REMOVE))
	UnregisterSignal(source_power, COMSIG_COMPONENT_ENRAPTURE_REMOVE)
	Destroy()

/datum/component/enraptured_npc/proc/check_range(datum/source)
	SIGNAL_HANDLER
	if(in_sight && ((get_dist(get_turf(vip), get_turf(living_target)) > 8) || !can_see(living_target, vip, 8)))
		UnregisterSignal(living_target, COMSIG_LIVING_DIR_CHANGE)
		in_sight = FALSE

	if(!in_sight && (get_dist(get_turf(vip), get_turf(living_target)) <= 8) && can_see(living_target, vip, 8))
		RegisterSignal(living_target, COMSIG_LIVING_DIR_CHANGE, PROC_REF(set_dir_override))
		in_sight = TRUE

	if(!in_sight)
		return

	var/atom/living_target_atom = living_target
	living_target_atom.setDir(get_vip_direction())

/datum/component/enraptured_npc/proc/set_dir_override(datum/source, dir, newdir)
	SIGNAL_HANDLER
	if(newdir != get_vip_direction())
		return COMPONENT_LIVING_DIR_CHANGE_BLOCK

/datum/component/enraptured_npc/CheckDupeComponent(datum/component, mob/living/new_vip, datum/discipline_power/vtr/new_source_power)
	if(!new_vip || !new_source_power)
		return TRUE

	if(SSroll.opposed_roll(
		vip,
		new_vip,
		dice_a = vip.get_total_charisma() + new_source_power.discipline.level,
		dice_b = new_vip.get_total_charisma() + source_power.discipline.level, 
		alert_atom = living_target,
		draw_goes_to_b = FALSE))
		return TRUE

	destroy_component()
	return FALSE