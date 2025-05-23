/obj/structure/longbeach_map
	name = "\improper map"
	desc = "Locate yourself now."
	icon = 'icons/vtr13/structure/signs.dmi'
	icon_state = "map"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE
	
	var/icon/map_loc

/obj/structure/longbeach_map/Initialize()
	. = ..()
	var/image/map = new /image('icons/vtr13/map.dmi', src, "map", ABOVE_NORMAL_TURF_LAYER)
	var/image/pointer_overlay = new /image('icons/vtr13/map_marker.dmi', src, "target", ABOVE_HUD_LAYER)
	pointer_overlay.pixel_x = (2.8*x)-60
	pointer_overlay.pixel_y = (2.8*y)+390
	map.overlays+=pointer_overlay
	map_loc = getFlatIcon(map)
	qdel(map)
	qdel(pointer_overlay)

/obj/structure/longbeach_map/attack_hand(mob/user)
	. = ..()
	var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909;
			}

			</style>
			"}
	dat += icon2html(map_loc, user)
	user << browse(dat, "window=map;size=550x1060;border=1;can_resize=0;can_minimize=0")
	onclose(user, "map", src)

