/*
	Set an object to turn transparant and be clickable if a mob is in a given nearby tile.
	fade_strength only applies for the first time this is used. All subsequent fade zones inherit it.
*/
/atom/proc/add_object_fade_zone(size_x = 1, size_y = 1, offset_x = 0, offset_y = 1, fade_strength = 100, mouse_opacity_interact = TRUE)
	if(!size_x || size_x < 0 || !size_y || size_y < 0)
		return

	if(!SEND_SIGNAL(src, COMSIG_ATOM_FADE_ZONE_EXISTS))
		AddComponent(/datum/component/object_fade_zone, fade_strength, mouse_opacity_interact)
	SEND_SIGNAL(src, COMSIG_ATOM_FADE_ZONE_ADD, size_x, size_y, offset_x, offset_y)