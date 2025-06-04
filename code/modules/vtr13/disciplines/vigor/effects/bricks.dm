/obj/effect/decal/bricks
	name = "bricks"
	icon = 'icons/wod13/props.dmi'
	icon_state = "trash19"

/obj/effect/decal/bricks/Initialize()
	. = ..()
	icon_state = "trash[rand(19, 24)]"