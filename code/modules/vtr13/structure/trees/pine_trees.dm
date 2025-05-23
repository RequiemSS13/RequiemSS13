/obj/structure/vamptree/pine
	name = "pine"
	desc = "Cute and tall flora."
	icon = 'code/modules/wod13/pines.dmi'
	icon_state = "pine1"
	plane = GAME_PLANE
	layer = SPACEVINE_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -24
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/vamptree/pine/Initialize()
	. = ..()
	icon_state = "pine[rand(1, 4)]"
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "pine[rand(1, 4)]-snow"
	if(prob(2))
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"

/obj/structure/vamptree/pine/ComponentInitialize()
	switch(icon_state)
		if("pine1", "pine1-snow")
			add_object_fade_zone(3,8,-1,0)
		if("pine2", "pine2-snow")
			add_object_fade_zone(3,7,-1,0)
		if("pine3", "pine4", "pine3-snow", "pine4-snow")
			add_object_fade_zone(3,6,-1,0)
		if("dead1", "dead2", "dead3")
			add_object_fade_zone(3,7,-1,0)

/obj/structure/vamptree/pine/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"