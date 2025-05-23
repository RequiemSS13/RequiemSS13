/obj/structure/vamptree/palmtree
	name = "palm tree"
	desc = "Radical."
	icon = 'icons/vtr13/structure/trees.dmi'
	icon_state = "palm1"

/obj/structure/vamptree/palmtree/Initialize()
	. = ..()
	icon_state = "palm[rand(1, 2)]"
	if(prob(50))
		var/matrix/flip_matrix = matrix()
		flip_matrix.Scale(-1, 1)
		src.transform = flip_matrix

	//winter sprite changes deliberately not included


/obj/structure/vamptree/palmtree/ComponentInitialize()
	add_object_fade_zone(1,2,0,1)
	add_object_fade_zone(3,2,-1,3)

/obj/structure/vamptree/palmtree/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead"