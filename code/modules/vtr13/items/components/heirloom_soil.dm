/datum/component/heirloom_soil
	var/mob/living/owner
	can_transfer = TRUE

/datum/component/heirloom_soil/Initialize(mob/owner)
	. = ..()

	src.owner = owner
	if (!isobj(parent))
		return COMPONENT_INCOMPATIBLE
	if(!isliving(owner))
		return COMPONENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_PARENT_QDELETING, PROC_REF(handle_soil_destroyed))
	RegisterSignal(owner, COMSIG_PARENT_QDELETING, PROC_REF(handle_owner_destroyed))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(handle_soil_moved))
	handle_soil_moved()

/datum/component/heirloom_soil/PreTransfer()
	UnregisterSignal(parent, COMSIG_PARENT_QDELETING)
	UnregisterSignal(parent, COMSIG_MOVABLE_MOVED)

/datum/component/heirloom_soil/PostTransfer()
	RegisterSignal(parent, COMSIG_PARENT_QDELETING, PROC_REF(handle_soil_destroyed))
	RegisterSignal(parent, COMSIG_MOVABLE_MOVED, PROC_REF(handle_soil_moved))
	handle_soil_moved()


/datum/component/heirloom_soil/proc/handle_soil_moved()
	SIGNAL_HANDLER
	var/list/atom/movable/mob_contents = owner.GetAllContents()
	if (mob_contents.Find(parent))
		STOP_PROCESSING(SSdcs, src)
		var/mob/living/lacking_soil = owner
		lacking_soil.remove_movespeed_modifier(/datum/movespeed_modifier/dirtless)
	else
		START_PROCESSING(SSdcs, src)

/datum/component/heirloom_soil/process(delta_time)
	var/mob/living/lacking_soil = owner
	if(get_dist(get_turf(owner), get_turf(parent)) < 5)
		if(lacking_soil.has_movespeed_modifier(/datum/movespeed_modifier/dirtless))
			lacking_soil.remove_movespeed_modifier(/datum/movespeed_modifier/dirtless)
	else if(!lacking_soil.has_movespeed_modifier(/datum/movespeed_modifier/dirtless))
		lacking_soil.add_movespeed_modifier(/datum/movespeed_modifier/dirtless)
		to_chat(lacking_soil, span_warning("You are missing your home soil. Being without it weakens you..."))

	

/datum/component/heirloom_soil/proc/handle_owner_destroyed()
	SIGNAL_HANDLER
	qdel(src)

/datum/component/heirloom_soil/proc/handle_soil_destroyed()
	SIGNAL_HANDLER
	if(QDELETED(owner))
		return
	// Deal 25% of their health in clone damage and reduce their bloodpool size by 3, to a minimum of 5
	var/mob/living/lacking_soil = owner
	lacking_soil.add_movespeed_modifier(/datum/movespeed_modifier/dirtless)

	to_chat(lacking_soil, span_danger("Your home soil has been destroyed! Its loss debilitates you."))

	qdel(src)

/datum/movespeed_modifier/dirtless
	multiplicative_slowdown = 5