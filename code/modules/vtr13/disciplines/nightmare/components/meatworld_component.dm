#define HUD_LIST_MEATWORLD "meatworld"

//Component that replaces all turfs and wallpapers with horrifying meat alternatives
/datum/component/meatworld_component
	var/list/tracked_meat = list()
	var/client/ourclient

/datum/component/meatworld_component/Initialize(datum/source)
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	var/mob/living/parent_living = parent
	if(!parent_living.client)
		return COMPONENT_INCOMPATIBLE
	ourclient = parent_living.client
	
	RegisterSignal(parent_living, COMSIG_MOVABLE_MOVED, PROC_REF(update_meatworld))
	RegisterSignal(parent_living, COMSIG_POWER_PRE_ACTIVATION, PROC_REF(stop_abilities))
	RegisterSignal(source, COMSIG_POWER_DEACTIVATE, PROC_REF(destroy_meatworld))
	
	update_meatworld(parent_living)

/datum/component/meatworld_component/proc/stop_abilities()
	SIGNAL_HANDLER
	var/mob/living/parent_living = parent
	to_chat(parent_living, span_danger("The Beast Cowers; your Disciplines are deafened by your own terror!"))
	return POWER_CANCEL_ACTIVATION

/datum/component/meatworld_component/proc/destroy_meatworld()
	SIGNAL_HANDLER
	Destroy()

/datum/component/meatworld_component/proc/update_meatworld(datum/source)
	SIGNAL_HANDLER
	if(ourclient.mob != source)
		Destroy()
		return

	var/list/new_meat = list()
	for(var/atom/a_atom in range(8, ourclient.mob))

		if(!a_atom.hud_list)
			a_atom.hud_list = list()

		if(istype(a_atom, /turf/open/floor))
			if(!a_atom.hud_list[HUD_LIST_MEATWORLD])
				a_atom.hud_list[HUD_LIST_MEATWORLD] = image('icons/vtr13/hud/meatworld.dmi', a_atom, "tzimisce_floor" , CULT_OVERLAY_LAYER)
				a_atom.hud_list[HUD_LIST_MEATWORLD].appearance_flags|=TILE_BOUND
			new_meat += a_atom.hud_list[HUD_LIST_MEATWORLD]
		else if(istype(a_atom, /turf/closed/wall))
			if(!a_atom.hud_list[HUD_LIST_MEATWORLD])
				a_atom.hud_list[HUD_LIST_MEATWORLD] = image('icons/vtr13/hud/meatworld.dmi', a_atom, "fleshwall" , CLOSED_TURF_LAYER)
				a_atom.hud_list[HUD_LIST_MEATWORLD].appearance_flags|=TILE_BOUND
			new_meat += a_atom.hud_list[HUD_LIST_MEATWORLD]
		else if(istype(a_atom, /obj/effect/addwall))
			if(!a_atom.hud_list[HUD_LIST_MEATWORLD])
				a_atom.hud_list[HUD_LIST_MEATWORLD] = image('icons/vtr13/hud/meatworld.dmi', a_atom, "fleshwall_addwall" , ABOVE_ALL_MOB_LAYERS_LAYER)
				a_atom.hud_list[HUD_LIST_MEATWORLD].appearance_flags|=TILE_BOUND
			new_meat += a_atom.hud_list[HUD_LIST_MEATWORLD]
		else if(istype(a_atom, /obj/effect/decal/wallpaper))
			if(!a_atom.hud_list[HUD_LIST_MEATWORLD])
				a_atom.hud_list[HUD_LIST_MEATWORLD] = image('icons/vtr13/hud/meatworld.dmi', a_atom, "wallpaper-necro" , ABOVE_NORMAL_TURF_LAYER)
				a_atom.hud_list[HUD_LIST_MEATWORLD].appearance_flags|=TILE_BOUND
			new_meat += a_atom.hud_list[HUD_LIST_MEATWORLD]
	
	new_meat.Remove(tracked_meat)
	
	for(var/image/new_meat_image in new_meat)
		ourclient.images |= new_meat_image
	

	tracked_meat.Add(new_meat)

	qdel(new_meat)
	//Try to implment some rudimentary atom removal
	if(tracked_meat.len >= 1000)
		var/list/delete_meat = tracked_meat.Copy(1, (tracked_meat.len - 900))
		tracked_meat.Cut(1, (tracked_meat.len - 900))
		for(var/image/delete_meat_image in delete_meat)
			ourclient.images -= delete_meat_image
		qdel(delete_meat)

/datum/component/meatworld_component/UnregisterFromParent()
	for(var/image/delete_meat_image in tracked_meat)
		ourclient.images -= delete_meat_image

#undef HUD_LIST_MEATWORLD