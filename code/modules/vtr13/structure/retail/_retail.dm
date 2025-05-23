GLOBAL_LIST_EMPTY(retail_products)

/obj/structure/retail
	name = "retail outlet"
	desc = "A counter for partaking in wretched capitalism. Takes cash or card."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "menu"
	density = FALSE
	anchored = TRUE
	var/owner_needed = TRUE //Does an npc need to be here for this
	var/mob/living/carbon/human/npc/my_owner //tracks existence of owner
	var/is_gun_store = FALSE

	var/list/products_list = list(
		new /datum/data/retail_product("Plain Donut", /obj/item/food/donut/plain, 5),
		new /datum/data/retail_product("Plain Jelly Donut", /obj/item/food/donut/jelly/plain, 5),
		new /datum/data/retail_product("Berry Donut", /obj/item/food/donut/berry, 5),
		new /datum/data/retail_product("Frosted Jelly Donut", /obj/item/food/donut/jelly/berry, 5),
		new /datum/data/retail_product("Purple Donut", /obj/item/food/donut/trumpet, 5),
		new /datum/data/retail_product("Frosted Purple-Jelly Donut", /obj/item/food/donut/jelly/trumpet, 5),
		new /datum/data/retail_product("Apple Donut", /obj/item/food/donut/apple, 5),
		new /datum/data/retail_product("Apple Jelly Donut", /obj/item/food/donut/jelly/apple, 5),
		new /datum/data/retail_product("Caramel Donut", /obj/item/food/donut/caramel, 5),
		new /datum/data/retail_product("Caramel Jelly Donut", /obj/item/food/donut/jelly/caramel, 5),
		new /datum/data/retail_product("Chocolate Donut", /obj/item/food/donut/choco, 5),
		new /datum/data/retail_product("Chocolate Custard Donut", /obj/item/food/donut/jelly/choco, 5),
		new /datum/data/retail_product("Matcha Donut", /obj/item/food/donut/matcha, 5),
		new /datum/data/retail_product("Matcha Jelly Donut", /obj/item/food/donut/jelly/matcha, 5),
		new /datum/data/retail_product("Blueberry Muffin", /obj/item/food/muffin/berry, 8),
	)

/obj/structure/retail/Initialize()
	. = ..()
	if(owner_needed == TRUE)
		for(var/mob/living/carbon/human/npc/NPC in range(2, src))
			if(NPC)
				my_owner = NPC
	build_inventory()


/obj/structure/retail/attackby(obj/item/I, mob/user, params)
	. = ..()
	ui_interact(user)

/obj/structure/retail/proc/build_inventory()
	for(var/datum/data/retail_product/product in products_list)
		if(!product)
			CRASH("Null retail product loaded in initialization of [src]. This should not happen!")
		GLOB.retail_products[product.equipment_path] = 1

/obj/structure/retail/ui_assets(mob/user)
	return list(
		get_asset_datum(/datum/asset/spritesheet/retail),
	)

/obj/structure/retail/ui_interact(mob/user, datum/tgui/ui)
	if(owner_needed == TRUE)
		if(!my_owner)
			return
		if(get_dist(src, my_owner) > 4)
			return
		if(my_owner.stat >= HARD_CRIT)
			return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "RetailVendor", name)
		ui.open()

/obj/structure/retail/ui_static_data(mob/user)
	. = list()
	.["product_records"] = list()
	for(var/datum/data/retail_product/product in products_list)
		var/list/product_data = list(
			path = replacetext(replacetext("[product.equipment_path]", "/obj/item/", ""), "/", "-"),
			name = product.equipment_name,
			price = product.cost,
			dimensions = product.icon_dimension,
			ref = REF(product)
		)
		.["product_records"] += list(product_data)

/obj/structure/retail/ui_data(mob/user)
	. = list()
	.["user"] = list()
	.["user"]["money"] = 0
	.["user"]["is_card"] = 0

	var/list/held_items = list()
	if(user.get_active_held_item())
		held_items += user.get_active_held_item()
	if(user.get_inactive_held_item())
		held_items += user.get_inactive_held_item()
	
	for(var/obj/item/held_item in held_items)
		if(istype(held_item, /obj/item/vamp/creditcard))
			.["user"]["is_card"] = 1
			.["user"]["payment_item"] = REF(held_item)
			break
		if(istype(held_item, /obj/item/stack/dollar))
			var/obj/item/stack/dollar/money = held_item
			.["user"]["money"] = money.amount
			.["user"]["payment_item"] = REF(held_item)
			break
	qdel(held_items)
	return

/obj/structure/retail/ui_act(action, params)
	. = ..()
	if(.)
		return

	if(owner_needed == TRUE && (!my_owner || (get_dist(src, my_owner) > 4) || (my_owner.stat >= HARD_CRIT)))
		to_chat(usr, span_alert("There's no teller here to sell you things..."))
		return

	switch(action)
		if("purchase")
			if(!isliving(usr))
				return
			var/mob/living/user = usr

			var/datum/data/retail_product/product = locate(params["ref"]) in products_list
			if(!product)
				to_chat(usr, span_alert("Error: Invalid choice!"))
				return
			
			var/obj/item/held_item = locate(params["payment_item"]) in user
			if(!product)
				to_chat(usr, span_alert("Error: Payment method not found!"))
				return

			
			//get the money
			if(istype(held_item, /obj/item/vamp/creditcard))
				var/obj/item/vamp/creditcard/creditcard = held_item
				var/datum/vtr_bank_account/used_account = creditcard.account
				if(!used_account)
					to_chat(user, span_alert("The [creditcard] has no linked account."))
					return
				if(!used_account.check_pin(user, product.cost, creditcard))
					return
				if(!used_account.modify_balance(product.cost, user))
					return
				used_account.process_credit_fraud(user, product.cost)

			else if(istype(held_item, /obj/item/stack/dollar) && !held_item.use(product.cost))
				to_chat(user, span_alert("You don't have enough money in your hand."))
				return
			playsound(get_turf(src), 'sound/effects/cashregister.ogg', 50, TRUE)
			new product.equipment_path(loc)
			SSblackbox.record_feedback("nested tally", "retail_item_bought", 1, list("[type]", "[product.equipment_path]"))
			. = TRUE