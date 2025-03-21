/datum/adaptation/unnatural/claws
	name = "Wicked Claws"
	var/obj/item/melee/vampirearms/knife/protean/left_weapon
	var/obj/item/melee/vampirearms/knife/protean/right_weapon

/datum/adaptation/unnatural/claws/activate(mob/living/carbon/owner)
	. = ..()
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	owner.visible_message(span_alert("[owner]'s hands begin to crack and distort, growing freakish, blade-like claws!"))
	ADD_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_3_TRAIT)
	owner.drop_all_held_items()
	left_weapon = new (owner)
	RegisterSignal(left_weapon)
	owner.put_in_r_hand(left_weapon)
	right_weapon = new (owner)
	owner.put_in_l_hand(right_weapon)

/datum/adaptation/unnatural/claws/deactivate(mob/living/carbon/owner)
	. = ..()
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	REMOVE_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_3_TRAIT)
	if(left_weapon)
		qdel(left_weapon)
	if(right_weapon)
		qdel(right_weapon)
