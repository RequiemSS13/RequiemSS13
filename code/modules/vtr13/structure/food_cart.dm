/obj/food_cart
	name = "food cart"
	desc = "Ding-aling ding dong. Get your cholesterol!"
	icon = 'code/modules/wod13/32x48.dmi'
	icon_state = "vat1"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER

/obj/food_cart/Initialize()
	. = ..()
	icon_state = "vat[rand(1, 3)]"

/obj/food_cart/ComponentInitialize()
	add_object_fade_zone(1,1,0,1)