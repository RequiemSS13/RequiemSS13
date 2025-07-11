/obj/structure/retail/gun_store
	desc = "Boom! Booom!! BOOOOOOM!!!!"
	products_list = list(new /datum/data/retail_product("magnum revolver",	/obj/item/gun/ballistic/vampire/revolver,	200),
		new /datum/data/retail_product("Colt M1911",	/obj/item/gun/ballistic/automatic/vampire/m1911,	250),
		new /datum/data/retail_product("Elite 92G",	/obj/item/gun/ballistic/automatic/vampire/beretta,	500),
		new /datum/data/retail_product("desert eagle",	/obj/item/gun/ballistic/automatic/vampire/deagle,	600),
		new /datum/data/retail_product("hunting rifle",	/obj/item/gun/ballistic/automatic/vampire/huntrifle, 2000),
		new	/datum/data/retail_product("5.45 ammo",	/obj/item/ammo_box/vampire/c545,	1000),
		new	/datum/data/retail_product(".45 ACP ammo",	/obj/item/ammo_box/vampire/c45acp,	2100),
		new /datum/data/retail_product("9mm ammo",	/obj/item/ammo_box/vampire/c9mm,	600),
		new /datum/data/retail_product(".44 ammo",	/obj/item/ammo_box/vampire/c44,	800),
		new /datum/data/retail_product("5.56 ammo",	/obj/item/ammo_box/vampire/c556,	2000),
		new /datum/data/retail_product("shotgun",		/obj/item/gun/ballistic/shotgun/vampire, 900),
		new /datum/data/retail_product("12ga shotgun shells, buckshot",/obj/item/ammo_box/vampire/c12g/buck,	400),
		new /datum/data/retail_product("desert eagle magazine",	/obj/item/ammo_box/magazine/m44,	100),
		new /datum/data/retail_product("hunting rifle magazine, 5.56",	/obj/item/ammo_box/magazine/vamp556/hunt,	200),
		new /datum/data/retail_product("9mm pistol magazine, 18 rounds",		/obj/item/ammo_box/magazine/semi9mm,	100),
		new /datum/data/retail_product("Colt M1911 magazine",		/obj/item/ammo_box/magazine/vamp45acp,	50),
		new /datum/data/retail_product("silver knife",	/obj/item/melee/vampirearms/knife/silver,	500),
		new /datum/data/retail_product("real katana",	/obj/item/melee/vampirearms/katana,	1500),
		new /datum/data/retail_product("machete", /obj/item/melee/vampirearms/machete, 500)
	)

/obj/structure/retail/gun_store/can_shop(mob/user)
	for(var/obj/item/card/id/gun_license/license in user.GetAllContents())
		if(license)
			return TRUE
	if(my_owner && !my_owner.stat)
		my_owner.RealisticSay("I can't sell you anything without a license, pal.")
	return FALSE