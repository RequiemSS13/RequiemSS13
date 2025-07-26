/datum/merit/proxy
	name = "Official Proxy"
	desc = "You've been recognized as the official proxy of an established Kindred, capable of trading boons on their behalf."
	splat_flags = MERIT_SPLAT_GHOUL
	mob_trait = TRAIT_PROXY
	dots = 3

/datum/merit/proxy/on_spawn()
	var/mob/living/carbon/human/H = merit_holder
	var/obj/item/proxy_writ/proxy_writ = new(get_turf(merit_holder))
	var/list/slots = list(
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	H.equip_in_one_of_slots(proxy_writ, slots, FALSE)

/datum/merit/proxy/post_add()
	var/mob/living/carbon/human/human_holder = merit_holder
	add_verb(human_holder, /datum/controller/subsystem/character_connection/verb/request_boon)
	add_verb(human_holder, /datum/controller/subsystem/character_connection/verb/offer_boon)

/datum/merit/proxy/remove()
	var/mob/living/carbon/human/human_holder = merit_holder
	remove_verb(human_holder, /datum/controller/subsystem/character_connection/verb/request_boon)
	remove_verb(human_holder, /datum/controller/subsystem/character_connection/verb/offer_boon)

