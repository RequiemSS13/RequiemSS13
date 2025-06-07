/obj/structure/column
	name = "column"
	desc = "A sturdy-looking Corinthian column."
	icon = 'icons/vtr13/structure/columns.dmi'
	icon_state ="corinthian"
	layer = ABOVE_ALL_MOB_LAYER
	density = 1
	anchored = TRUE


/obj/structure/column/ComponentInitialize()
	add_object_fade_zone(1,1,0,1)