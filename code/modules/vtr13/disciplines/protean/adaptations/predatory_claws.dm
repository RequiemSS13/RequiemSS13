/datum/adaptation/predatory/claws
	name = "Feral Claws"
	var/obj/item/melee/vampirearms/knife/protean/feral_claws/left_weapon
	var/obj/item/melee/vampirearms/knife/protean/feral_claws/right_weapon

/datum/adaptation/predatory/claws/activate(mob/living/carbon/owner)
	. = ..()
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	owner.visible_message(span_alert("[owner]'s hands begin to crack and distort, growing feral claws!"))
	ADD_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_1_TRAIT)
	owner.drop_all_held_items()
	left_weapon = new (owner)
	right_weapon = new (owner)
	owner.put_in_r_hand(left_weapon)
	owner.put_in_l_hand(right_weapon)

/datum/adaptation/predatory/claws/deactivate(mob/living/carbon/owner)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_1_TRAIT)
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	if(left_weapon)
		qdel(left_weapon)
	if(right_weapon)
		qdel(right_weapon)

/datum/adaptation/unnatural/claws/proc/deactivate_trigger()
	SIGNAL_HANDLER
	deactivate()