/atom
	var/image/meatworld_image

/datum/component/meatworld_component
	var/list/tracked_meat = list()
	var/client/ourclient

/datum/component/meatworld_component/Initialize()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/parent_living = parent
	if(!parent_living.client)
		return COMPONENT_INCOMPATIBLE
	ourclient = parent_living.client
	
	RegisterSignal(parent_living, COMSIG_MOVABLE_MOVED, PROC_REF(update_meatworld))
	RegisterSignal(parent_living, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(stop_abilities))
	RegisterSignal(parent_living, COMSIG_MEATWORLD_REMOVE_COMPONENT, PROC_REF(destroy_meatworld))
	
	update_meatworld(parent_living)

/datum/component/meatworld_component/proc/stop_abilities()
	var/mob/living/parent_living = parent
	to_chat(parent_living, span_danger("The Beast Cowers; your Disciplines are deafened by your own terror!"))
	return POWER_CANCEL_ACTIVATION

/datum/component/meatworld_component/proc/destroy_meatworld()
	Destroy()

/datum/component/meatworld_component/proc/update_meatworld(datum/source)
	SIGNAL_HANDLER
	if(ourclient.mob != source)
		Destroy()
		return

	var/list/new_meat = list()
	for(var/atom/a_atom in range(8, ourclient.mob))
		if(istype(a_atom, /turf/open/floor))
			if(!a_atom.meatworld_image)
				a_atom.meatworld_image = image('icons/vtr13/hud/meatworld.dmi', a_atom, "tzimisce_floor" , CULT_OVERLAY_LAYER)
			new_meat += a_atom
		else if(istype(a_atom, /turf/closed/wall))
			if(!a_atom.meatworld_image)
				a_atom.meatworld_image = image('icons/vtr13/hud/meatworld.dmi', a_atom, "fleshwall" , CLOSED_TURF_LAYER)
			new_meat += a_atom
		else if(istype(a_atom, /obj/effect/addwall))
			if(!a_atom.meatworld_image)
				a_atom.meatworld_image = image('icons/vtr13/hud/meatworld.dmi', a_atom, "fleshwall_addwall" , ABOVE_ALL_MOB_LAYERS_LAYER)
			new_meat += a_atom
		else if(istype(a_atom, /obj/effect/decal/wallpaper))
			if(!a_atom.meatworld_image)
				a_atom.meatworld_image = image('icons/vtr13/hud/meatworld.dmi', a_atom, "wallpaper-necro" , ABOVE_NORMAL_TURF_LAYER)
			new_meat += a_atom
	
	new_meat.Remove(tracked_meat)
	
	for(var/atom/new_meat_atom in new_meat)
		ourclient.images |= new_meat_atom.meatworld_image
	
	tracked_meat.Add(new_meat)

/datum/component/meatworld_component/UnregisterFromParent()
	for(var/atom/delete_meat_atom in tracked_meat)
		ourclient.images -= delete_meat_atom.meatworld_image