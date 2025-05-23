/turf/open/water/la_river
	name = "water"
	desc = "Shallow water."
	icon = 'icons/vtr13/turf/river.dmi'
	icon_state = "riverwater_motion"

/turf/open/water/la_river/Initialize()
	..()
	set_light(1, 1, "#a4b7ff")