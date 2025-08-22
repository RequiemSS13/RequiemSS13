/obj/item/masquerade_contract
	name = "Writ of Justice"
	desc = "A mystically notarized writ from the Prince, transmitting his demands to the domain's Hounds. Updates in real time with the Prince's changing whims."
	icon = 'icons/wod13/items.dmi'
	icon_state = "masquerade"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/masquerade_contract/attack_self(mob/user)
	. = ..()
	var/list/severe_breaches = list()
	var/list/moderate_breaches = list()
	var/faction_string
	if(length(GLOB.masquerade_breakers_list)) //if there's no masq breachers we'll just head this off at the pass
		for(var/mob/living/carbon/human/H in GLOB.masquerade_breakers_list)
			var/turf/TT = get_turf(H) //check to see if the guy in question still, like, exists
			if(TT)
				if(H.masquerade > 1)
					moderate_breaches |= H
				else if(H.masquerade < 2)
					severe_breaches |= H
		if(length(moderate_breaches))
			to_chat(user, "Your sovereign, the Prince, commands the following subjects and residents to assist the Domain's Hounds and Sheriff in enforcement of their duties until further notice:")
			for(var/mob/living/carbon/human/H in moderate_breaches)
				if(H.vtr_faction.name != "Unaligned" && iskindred(H)) //sorry ghouls dont vote
					faction_string = ", of the [H.vtr_faction.name]"
				else
					faction_string = ""
				to_chat(user, "• [H.real_name], [H.mind.assigned_role][faction_string]")
		if(length(severe_breaches))
			if(length(moderate_breaches))
				to_chat(user, "Furthermore, your sovereign declares a Blood Hunt on the following individuals for endangering the safety of the Domain. All able Kindred are to bring these offenders to justice.")
			else
				to_chat(user, "Your sovereign, the Prince, declares a Blood Hunt on the following individuals for endangering the safety of the Domain. All able Kindred are to bring these offenders to justice.")
			for(var/mob/living/carbon/human/H in severe_breaches)
				to_chat(user, "• [H.real_name], last seen: [get_area_sector(H)]")
	else if(!length(severe_breaches) && !length(moderate_breaches))
		to_chat(user, "Your sovereign, the Prince, commands you to enforce the law of the Domain using your own best judgement.")
	else
		to_chat(user, "Your sovereign, the Prince, commands you to enforce the law of the Domain using your own best judgement.")
