/obj/structure/retail/coffee_vendor
	name = "Coffee Vendor"
	desc = "For those sleepy mornings."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "vend_g"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	products_list = list(new /datum/data/retail_product("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	10),
		new /datum/data/retail_product("strong coffee", /obj/item/reagent_containers/food/drinks/coffee/vampire/robust, 5)
	)
