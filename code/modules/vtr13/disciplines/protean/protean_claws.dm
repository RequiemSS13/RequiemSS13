/obj/item/melee/vampirearms/knife/protean
	name = "acid claws"
	icon_state = "gangrel"
	w_class = WEIGHT_CLASS_BULKY
	force = 6
	armour_penetration = 100	//It's magical damage
	block_chance = 20
	item_flags = DROPDEL
	masquerade_violating = TRUE
	is_iron = FALSE

/obj/item/melee/vampirearms/knife/protean/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/melee/vampirearms/knife/protean/Destroy()
	. = ..()
	REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT)

/obj/item/melee/vampirearms/knife/protean/afterattack(atom/target, mob/living/carbon/human/user, proximity)
	if(!proximity)
		return

	if(isliving(target))
		var/mob/living/living_target = target
		living_target.apply_damage(30, CLONE)
	return

//Feral claws
/obj/item/melee/vampirearms/knife/protean/feral_claws
	name = "feral claws"
	icon_state = "claws"
	item_flags = DROPDEL | HAND_ITEM
	force = 30

/obj/item/melee/vampirearms/knife/protean/feral_claws/afterattack(atom/target, mob/living/carbon/human/user, proximity)
	return

//Wicked claws
/obj/item/melee/vampirearms/knife/protean/feral_claws/wicked_claws
	name = "wicked claws"
	force = 60
