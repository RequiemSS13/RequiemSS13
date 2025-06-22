/obj/item/travel_brochure
	name = "Travel Brochure (City Map)"
	desc = "A helpful Travel Brochure for exploring Long Beach"
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "pamphlet"
	lefthand_file = 'icons/mob/inhands/misc/books_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/books_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("baps")
	attack_verb_simple = list("bap")
	resistance_flags = FLAMMABLE
	var/activated = FALSE
	var/image/map
	var/image/pointer_overlay

/obj/item/travel_brochure/Initialize()
	. = ..()
	map = new /image('icons/vtr13/map.dmi', src, "map", ABOVE_NORMAL_TURF_LAYER)
	pointer_overlay = new /image('icons/vtr13/map_marker.dmi', src, "target", ABOVE_HUD_LAYER)

/obj/item/travel_brochure/attack_self(mob/user)
	. = ..()
	if(activated)
		return
	activated = TRUE
	to_chat(user, span_notice("You begin reading the map..."))
	if(!do_mob(user, user, 30)) //to prevent getflaticon spam
		return
	activated = FALSE
	
	var/render_pointer = TRUE
	if(!user.x || !user.y || user.x > 200 || user.x < 11 || user.y > 190)
		to_chat(user, span_notice("You're somewhere off the map."))
		render_pointer = FALSE
	if(render_pointer)
		pointer_overlay.pixel_x = (2.8*user.x)-60
		pointer_overlay.pixel_y = (2.8*user.y)+460
		map.overlays+=pointer_overlay
	var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909;
			}

			</style>
			"}
	dat += icon2html(getFlatIcon(map), user)
	if(render_pointer)
		map.overlays-=pointer_overlay
	user << browse(dat, "window=map;size=550x1130;border=1;can_resize=0;can_minimize=0")
	onclose(user, "map", src)
