/atom/movable/screen/summon_arrow
	name = "Summon Arrow"
	icon = 'icons/vtr13/effect/summon_arrow.dmi'
	icon_state = "arrow"
	layer = HUD_LAYER
	plane = HUD_PLANE


/atom/movable/screen/summon_arrow/New()
	. = ..()
#ifdef AREA_GROUPER_DEBUGGING
	icon_state = "arrow_debug"
#endif
	src.screen_loc = "CENTER,CENTER-2"
	src.update_icon()