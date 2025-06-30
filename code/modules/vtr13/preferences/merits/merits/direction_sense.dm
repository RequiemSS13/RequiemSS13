/datum/merit/direction_sense
	name = "Direction Sense"
	desc = "You have a map of the whole city in your head."
	dots = 1
	var/datum/action/minimap_button/minimap_button

/datum/merit/direction_sense/post_add()
	minimap_button = new(merit_holder, src)
	minimap_button.Grant(merit_holder)

/datum/merit/direction_sense/remove()
	minimap_button.Remove(merit_holder)

/datum/action/minimap_button
	name = "Minimap"
	desc = "Recall your mental image of Long Beach."
	button_icon_state = "minimap"
	check_flags = NONE
	var/activated = FALSE
	var/image/map
	var/image/pointer_overlay

/datum/action/minimap_button/New(Target, datum/component/base_memory/parent_component)
	..(Target)
	map = new /image('icons/vtr13/map.dmi', src, "map", ABOVE_NORMAL_TURF_LAYER)
	pointer_overlay = new /image('icons/vtr13/map_marker.dmi', src, "target", ABOVE_HUD_LAYER)

/datum/action/minimap_button/Trigger()
	if(activated)
		return
	activated = TRUE
	if(!do_mob(owner, owner, 3)) //to prevent getflaticon spam
		activated = FALSE
		return
	activated = FALSE
	var/render_pointer = TRUE
	if(!owner.x || !owner.y || owner.x > 200 || owner.x < 11 || owner.y > 190)
		to_chat(owner, span_notice("You're somewhere off the map."))
		render_pointer = FALSE
	else
		to_chat(owner, span_notice("You recall where you are."))
	if(render_pointer)
		pointer_overlay.pixel_x = (2.8*owner.x)-60
		pointer_overlay.pixel_y = (2.8*owner.y)+460
		map.overlays+=pointer_overlay
	var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909;
			}

			</style>
			"}
	dat += icon2html(getFlatIcon(map), owner)
	if(render_pointer)
		map.overlays-=pointer_overlay
	owner << browse(dat, "window=map;size=550x550;border=1;can_resize=0;can_minimize=0")
	onclose(owner, "map", src)