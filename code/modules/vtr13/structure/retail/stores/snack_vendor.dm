/obj/structure/retail/snack_vendor
	name = "Snack Vendor"
	desc = "That candy bar better not get stuck this time..."
	icon_state = "vend_b"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	products_list = list(new /datum/data/retail_product("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/retail_product("chips",	/obj/item/food/vampire/crisps,	5)
	)
