/datum/component/summon_dial
	dupe_mode = COMPONENT_DUPE_SELECTIVE
	var/datum/discipline_power/vtr/source_power
	var/atom/movable/screen/dial
	var/current_angle
	var/current_destination
	var/turf/final_destination //no items, fox only
	var/obj/effect/decal/summon_marker/marker
	var/no_clear_path = FALSE
	var/notified_floor = FALSE
	var/notified

/datum/component/summon_dial/Initialize(turf/destination, mob/living/owner, datum/discipline_power/vtr/new_source_power)
	source_power = new_source_power
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/parent_mob = parent
	if(!parent_mob.mind || !parent_mob.client)
		return COMPONENT_INCOMPATIBLE



	to_chat(parent_mob, span_userdanger("You are called to [destination.loc]. You must go."))
	parent_mob.add_client_colour(/datum/client_colour/glass_colour/red)
	
	//initialize dial
	dial = new /atom/movable/screen/summon_arrow()
	parent_mob.client.screen += dial

	
	var/list/current_destination_targets = SSarea_grouper.get_directions_to_point(get_turf(parent_mob), destination)
	if(!current_destination_targets)
		#ifdef AREA_GROUPER_DEBUGGING
		to_chat(parent_mob, "Could not find traversable path to destination, reverting to pathless arrow directions.")
		#endif
		current_destination = destination
		no_clear_path = TRUE
	else
		current_destination = current_destination_targets[1]
	final_destination = destination

	reset_dial()
	
	//initialize destination marker
	marker = new /obj/effect/decal/summon_marker(destination, owner, parent)

	ADD_TRAIT(parent, TRAIT_MUTE, MAJESTY_5_TRAIT)
	ADD_TRAIT(parent, TRAIT_DEAF, MAJESTY_5_TRAIT)

	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(adjust_dial))
	RegisterSignal(parent, COMSIG_MOB_PRE_EMOTED, PROC_REF(no_emotes_actually))
	RegisterSignal(parent, list(COMSIG_MOVABLE_Z_CHANGED, COMSIG_ATOM_MOVABLE_TRANSFER_POINT_USE), PROC_REF(recalculate_directions))

	if(source_power)
		RegisterSignal(source_power, COMSIG_MAJESTY_5_END, PROC_REF(determine_remove_dial))

/datum/component/summon_dial/proc/reset_dial()
	current_angle = Get_Angle(get_turf(parent), current_destination)
	animate(dial, transform = turn(matrix(), current_angle), time = 0, flags = ANIMATION_END_NOW)
	


/datum/component/summon_dial/proc/adjust_dial()
	if(get_turf(parent) == final_destination)
		remove_dial()
		return
	

	//Handling when we can't get a path matrix
	if(no_clear_path)
		if(notified_floor)
			return
		var/turf/current_turf = get_turf(parent)
		if(!get_dist(current_turf, final_destination) < 60)
			return
		var/floor_delta = final_destination.z - current_turf.z
		to_chat(parent, span_userdanger("You feel that your destination is [!floor_delta ? "on the same floor as you." : (floor_delta) < 0 ? "[-1 * floor_delta] floors below you." : "[floor_delta] floors above you." ]"))
		notified_floor = TRUE
		return

	var/new_angle = Get_Angle(get_turf(parent), current_destination)
#ifdef AREA_GROUPER_DEBUGGING
	to_chat(parent, "old angle: [current_angle], new angle: [new_angle], angle_diff=[new_angle - current_angle]")
#endif
	if(new_angle - current_angle != 0)
		animate(dial, transform = turn(dial.transform, new_angle - current_angle), time = 5)
		current_angle = new_angle

/datum/component/summon_dial/proc/recalculate_directions()
	if(no_clear_path)
		return

	var/list/current_destination_targets = SSarea_grouper.get_directions_to_point(get_turf(parent), final_destination)
	if(!current_destination_targets)
		current_destination = final_destination
	else
		current_destination = current_destination_targets[1]
	reset_dial()

/datum/component/summon_dial/proc/determine_remove_dial(datum/source, mob/victim)
	if(victim == parent)
		remove_dial()

/datum/component/summon_dial/proc/remove_dial()
	SIGNAL_HANDLER
	var/mob/living/parent_mob = parent
	parent_mob.hud_used.static_inventory -= dial
	parent_mob.remove_client_colour(/datum/client_colour/glass_colour/red)
	to_chat(parent_mob, span_userdanger("The urge to go to [final_destination.loc] fades."))
	REMOVE_TRAIT(parent_mob, TRAIT_MUTE, MAJESTY_5_TRAIT)
	REMOVE_TRAIT(parent_mob, TRAIT_DEAF, MAJESTY_5_TRAIT)
	UnregisterSignal(parent, list(COMSIG_MOVABLE_MOVED, COMSIG_MOB_PRE_EMOTED, COMSIG_MOVABLE_Z_CHANGED, COMSIG_ATOM_MOVABLE_TRANSFER_POINT_USE))
	UnregisterSignal(source_power, COMSIG_MAJESTY_5_END)
	if(parent_mob.client)
		parent_mob.client.screen -= dial
	qdel(dial)
	del(marker)
	Destroy()

/datum/component/summon_dial/proc/no_emotes_actually()
	return COMPONENT_CANT_EMOTE