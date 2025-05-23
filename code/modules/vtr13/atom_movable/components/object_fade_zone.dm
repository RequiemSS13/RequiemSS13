
/*
	This component causes an attached object to fade when a mob is beneath it
	The area listed is a left-aligned box, offset by however many squares defined
	With no customization issued, the fade zone is just the square above the target
*/
/datum/component/object_fade_zone
	var/list/defined_areas = list()
	var/list/tracked_turfs = list()
	var/list/mobs_in_fade_zone = list()
	var/fade_zone_initialized = FALSE
	var/fade_strength
	var/initial_alpha
	var/initial_mouse_opacity
	var/mouse_opacity_interact
	var/obj_is_faded = TRUE

/datum/component/object_fade_zone/Initialize(fade_strength, mouse_opacity_interact)
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	var/atom/parent_atom = parent
	//you should only use this on naturally opaque objects.
	initial_alpha = parent_atom.alpha
	src.fade_strength = fade_strength
	src.mouse_opacity_interact = mouse_opacity_interact

	initial_mouse_opacity = parent_atom.mouse_opacity
	

	RegisterSignal(parent, COMSIG_ATOM_FADE_ZONE_ADD, PROC_REF(add_fade_zone_area))
	RegisterSignal(parent, COMSIG_ATOM_FADE_ZONE_EXISTS, PROC_REF(is_fade_zone_initialized))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(recalculate_fade_turfs))
	fade_zone_initialized = TRUE

/datum/component/object_fade_zone/proc/add_fade_zone_area(datum/source, size_x, size_y, offset_x, offset_y)
	SIGNAL_HANDLER
	defined_areas += list(list("size_x" = size_x, 
		"size_y" = size_y, 
		"offset_x" = offset_x, 
		"offset_y" = offset_y))
	recalculate_fade_turfs()

/datum/component/object_fade_zone/proc/is_fade_zone_initialized()
	SIGNAL_HANDLER
	return fade_zone_initialized

/datum/component/object_fade_zone/proc/recalculate_fade_turfs()
	SIGNAL_HANDLER
	var/list/old_tracked_turfs = tracked_turfs.Copy()
	tracked_turfs.Cut()
	mobs_in_fade_zone.Cut()
	var/atom/parent_atom = parent
	var/turf/parent_turf = parent_atom.loc
	//we are in nullspace or inside another object, time to remove tracking
	if(!parent_turf)
		for(var/key in old_tracked_turfs)
			UnregisterSignal(old_tracked_turfs[key], COMSIG_ATOM_ENTERED)
			UnregisterSignal(old_tracked_turfs[key], COMSIG_ATOM_EXITED)
		qdel(old_tracked_turfs)
		return
	
	for(var/list/fade_area in defined_areas)
		for(var/current_x in 0 to (fade_area["size_x"] - 1) )
			for(var/current_y in 0 to (fade_area["size_y"] - 1))

				var/turf/next_turf = locate(
					(parent_turf.x + fade_area["offset_x"] + current_x),
					(parent_turf.y + fade_area["offset_y"] + current_y),
					parent_turf.z)
				
				//if the turf was off the map or something
				if(!next_turf)
					continue
				
				if(tracked_turfs["[next_turf.x]-[next_turf.y]-[next_turf.z]"])
					continue
				tracked_turfs["[next_turf.x]-[next_turf.y]-[next_turf.z]"] = next_turf

	

	//unregister unneeded turfs
	for(var/key in old_tracked_turfs)
		if(!tracked_turfs[key])
			UnregisterSignal(old_tracked_turfs[key], COMSIG_ATOM_ENTERED)
			UnregisterSignal(old_tracked_turfs[key], COMSIG_ATOM_EXITED)

	//register only new turfs
	for(var/key in tracked_turfs)
		//add all living mobs present in our tracked turfs
		for(var/mob/living/living_mob in tracked_turfs[key])
			mobs_in_fade_zone += living_mob

		//Register new tracked turfs
		if(!old_tracked_turfs[key])
			RegisterSignal(tracked_turfs[key], COMSIG_ATOM_ENTERED, PROC_REF(check_enter))
			RegisterSignal(tracked_turfs[key], COMSIG_ATOM_EXITED, PROC_REF(check_exit))
	
	qdel(old_tracked_turfs)
	check_should_fade()

/datum/component/object_fade_zone/proc/check_enter(turf/source_turf, atom/movable/entering_atom)
	if(!isliving(entering_atom))
		return
	if(QDELETED(entering_atom))
		return
	if(!mobs_in_fade_zone.Find(entering_atom))
		mobs_in_fade_zone += entering_atom
		check_should_fade()

/datum/component/object_fade_zone/proc/check_exit(turf/source_turf, atom/movable/exiting_atom, atom/new_location)
	if(!isliving(exiting_atom))
		return

	if(QDELETED(exiting_atom))
		return
	
	if(isturf(new_location))
		var/turf/new_turf = new_location
		if(tracked_turfs["[new_turf.x]-[new_turf.y]-[new_turf.z]"])
			return
	
	if(mobs_in_fade_zone.Find(exiting_atom))
		mobs_in_fade_zone -= exiting_atom
		check_should_fade()

/datum/component/object_fade_zone/proc/check_should_fade()
	if(length(mobs_in_fade_zone))
		var/atom/parent_atom = parent
		if(mouse_opacity_interact && initial_mouse_opacity)
			parent_atom.mouse_opacity = 0
		if(!obj_is_faded)
			animate(parent_atom, alpha = (parent_atom.alpha - fade_strength), time = 5, flags = ANIMATION_PARALLEL)
		obj_is_faded = TRUE
	else
		var/atom/parent_atom = parent
		if(mouse_opacity_interact && initial_mouse_opacity)
			parent_atom.mouse_opacity = initial_mouse_opacity
		if(obj_is_faded)
			animate(parent_atom, alpha = (parent_atom.alpha + fade_strength), time = 5, flags = ANIMATION_PARALLEL)
		obj_is_faded = FALSE

/datum/component/object_fade_zone/Destroy()
	for(var/key in tracked_turfs)
		UnregisterSignal(tracked_turfs[key], COMSIG_ATOM_ENTERED)
		UnregisterSignal(tracked_turfs[key], COMSIG_ATOM_EXITED)
	
	UnregisterSignal(parent, COMSIG_ATOM_FADE_ZONE_ADD)
	UnregisterSignal(parent, COMSIG_ATOM_FADE_ZONE_EXISTS)
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)

	return ..()