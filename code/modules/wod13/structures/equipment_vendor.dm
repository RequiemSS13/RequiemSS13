
//--------VENDING MACHINES AND CLERKS--------//

/obj/machinery/mineral/equipment_vendor/fastfood
	name = "Clerk Catalogue"
	desc = "Order some fastfood here."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "menu"
	icon_deny = "menu"
	prize_list = list()
	var/dispenses_dollars = TRUE

/obj/machinery/mineral/equipment_vendor/fastfood/sodavendor
	name = "Drink Vendor"
	desc = "Order drinks here."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "vend_r"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/mining_equipment("cola",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	10),
		new /datum/data/mining_equipment("soda", /obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda, 5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/sodavendor/blue
	icon_state = "vend_c"
	prize_list = list(new /datum/data/mining_equipment("cola",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue,10),
		new /datum/data/mining_equipment("soda", /obj/item/reagent_containers/food/drinks/soda_cans/vampirecola/blue, 5),
		new /datum/data/mining_equipment("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 5),
		new /datum/data/mining_equipment("thaw club soda", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club, 7)
	)
/obj/machinery/mineral/equipment_vendor/fastfood/coffeevendor
	name = "Coffee Vendor"
	desc = "For those sleepy mornings."
	icon = 'code/modules/wod13/props.dmi'
	icon_state = "vend_g"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/mining_equipment("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	10),
		new /datum/data/mining_equipment("strong coffee", /obj/item/reagent_containers/food/drinks/coffee/vampire/robust, 5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/AltClick(mob/user)
	. = ..()
	if(points && dispenses_dollars)
		for(var/i in 1 to points)
			new /obj/item/stack/dollar(loc)
		points = 0

/obj/machinery/mineral/equipment_vendor/fastfood/snacks
	name = "Snack Vendor"
	desc = "That candy bar better not get stuck this time..."
	icon_state = "vend_b"
	anchored = TRUE
	density = TRUE
	owner_needed = FALSE
	prize_list = list(new /datum/data/mining_equipment("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/mining_equipment("chips",	/obj/item/food/vampire/crisps,	5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/bacotell
	prize_list = list(new /datum/data/mining_equipment("square pizza",	/obj/item/food/vampire/pizza,	15),
		new /datum/data/mining_equipment("taco",	/obj/item/food/vampire/taco,	10),
		new /datum/data/mining_equipment("burger",	/obj/item/food/vampire/burger,	20),
		new /datum/data/mining_equipment("two liter cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	10),
		new /datum/data/mining_equipment("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5),
		new /datum/data/mining_equipment("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 5),
		new /datum/data/mining_equipment("thaw club soda", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club, 8),
	)

/obj/machinery/mineral/equipment_vendor/fastfood/bubway
	prize_list = list(new /datum/data/mining_equipment("donut",	/obj/item/food/vampire/donut,	5),
		new /datum/data/mining_equipment("burger",	/obj/item/food/vampire/burger,	10),
		new /datum/data/mining_equipment("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	5),
		new /datum/data/mining_equipment("robust coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire/robust,	10),
		new /datum/data/mining_equipment("thaw club soda", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/thaw_club, 8)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/gummaguts
	prize_list = list(new /datum/data/mining_equipment("five-piece chicken wing box",	/obj/item/storage/fancy/nugget_box,	5),
		new /datum/data/mining_equipment("burger",	/obj/item/food/vampire/burger,	15),
		new /datum/data/mining_equipment("square pizza",	/obj/item/food/vampire/pizza,	10),
		new /datum/data/mining_equipment("two liter cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	10),
		new /datum/data/mining_equipment("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/products
	desc = "Purchase junkfood and crap."
	prize_list = list(new /datum/data/mining_equipment("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/mining_equipment("chips",	/obj/item/food/vampire/crisps,	5),
		new /datum/data/mining_equipment("water bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirewater,	3),
		new /datum/data/mining_equipment("soda can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda,	3),
		new /datum/data/mining_equipment("two liter cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	7),
		new /datum/data/mining_equipment("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5),
		new /datum/data/mining_equipment("summer thaw", /obj/item/reagent_containers/food/drinks/bottle/vampirecola/summer_thaw, 5),
		new /datum/data/mining_equipment("milk",	/obj/item/reagent_containers/food/condiment/vampiremilk,	5),
		new /datum/data/mining_equipment("beer bottle",	/obj/item/reagent_containers/food/drinks/beer/vampire,	10),
		new /datum/data/mining_equipment("blue stripe", /obj/item/reagent_containers/food/drinks/beer/vampire/blue_stripe, 8),
		new /datum/data/mining_equipment("candle pack",	/obj/item/storage/fancy/candle_box,	12),
		new /datum/data/mining_equipment("bruise pack", /obj/item/stack/medical/bruise_pack, 100),
		new /datum/data/mining_equipment("respirator",	/obj/item/clothing/mask/vampire,	35)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/clothing
	desc = "Purchase all the finest outfits.. Or don't wagie.."
	prize_list = list(new /datum/data/mining_equipment("crimson red dress",	/obj/item/clothing/under/vampire/primogen_toreador/female	,	350),
		new /datum/data/mining_equipment("black dress",	/obj/item/clothing/under/vampire/business,	250),
		new /datum/data/mining_equipment("leather pants", /obj/item/clothing/under/vampire/leatherpants,	200),
		new /datum/data/mining_equipment("fancy gray suit",	/obj/item/clothing/under/vampire/fancy_gray,	150),
		new /datum/data/mining_equipment("fancy red suit",	/obj/item/clothing/under/vampire/fancy_red,	150),
		new /datum/data/mining_equipment("black luxury suit",	/obj/item/clothing/under/vampire/ventrue,	50),
		new /datum/data/mining_equipment("black luxury suit skirt",	/obj/item/clothing/under/vampire/ventrue/female,	50),
		new /datum/data/mining_equipment("white buisness suit",	/obj/item/clothing/under/vampire/office,	50),
		new /datum/data/mining_equipment("black overcoat",	/obj/item/clothing/under/vampire/rich,	45),
		new /datum/data/mining_equipment("burgundy suit",	/obj/item/clothing/under/vampire/tremere,	35),
		new /datum/data/mining_equipment("burgundy suit skirt",	/obj/item/clothing/under/vampire/tremere/female,	35),
		new /datum/data/mining_equipment("flamboiant outfit",	/obj/item/clothing/under/vampire/toreador,	30),
		new /datum/data/mining_equipment("female flamboiant outfit",	/obj/item/clothing/under/vampire/toreador/female,	30),
		new /datum/data/mining_equipment("purple and black outfit",	/obj/item/clothing/under/vampire/sexy,	25),
		new /datum/data/mining_equipment("slick jacket",	/obj/item/clothing/under/vampire/slickback,		25),
		new /datum/data/mining_equipment("tracksuit",	/obj/item/clothing/under/vampire/sport,	25),
		new /datum/data/mining_equipment("grimey pants",	/obj/item/clothing/under/vampire/malkavian,	20),
		new /datum/data/mining_equipment("odd Goth schoolgirl attire",	/obj/item/clothing/under/vampire/malkavian/female,	20),
		new /datum/data/mining_equipment("gothic clothes",	/obj/item/clothing/under/vampire/gothic,	20),
		new /datum/data/mining_equipment("gothic attire",	/obj/item/clothing/under/vampire/brujah,	20),
		new /datum/data/mining_equipment("female punk attire ",	/obj/item/clothing/under/vampire/brujah/female,	20),
		new /datum/data/mining_equipment("punk outfit",	/obj/item/clothing/under/vampire/emo,	20),
		new /datum/data/mining_equipment("red hipster outfit",	/obj/item/clothing/under/vampire/red,	20),
		new /datum/data/mining_equipment("blue overals",	/obj/item/clothing/under/vampire/mechanic,	20),
		new /datum/data/mining_equipment("black grunge outfit",	/obj/item/clothing/under/vampire/black,	20),
		new /datum/data/mining_equipment("gimp outfit",	/obj/item/clothing/under/vampire/nosferatu,	15),
		new /datum/data/mining_equipment("female gimp outfit",	/obj/item/clothing/under/vampire/nosferatu/female,	15),
		new /datum/data/mining_equipment("rugged attire",	/obj/item/clothing/under/vampire/gangrel,	15),
		new /datum/data/mining_equipment("female rugged attire",	/obj/item/clothing/under/vampire/gangrel/female,	15),
		new /datum/data/mining_equipment("yellow sleeveless shirt",	/obj/item/clothing/under/vampire/larry,	15),
		new /datum/data/mining_equipment("white sleeveless shirt",	/obj/item/clothing/under/vampire/bandit,	15),
		new /datum/data/mining_equipment("biker outfit",	/obj/item/clothing/under/vampire/biker,	15),
		new /datum/data/mining_equipment("burlesque outfit", /obj/item/clothing/under/vampire/burlesque,	15),
		new /datum/data/mining_equipment("daisy dukes", /obj/item/clothing/under/vampire/burlesque/daisyd,	10),
		new /datum/data/mining_equipment("black shoes",	/obj/item/clothing/shoes/vampire,	10),
		new /datum/data/mining_equipment("brown shoes",	/obj/item/clothing/shoes/vampire/brown,	10),
		new /datum/data/mining_equipment("white shoes",	/obj/item/clothing/shoes/vampire/white,	10),
		new /datum/data/mining_equipment("black boots",	/obj/item/clothing/shoes/vampire/jackboots,	10),
		new /datum/data/mining_equipment("work boots",	/obj/item/clothing/shoes/vampire/jackboots/work,	10),
		new /datum/data/mining_equipment("sneakers",	/obj/item/clothing/shoes/vampire/sneakers,	10),
		new /datum/data/mining_equipment("red sneakers",	/obj/item/clothing/shoes/vampire/sneakers/red,	10),
		new /datum/data/mining_equipment("high heels",	/obj/item/clothing/shoes/vampire/heels,	35),
		new /datum/data/mining_equipment("red high heels",	/obj/item/clothing/shoes/vampire/heels/red,	35),
		new /datum/data/mining_equipment("scaly shoes",	/obj/item/clothing/shoes/vampire/businessscaly,	35),
		new /datum/data/mining_equipment("black shoes",	/obj/item/clothing/shoes/vampire/businessblack,	35),
		new /datum/data/mining_equipment("metal tip shoes",	/obj/item/clothing/shoes/vampire/businesstip,	50),
		new /datum/data/mining_equipment("purple fur coat",		/obj/item/clothing/suit/vampire/slickbackcoat,	500),
		new /datum/data/mining_equipment("too much fancy jacket",	/obj/item/clothing/suit/vampire/majima_jacket,	100),
		new /datum/data/mining_equipment("labcoat",	/obj/item/clothing/suit/vampire/labcoat,	75),
		new /datum/data/mining_equipment("fancy gray jacket",	/obj/item/clothing/suit/vampire/fancy_gray,	50),
		new /datum/data/mining_equipment("fancy red jacket",	/obj/item/clothing/suit/vampire/fancy_red,	50),
		new /datum/data/mining_equipment("black trenchcoat",	/obj/item/clothing/suit/vampire/trench,	45),
		new /datum/data/mining_equipment("brown trenchcoat",	/obj/item/clothing/suit/vampire/trench/alt,	35),
		new /datum/data/mining_equipment("brown coat",	/obj/item/clothing/suit/vampire/coat,	15),
		new /datum/data/mining_equipment("green coat",	/obj/item/clothing/suit/vampire/coat/alt,	15),
		new /datum/data/mining_equipment("jacket",	/obj/item/clothing/suit/vampire/jacket,	15),
		new /datum/data/mining_equipment("black coat",	/obj/item/clothing/suit/vampire/coat/winter,	15),
		new /datum/data/mining_equipment("red coat",	/obj/item/clothing/suit/vampire/coat/winter/alt,	15),
		new /datum/data/mining_equipment("yellow aviators",	/obj/item/clothing/glasses/vampire/yellow,	20),
		new /datum/data/mining_equipment("red aviators",	/obj/item/clothing/glasses/vampire/red,	20),
		new /datum/data/mining_equipment("sunglasses",	/obj/item/clothing/glasses/vampire/sun,	20),
		new /datum/data/mining_equipment("prescription glasses",	/obj/item/clothing/glasses/vampire/perception,	20),
		new /datum/data/mining_equipment("leather gloves", /obj/item/clothing/gloves/vampire/leather,	25),
		new /datum/data/mining_equipment("rubber gloves", /obj/item/clothing/gloves/vampire/cleaning,	15),
		new /datum/data/mining_equipment("latex gloves", /obj/item/clothing/gloves/vampire/latex,	5),
		new /datum/data/mining_equipment("black work gloves", /obj/item/clothing/gloves/vampire/work,	45),
		new /datum/data/mining_equipment("bandana",	/obj/item/clothing/head/vampire/bandana,	10),
		new /datum/data/mining_equipment("red bandana",	/obj/item/clothing/head/vampire/bandana/red,	10),
		new /datum/data/mining_equipment("black bandana",	/obj/item/clothing/head/vampire/bandana/black,	10),
		new /datum/data/mining_equipment("baseball cap", /obj/item/clothing/head/vampire/baseballcap, 10),
		new /datum/data/mining_equipment("ushanka",	/obj/item/clothing/head/vampire/ushanka, 20),
		new /datum/data/mining_equipment("beanie",	/obj/item/clothing/head/vampire/beanie,	10),
		new /datum/data/mining_equipment("black beanie",	/obj/item/clothing/head/vampire/beanie/black,	10),
		new /datum/data/mining_equipment("rough beanie",	/obj/item/clothing/head/vampire/beanie/homeless,	10),
		new /datum/data/mining_equipment("scarf",	/obj/item/clothing/neck/vampire/scarf,	10),
		new /datum/data/mining_equipment("red scarf",	/obj/item/clothing/neck/vampire/scarf/red,	10),
		new /datum/data/mining_equipment("blue scarf",	/obj/item/clothing/neck/vampire/scarf/blue,	10),
		new /datum/data/mining_equipment("green scarf",	/obj/item/clothing/neck/vampire/scarf/green,	10),
		new /datum/data/mining_equipment("white scarf",	/obj/item/clothing/neck/vampire/scarf/white,	10),
		new /datum/data/mining_equipment("cross",	/obj/item/card/id/hunter,  25),
		new /datum/data/mining_equipment("white robes",	/obj/item/clothing/suit/hooded/robes,	40),
		new /datum/data/mining_equipment("black robes",	/obj/item/clothing/suit/hooded/robes/black,	40),
		new /datum/data/mining_equipment("grey robes",	/obj/item/clothing/suit/hooded/robes/grey,	40),
		new /datum/data/mining_equipment("dark red robes",	/obj/item/clothing/suit/hooded/robes/darkred,	40),
		new /datum/data/mining_equipment("yellow robes",	/obj/item/clothing/suit/hooded/robes/yellow,	40),
		new /datum/data/mining_equipment("green robes",	/obj/item/clothing/suit/hooded/robes/green,	40),
		new /datum/data/mining_equipment("red robes",	/obj/item/clothing/suit/hooded/robes/red,	40),
		new /datum/data/mining_equipment("purple robes",	/obj/item/clothing/suit/hooded/robes/purple,	40)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/costumes
	desc = "Purchase a mask for that ugly mug."
	prize_list = list(
		new /datum/data/mining_equipment("balaclava",	 /obj/item/clothing/mask/vampire/balaclava,	10),
		new /datum/data/mining_equipment("bear mask",	 /obj/item/clothing/mask/animal/rat/bear,	13),
		new /datum/data/mining_equipment("rat mask",	/obj/item/clothing/mask/animal/rat,	10),
		new /datum/data/mining_equipment("bee mask",	/obj/item/clothing/mask/animal/rat/bee,	12),
		new /datum/data/mining_equipment("fox mask",	/obj/item/clothing/mask/animal/rat/fox,	10),
		new /datum/data/mining_equipment("bat mask",	/obj/item/clothing/mask/animal/rat/bat,	15),
		new /datum/data/mining_equipment("raven mask",	/obj/item/clothing/mask/animal/rat/raven,	20),
		new /datum/data/mining_equipment("jackal mask",	 /obj/item/clothing/mask/animal/rat/jackal,	20),
		new /datum/data/mining_equipment("medical mask",	/obj/item/clothing/mask/surgical,	10),
		new /datum/data/mining_equipment("mummy mask",	/obj/item/clothing/mask/mummy,	15),
		new /datum/data/mining_equipment("scarecrow mask",	/obj/item/clothing/mask/scarecrow,	10),
		new /datum/data/mining_equipment("respirator",	/obj/item/clothing/mask/vampire,	35),
		new /datum/data/mining_equipment("black and gold luchador mask",	/obj/item/clothing/mask/luchador,	10),
		new /datum/data/mining_equipment("green luchador mask",	/obj/item/clothing/mask/luchador/tecnicos,	10),
		new /datum/data/mining_equipment("red and blue luchador mask",	/obj/item/clothing/mask/luchador/rudos,	10),
		new /datum/data/mining_equipment("Venetian mask",	/obj/item/clothing/mask/vampire/venetian_mask,	30),
		new /datum/data/mining_equipment("fancy Venetian mask",	/obj/item/clothing/mask/vampire/venetian_mask/fancy,	200),
		new /datum/data/mining_equipment("jester mask",	/obj/item/clothing/mask/vampire/venetian_mask/jester,	50),
		new /datum/data/mining_equipment("bloody mask",	/obj/item/clothing/mask/vampire/venetian_mask/scary,	30)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/america
	desc = "Boom! Booom!! BOOOOOOM!!!!"
	prize_list = list(new /datum/data/mining_equipment("magnum revolver",	/obj/item/gun/ballistic/vampire/revolver,	200),
		new /datum/data/mining_equipment("Colt M1911",	/obj/item/gun/ballistic/automatic/vampire/m1911,	250),
		new /datum/data/mining_equipment("Glock19",	/obj/item/gun/ballistic/automatic/vampire/glock19,	500),
		new /datum/data/mining_equipment("desert eagle",	/obj/item/gun/ballistic/automatic/vampire/deagle,	600),
		new /datum/data/mining_equipment("shotgun",		/obj/item/gun/ballistic/shotgun/vampire, 900),
		new /datum/data/mining_equipment("fishing rod",		/obj/item/fishing_rod,	200),
		new	/datum/data/mining_equipment("5.45 ammo",	/obj/item/ammo_box/vampire/c545,	1000),
		new	/datum/data/mining_equipment(".45 ACP ammo",	/obj/item/ammo_box/vampire/c45acp,	2100),
		new /datum/data/mining_equipment("9mm ammo",	/obj/item/ammo_box/vampire/c9mm,	600),
		new /datum/data/mining_equipment(".44 ammo",	/obj/item/ammo_box/vampire/c44,	800),
		new /datum/data/mining_equipment("5.56 ammo",	/obj/item/ammo_box/vampire/c556,	2000),
		new /datum/data/mining_equipment("12ga shotgun shells, buckshot",/obj/item/ammo_box/vampire/c12g/buck,	400),
		new /datum/data/mining_equipment("desert eagle magazine",	/obj/item/ammo_box/magazine/m44,	100),
		new /datum/data/mining_equipment("Glock19 magazine",		/obj/item/ammo_box/magazine/glock9mm,	100),
		new /datum/data/mining_equipment("Colt M1911 magazine",		/obj/item/ammo_box/magazine/vamp45acp,	50),
		new /datum/data/mining_equipment("knife",	/obj/item/melee/vampirearms/knife,	100),
		new /datum/data/mining_equipment("baseball bat",	/obj/item/melee/vampirearms/baseball,	200),
		new /datum/data/mining_equipment("real katana",	/obj/item/melee/vampirearms/katana,	1500),
		new /datum/data/mining_equipment("machete", /obj/item/melee/vampirearms/machete, 500),
		new /datum/data/mining_equipment("donut",	/obj/item/food/vampire/donut,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/illegal
	prize_list = list(
		new /datum/data/mining_equipment("morphine syringe",	/obj/item/reagent_containers/syringe/contraband/morphine,	100),
		new	/datum/data/mining_equipment("meth package",	/obj/item/reagent_containers/food/drinks/meth,	300),
		new	/datum/data/mining_equipment("cocaine package",	/obj/item/reagent_containers/food/drinks/meth/cocaine,	700),
		new /datum/data/mining_equipment("LSD pill bottle",		/obj/item/storage/pill_bottle/lsd,	50),
		new /datum/data/mining_equipment("LSD pill",		/obj/item/reagent_containers/pill/lsd,	10),
		new /datum/data/mining_equipment("cannabis puff",		/obj/item/clothing/mask/cigarette/rollie/cannabis,	40),
		new /datum/data/mining_equipment("cannabis package",		/obj/item/weedpack,	175),
		new /datum/data/mining_equipment("cannabis seed",	/obj/item/weedseed,		10),
		new /datum/data/mining_equipment("bong",	/obj/item/bong,		50),
		new /datum/data/mining_equipment("snub-nose revolver",	/obj/item/gun/ballistic/vampire/revolver/snub,	100),
		new /datum/data/mining_equipment("9mm ammo clip", /obj/item/ammo_box/vampire/c9mm/moonclip, 20),
		new /datum/data/mining_equipment("bailer",	/obj/item/bailer,		20),
		new /datum/data/mining_equipment("incendiary 5.56 ammo",	/obj/item/ammo_box/vampire/c556/incendiary,	6000),
		new /datum/data/mining_equipment("silver 9mm ammo",	/obj/item/ammo_box/vampire/c9mm/silver,	3000),
		new /datum/data/mining_equipment("silver .45 ACP ammo",	/obj/item/ammo_box/vampire/c45acp/silver,	3000),
		new /datum/data/mining_equipment("silver .44 ammo",	/obj/item/ammo_box/vampire/c44/silver,	3000),
		new /datum/data/mining_equipment("silver 5.56 ammo",	/obj/item/ammo_box/vampire/c556/silver,	6000),
		new /datum/data/mining_equipment("stake",	/obj/item/vampire_stake,	100),
		new /datum/data/mining_equipment("lockpick",	/obj/item/vamp/keys/hack, 50),
		new /datum/data/mining_equipment("zippo lighter",	/obj/item/lighter,	20),
		new /datum/data/mining_equipment("Surgery dufflebag", /obj/item/storage/backpack/duffelbag/med/surgery, 100),
		new /datum/data/mining_equipment("lighter",		/obj/item/lighter/greyscale,	10),
		new /datum/data/mining_equipment("knife",	/obj/item/melee/vampirearms/knife,	85),
		new /datum/data/mining_equipment("switchblade",	/obj/item/melee/vampirearms/knife/switchblade, 85)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/pharmacy
	prize_list = list(
		new /datum/data/mining_equipment("ephedrine pill bottle", /obj/item/storage/pill_bottle/ephedrine, 200),
		new /datum/data/mining_equipment("iron pill bottle", /obj/item/storage/pill_bottle/iron, 150),
		new /datum/data/mining_equipment("potassium iodide pill bottle", /obj/item/storage/pill_bottle/potassiodide, 100),
		new /datum/data/mining_equipment("bruise pack", /obj/item/stack/medical/bruise_pack, 100),
		new /datum/data/mining_equipment("burn ointment", /obj/item/stack/medical/ointment, 100),
		new /datum/data/mining_equipment("latex gloves", /obj/item/clothing/gloves/vampire/latex, 150),
		new /datum/data/mining_equipment("box of syringes", /obj/item/storage/box/syringes, 300)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/hospital // we should probably swap from a vendor system and work on a sort of gameplay loop - tzula
	prize_list = list(
		new /datum/data/mining_equipment("toxins first aid kit", /obj/item/storage/firstaid/toxin, 50),
		new /datum/data/mining_equipment("burns first aid kit", /obj/item/storage/firstaid/fire, 50),
		new /datum/data/mining_equipment("standard first aid kit", /obj/item/storage/firstaid/medical, 50),
		new /datum/data/mining_equipment("respiratory aid kit", /obj/item/storage/firstaid/o2, 50),
		new /datum/data/mining_equipment("potassium iodide pill bottle", /obj/item/defibrillator/compact, 100),
		new /datum/data/mining_equipment("defib batteries", /obj/item/stock_parts/cell, 50),
		new /datum/data/mining_equipment("surgery dufflebag", /obj/item/storage/backpack/duffelbag/med/surgery, 100),
		new /datum/data/mining_equipment("ephedrine pill bottle", /obj/item/storage/pill_bottle/ephedrine, 200),
		new /datum/data/mining_equipment("iron pill bottle", /obj/item/storage/pill_bottle/iron, 150),
		new /datum/data/mining_equipment("bruise pack", /obj/item/stack/medical/bruise_pack, 100),
		new /datum/data/mining_equipment("surgical apron", /obj/item/clothing/suit/apron/surgical, 100),
		new /datum/data/mining_equipment("latex gloves", /obj/item/clothing/gloves/vampire/latex, 100),
		new /datum/data/mining_equipment("burn ointment", /obj/item/stack/medical/ointment, 100)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/police
	var/last_card_use_time = 0
	dispenses_dollars = FALSE
	prize_list = list(
		new /datum/data/mining_equipment("handcuffs", /obj/item/restraints/handcuffs, 1),
		new /datum/data/mining_equipment("camera", /obj/item/camera, 2),
		new /datum/data/mining_equipment("tape recorder", /obj/item/taperecorder, 2),
		new /datum/data/mining_equipment("white crayon", /obj/item/toy/crayon/white, 1),
		new /datum/data/mining_equipment("evidence box", /obj/item/storage/box/evidence, 1),
		new /datum/data/mining_equipment("crime scene tape", /obj/item/barrier_tape/police, 1),
		new /datum/data/mining_equipment("body bags", /obj/item/storage/box/bodybags, 1),
		new /datum/data/mining_equipment("police vest", /obj/item/clothing/suit/vampire/vest/police, 1),
		new /datum/data/mining_equipment("police radio", /obj/item/radio/cop, 2),
		new /datum/data/mining_equipment("police uniform", /obj/item/clothing/under/vampire/police, 1),
		new /datum/data/mining_equipment("police hat", /obj/item/clothing/head/vampire/police, 1),
		new /datum/data/mining_equipment("flashlight", /obj/item/flashlight, 1),
		new /datum/data/mining_equipment("magnifier", /obj/item/detective_scanner, 4)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/smoking
	prize_list = list(new /datum/data/mining_equipment("malboro",	/obj/item/storage/fancy/cigarettes/cigpack_robust,	50),
		new /datum/data/mining_equipment("newport",		/obj/item/storage/fancy/cigarettes/cigpack_xeno,	30),
		new /datum/data/mining_equipment("camel",	/obj/item/storage/fancy/cigarettes/dromedaryco,	30),
		new /datum/data/mining_equipment("zippo lighter",	/obj/item/lighter,	20),
		new /datum/data/mining_equipment("lighter",		/obj/item/lighter/greyscale,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/gas
	prize_list = list(new /datum/data/mining_equipment("full gas can",	/obj/item/gas_can/full,	250),
		new /datum/data/mining_equipment("tire iron",		/obj/item/melee/vampirearms/tire,	50)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/library

	prize_list = list(
		new /datum/data/mining_equipment("Bible",	/obj/item/storage/book/bible,  20),
		new /datum/data/mining_equipment("Quran",	/obj/item/vampirebook/quran,  20),
		new /datum/data/mining_equipment("black pen",	/obj/item/pen,  5),
		new /datum/data/mining_equipment("four-color pen",	/obj/item/pen/fourcolor,  10),
		new /datum/data/mining_equipment("fountain pen",	/obj/item/pen/fountain,  15),
		new /datum/data/mining_equipment("folder",	/obj/item/folder,  5)
	)