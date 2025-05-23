/turf/open/floor/plating/vampocean
	gender = PLURAL
	name = "water"
	icon = 'code/modules/wod13/tiles.dmi'
	icon_state = "ocean"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/vampocean/Initialize()
	..()
	set_light(1, 0.5, "#a4b7ff")


/turf/open/floor/plating/vampocean/Entered(atom/movable/AM)
	if(istype(AM, /mob) || istype(AM, /obj/item))
		SStides.send_to_shore(AM)