/obj/item/masquerade_contract
	name = "Masquerade Contract"
	desc = "See where to search the shitty Masquerade breakers. <b>CLICK ON the Contract to see possible breakers for catching. PUSH the target in torpor, to restore the Masquerade</b>"
	icon = 'icons/wod13/items.dmi'
	icon_state = "masquerade"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/masquerade_contract/attack_self(mob/user)
	. = ..()
	if(length(GLOB.masquerade_breakers_list))
		for(var/mob/living/carbon/human/H in GLOB.masquerade_breakers_list)
			var/turf/TT = get_turf(H)
			if(TT)
				to_chat(user, "[H.real_name], Masquerade: [H.masquerade], last seen: [get_area_sector(H)]")
	else
		to_chat(user, "No available Masquerade breakers in city...")