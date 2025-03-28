/datum/component/ambiance_memory
	var/list/areas_entered
	var/mob/current

/datum/component/ambiance_memory/Initialize()
	if(!istype(parent, /datum/mind))
		return COMPONENT_INCOMPATIBLE
	var/datum/mind/brain = parent
	if(!brain.current)
		return COMPONENT_INCOMPATIBLE
	current = brain.current
	RegisterSignal(current, COMSIG_ENTER_AREA, PROC_REF(check_ambiance_description))
	RegisterSignal(parent, COMSIG_MIND_TRANSFERRED, PROC_REF(register_new_mob))


/datum/component/ambiance_memory/proc/register_new_mob(datum/source, mob/new_mob)
	UnregisterSignal(current, COMSIG_ENTER_AREA)
	RegisterSignal(new_mob, COMSIG_ENTER_AREA, PROC_REF(check_ambiance_description))
	current = new_mob

/datum/component/ambiance_memory/proc/check_ambiance_description(datum/source, area/area_entered)
	SIGNAL_HANDLER
	if(!area_entered || LAZYFIND(areas_entered, area_entered.type))
		return
	if(!istype(area_entered, /area/vtm/vtr))
		return	
	if(current.stat >= HARD_CRIT || current.is_blind())
		return
	if(isliving(current))
		var/mob/living/current_living = current
		if(current_living.IsSleeping() || current_living.IsUnconscious())
			return
	if(!current.mind)
		CRASH("SOMEHOW, a mindless mob is registered to the ambiance_memory signal!")
	
	LAZYADD(areas_entered, area_entered.type)
	var/area/vtm/vtr/ambiance_area_entered = area_entered
	if(!ambiance_area_entered.ambiance_message)
		return
	to_chat(current, span_boldwarning("[ambiance_area_entered.ambiance_message]"))