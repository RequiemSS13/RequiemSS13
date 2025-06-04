/obj/cargotruck
	name = "cargo truck"
	desc = "It delivers a lot of things."
	icon = 'icons/wod13/cars.dmi'
	icon_state = "track"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB | PASSGLASS | PASSCLOSEDTURF
	movement_type = PHASING
	var/mob/living/starter

/obj/cargotruck/Initialize()
	. = ..()
	pixel_y = -16


/obj/cargotruck/Moved(atom/OldLoc, Dir, Forced = FALSE)
	for(var/obj/machinery/door/blocking_door in get_step(src, Dir))
		if(blocking_door.density)
			blocking_door.density = 0
			qdel(blocking_door)
			for(var/mob/mob in range(9, src))
				shake_camera(mob, 7, 3)
			playsound(get_turf(src), 'code/modules/wod13/sounds/werewolf_fall.ogg', 80, 9)
			src.visible_message(span_boldwarning("The cargo truck bursts through the shutters! Fucking asshole!"))

	for(var/mob/living/L in get_step(src, Dir))
		L.Knockdown(3 SECONDS)
		L.apply_damage(50, BRUTE)
		src.visible_message(span_boldwarning("The cargo truck runs over [L]!"))
	..()
