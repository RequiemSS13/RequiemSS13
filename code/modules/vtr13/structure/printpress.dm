/obj/structure/print_press
	name = "newspaper printer"
	desc = "An industrial printing press. Tomorrow's headlines, tonight!"
	icon = 'icons/wod13/64x32.dmi'
	icon_state ="printpress"
	density = 1
	anchored = TRUE
	bound_width = 64
	bound_height = 32
	layer = ABOVE_ALL_MOB_LAYER
	var/datum/looping_sound/printpress/soundloop
	var/on = FALSE
	var/initial_icon = ""


/obj/structure/print_press/large
	icon = 'icons/vtr13/structure/160x48.dmi'
	icon_state ="printpress_large"
	bound_width = 128
	bound_height = 32

/obj/structure/print_press/Initialize()
	. = ..()
	initial_icon = icon_state
	soundloop = new(list(src), FALSE)

/obj/structure/print_press/attack_hand(mob/user)
	if (on == FALSE)
		icon_state = icon_state + "_on"
		soundloop.start()
		on = TRUE
	else
		icon_state = initial_icon
		soundloop.stop()
		on = FALSE
