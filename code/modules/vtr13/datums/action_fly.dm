/datum/action/fly_upper
	name = "Fly Up"
	desc = "Fly to the upper level."
	button_icon_state = "fly"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/last_acrobate = 0

/datum/action/fly_upper/Trigger()
	if(last_acrobate+15 > world.time)
		return
	
	if(!(owner.movement_type & FLYING))
		to_chat(src, span_notice("You must be flying to go up."))
		return
	var/target_turf = get_step_multiz(owner, UP)
	if(target_turf)
		if(istype(get_step_multiz(owner, UP), /turf/open/openspace))
			animate(owner, pixel_y = 32, time = 20)
			if(do_mob(owner, owner, 2 SECONDS))
				owner.forceMove(target_turf)
			animate(owner, pixel_y = 0, time = 0)

/datum/action/fly_downer
	name = "Fly Down"
	desc = "Fly to the lower level."
	button_icon_state = "fly"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/last_acrobate = 0

/datum/action/fly_downer/Trigger()
	owner.down()