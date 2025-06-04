/obj/structure/retail/drink_vendor
	name = "Drink Vendor"
	desc = "Order drinks here."
	icon = 'icons/wod13/props.dmi'
	icon_state = "vend_r"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	products_list = list(
		new /datum/data/retail_product("cola",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	10),
		new /datum/data/retail_product("soda", /obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda, 5)
	)
