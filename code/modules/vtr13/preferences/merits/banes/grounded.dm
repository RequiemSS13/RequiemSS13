/datum/merit/bane/grounded
	name = "Grounded"
	desc = "Your blood is tied to the circumstances of your death. You carry soil from the site of your grave on your person. Being far from it will weaken you."
	gain_text = "<span class='warning'>You carry with you an urn - its contents must be protected.</span>"

/datum/merit/bane/grounded/on_spawn()
	var/mob/living/carbon/human/H = merit_holder
	var/obj/item/grave_soil/urn = new(get_turf(merit_holder), merit_holder)
	var/list/slots = list(
		LOCATION_BACKPACK = ITEM_SLOT_BACKPACK,
		LOCATION_HANDS = ITEM_SLOT_HANDS
	)
	H.equip_in_one_of_slots(urn, slots, FALSE)