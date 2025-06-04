
/obj/effect/decal/coastline
	name = "water"
	icon = 'icons/wod13/tiles.dmi'
	icon_state = "coastline"

/obj/effect/decal/coastline/corner
	icon_state = "coastline_corner"

/obj/effect/decal/coastline/New()
	SStides.coastline_turfs += get_turf(src)