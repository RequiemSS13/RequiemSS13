/obj/structure/weedshit
	name = "hydroponics"
	desc = "Definitely not for the weed."
	icon = 'code/modules/wod13/weed.dmi'
	icon_state = "soil_dry0"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	var/wet = FALSE
	var/growth_stage = 0
	var/health = 3

/obj/structure/weedshit/buyable
	anchored = FALSE

/obj/structure/weedshit/examine(mob/user)
	. = ..()
	if(!wet)
		. += "<span class='warning'>[src] is dry!</span>"
	if(growth_stage == 5)
		. += "<span class='warning'>The crop is dead!</span>"
	else
		if(health <= 2)
			. += "<span class='warning'>The crop is looking unhealthy.</span>"


/obj/structure/weedshit/attack_hand(mob/user)
	. = ..()
	if(growth_stage == 5)
		growth_stage = 0
		health = 3
		to_chat(user, "<span class='notice'>You rip the rotten weed out of [src].</span>")
	if(growth_stage == 4)
		growth_stage = 1
		to_chat(user, "<span class='notice'>You pull the grown weed out of [src].</span>")
				var/mob/living/carbon/human/H = user
		var/amount
		switch(storyteller_roll(H.get_total_mentality(), 6, TRUE))
			if(3 to INFINITY)
				amount = 4
			if(2)
				amount = 3
			if(1)
				amount = 2
			else
				amount = 1
		for(var/i = 1 to amount)
			new /obj/item/food/vampire/weed(get_turf(user))
	update_weed_icon()

/obj/structure/weedshit/AltClick(mob/user)
	if(do_after(user, 15))
		if(anchored)
			to_chat(user, "<span class='notice'>You unsecure the [src] from the ground.</span>")
			anchored = FALSE
			return
		else
			to_chat(user, "<span class='notice'>You secure the [src] to the ground.</span>")
			anchored = TRUE
			return

/obj/structure/weedshit/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/bailer))
		var/obj/item/bailer/B = W
		if(B.amount_of_water)
			B.amount_of_water = max(0, B.amount_of_water-1)
			wet = TRUE
			to_chat(user, "<span class='notice'>You fill [src] with water.</span>")
			playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
		else
			to_chat(user, "<span class='warning'>[W] is empty!</span>")
	if(istype(W, /obj/item/weedseed))
		if(growth_stage == 0)
			health = 3
			growth_stage = 1
			qdel(W)
	update_weed_icon()
	return

/obj/structure/weedshit/Initialize()
	. = ..()
	GLOB.weed_list += src

/obj/structure/weedshit/Destroy()
	. = ..()
	GLOB.weed_list -= src

/obj/structure/weedshit/proc/update_weed_icon()
	icon_state = "soil[wet ? "" : "_dry"][growth_stage]"


/obj/item/weedseed
	name = "seed"
	desc = "Green and smelly..."
	icon_state = "seed"
	icon = 'code/modules/wod13/items.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/weedpack
	name = "green package"
	desc = "Green and smelly..."
	icon_state = "package_weed"
	icon = 'code/modules/wod13/items.dmi'
	w_class = WEIGHT_CLASS_SMALL
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	illegal = TRUE
	cost = 175

/obj/item/food/vampire/weed
	name = "leaf"
	desc = "Green and smelly..."
	icon_state = "weed"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	bite_consumption = 5
	tastes = list("cat piss" = 4, "weed" = 2)
	foodtypes = VEGETABLES
	food_reagents = list(/datum/reagent/drug/space_drugs = 20, /datum/reagent/toxin/lipolicide = 20)
	eat_time = 10
	illegal = TRUE
	cost = 50

/obj/item/bailer
	name = "bailer"
	desc = "Best for flora!"
	icon_state = "bailer"
	icon = 'code/modules/wod13/items.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/amount_of_water = 10

/obj/item/bailer/examine(mob/user)
	. = ..()
	if(!amount_of_water)
		. += "<span class='warning'>[src] is empty!</span>"

/obj/item/reagent_containers/food/drinks/meth
	name = "blue package"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "package_meth"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/drug/methamphetamine = 30)
	spillable = FALSE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST
	illegal = TRUE
	cost = 300

/obj/item/reagent_containers/food/drinks/meth/cocaine
	name = "white package"
	icon_state = "package_cocaine"
	list_reagents = list(/datum/reagent/drug/methamphetamine/cocaine = 30)
	cost = 500

/obj/item/reagent_containers/drug/methpack
	name = "\improper elite blood pack (full)"
	desc = "Fast way to feed your inner beast."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "blood4"
	inhand_icon_state = "blood4"
	lefthand_file = 'code/modules/wod13/lefthand.dmi'
	righthand_file = 'code/modules/wod13/righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/drug/methamphetamine = 15) //some of the source chemicals are lost in the process
	resistance_flags = FREEZE_PROOF
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/empty = FALSE
	var/feeding = FALSE
	var/amount_of_bloodpoints = 4
	var/vitae = FALSE

/obj/item/reagent_containers/drug/methpack/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iskindred(M))
		if(!vitae)
			return
	if(empty)
		return
	feeding = TRUE
	if(do_mob(user, src, 3 SECONDS))
		var/obj/item/reagent_containers/drug/methpack/H = new(src) //setting up the drugged bag in question (and its contents) as a variable to be called later
		feeding = FALSE
		empty = TRUE
		icon_state = "blood0"
		inhand_icon_state = "blood0"
		name = "\improper drinkable blood pack (empty)"
		M.bloodpool = min(M.maxbloodpool, M.bloodpool+amount_of_bloodpoints)
		M.adjustBruteLoss(-20, TRUE)
		M.adjustFireLoss(-20, TRUE)
		M.update_damage_overlays()
		M.update_health_hud()
		if(iskindred(M))
			M.update_blood_hud()
			H.reagents.trans_to(M, min(10, H.reagents.total_volume), transfered_by = H, methods = VAMPIRE) //calling the earlier variable to transfer to target, M
		playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
		return
	else
		feeding = FALSE
		return

/obj/item/reagent_containers/drug/morphpack
	name = "\improper elite blood pack (full)"
	desc = "Fast way to feed your inner beast."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "blood4"
	inhand_icon_state = "blood4"
	lefthand_file = 'code/modules/wod13/lefthand.dmi'
	righthand_file = 'code/modules/wod13/righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/toxin/chloralhydrate = 10, /datum/reagent/medicine/morphine = 10) //some of the source chemicals are lost in the process
	resistance_flags = FREEZE_PROOF
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/empty = FALSE
	var/feeding = FALSE
	var/amount_of_bloodpoints = 4
	var/vitae = FALSE

/obj/item/reagent_containers/drug/morphpack/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iskindred(M))
		if(!vitae)
			return
	if(empty)
		return
	feeding = TRUE
	if(do_mob(user, src, 3 SECONDS))
		var/obj/item/reagent_containers/drug/morphpack/H = new(src) //setting up the drugged bag in question (and its contents) as a variable to be called later
		feeding = FALSE
		empty = TRUE
		icon_state = "blood0"
		inhand_icon_state = "blood0"
		name = "\improper drinkable blood pack (empty)"
		M.bloodpool = min(M.maxbloodpool, M.bloodpool+amount_of_bloodpoints)
		M.adjustBruteLoss(-20, TRUE)
		M.adjustFireLoss(-20, TRUE)
		M.update_damage_overlays()
		M.update_health_hud()
		if(iskindred(M))
			M.update_blood_hud()
			H.reagents.trans_to(M, min(10, H.reagents.total_volume), transfered_by = H, methods = VAMPIRE) //calling the earlier variable to transfer to target, M
		playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
		return
	else
		feeding = FALSE
		return

/obj/item/reagent_containers/drug/cokepack
	name = "\improper elite blood pack (full)"
	desc = "Fast way to feed your inner beast."
	icon = 'code/modules/wod13/items.dmi'
	icon_state = "blood4"
	inhand_icon_state = "blood4"
	lefthand_file = 'code/modules/wod13/lefthand.dmi'
	righthand_file = 'code/modules/wod13/righthand.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	list_reagents = list(/datum/reagent/drug/methamphetamine/cocaine = 15) //some of the source chemicals are lost in the process
	resistance_flags = FREEZE_PROOF
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/empty = FALSE
	var/feeding = FALSE
	var/amount_of_bloodpoints = 4
	var/vitae = FALSE

/obj/item/reagent_containers/drug/cokepack/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iskindred(M))
		if(!vitae)
			return
	if(empty)
		return
	feeding = TRUE
	if(do_mob(user, src, 3 SECONDS))
		var/obj/item/reagent_containers/drug/cokepack/H = new(src) //setting up the drugged bag in question (and its contents) as a variable to be called later
		feeding = FALSE
		empty = TRUE
		icon_state = "blood0"
		inhand_icon_state = "blood0"
		name = "\improper drinkable blood pack (empty)"
		M.bloodpool = min(M.maxbloodpool, M.bloodpool+amount_of_bloodpoints)
		M.adjustBruteLoss(-20, TRUE)
		M.adjustFireLoss(-20, TRUE)
		M.update_damage_overlays()
		M.update_health_hud()
		if(iskindred(M))
			M.update_blood_hud()
			H.reagents.trans_to(M, min(10, H.reagents.total_volume), transfered_by = H, methods = VAMPIRE) //calling the earlier variable to transfer to target, M
		playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
		return
	else
		feeding = FALSE
		return
