/mob/living/carbon/human/proc/climb_wall(turf/above_turf)
	if(body_position != STANDING_UP || HAS_TRAIT(src, TRAIT_LEANING))
		return
	if(above_turf && istype(above_turf, /turf/open/openspace))
		var/total_dexterity = get_total_dexterity()
		var/total_athletics = get_total_athletics()
		var/has_gecko_grip = HAS_TRAIT(src, TRAIT_GECKO_GRIP) && !gloves
		if(has_gecko_grip)
			to_chat(src, span_notice("You scuttle up the wall unnaturally quick!"))
		else
			to_chat(src, span_notice("You start climbing up..."))
			var/climb_time = 50 - (total_dexterity + total_athletics * 5)
			animate(src, pixel_y = 32, time = climb_time)
			var/result = do_after(src, climb_time, src)
			if(!result)
				to_chat(src, span_warning("You were interrupted and failed to climb up."))
				animate(src, pixel_y = 0, time = 0)
				return
      
			animate(src, pixel_y = 0, time = 0)

		var/success = ROLL_FAILURE
		if(has_gecko_grip)
			success = ROLL_SUCCESS
		else
			success = SSroll.storyteller_roll(total_athletics, 6 , alert_atom=src)

		if(success == ROLL_SUCCESS)
			loc = above_turf
			var/turf/forward_turf = get_step(loc, dir)
			if(forward_turf && !forward_turf.density)
				forceMove(forward_turf)
				to_chat(src, span_notice("You climb up successfully."))
			else if(has_gecko_grip)
				forceMove(above_turf)
				to_chat(src, span_notice("You climb up and cling to the wall!."))
		else if(success == ROLL_BOTCH)
			ZImpactDamage(loc, 1)
			to_chat(src, span_warning("You slip while climbing!"))
		else
			to_chat(src, span_warning("You fail to climb up."))
	return


/mob/living/carbon/human/proc/climb_down(turf/open/openspace/target_turf)
	if(body_position != STANDING_UP)
		return
	to_chat(src, "<span class='notice'>You start climbing down...</span>")

	var/result = do_after(src, 10, 0)
	if(!result)
		to_chat(src, "<span class='warning'>You were interrupted and failed to climb down.</span>")
		return

	var/initial_x = x
	var/initial_y = y
	var/initial_z = z

	// Ensure the player hasn't moved during the action
	if(x != initial_x || y != initial_y || z != initial_z)
		to_chat(src, "<span class='warning'>You moved and failed to climb down.</span>")
		return

	if(target_turf && istype(target_turf, /turf/open/openspace))
		var/turf/final_turf = locate(target_turf.x, target_turf.y, z - 1) // Find the turf directly below the open space
		if(final_turf && final_turf.density == FALSE)
			loc = final_turf // Move the player to the new turf one z-level down
			to_chat(src, "<span class='notice'>You climb down successfully.</span>")
		else
			to_chat(src, "<span class='warning'>You fail to find a safe spot to climb down.</span>")
	else
		to_chat(src, "<span class='warning'>You fail to find a valid open space to climb down.</span>")

	return