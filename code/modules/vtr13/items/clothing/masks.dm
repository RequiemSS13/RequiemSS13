
/obj/item/restraints/vampire/muzzle
	name = "muzzle"
	desc = "For prisoners deemed a bite risk."
	icon = 'icons/vtr13/obj/clothing/mask.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn_mask.dmi'
	icon_state = "muzzle"
	gender = PLURAL
	flags_1 = CONDUCT_1
	throwforce = 0
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_MASK
	escape_difficulty = 6
	var/cuffsound = 'sound/weapons/handcuffs.ogg'

/obj/item/restraints/vampire/muzzle/attack(mob/living/carbon/C, mob/living/user)
	if(!istype(C))
		return

	SEND_SIGNAL(C, COMSIG_CARBON_CUFF_ATTEMPTED, user)

	if(iscarbon(user) && (HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50)))
		to_chat(user, "<span class='warning'>Uh... how do those things work?!</span>")
		apply_muzzle(user,user)
		return

	if(!C.muzzled)
		if(!C.wear_mask)
			C.visible_message("<span class='danger'>[user] is trying to put [src.name] on [C]!</span>", \
								"<span class='userdanger'>[user] is trying to put [src.name] on you!</span>")
			playsound(loc, cuffsound, 30, TRUE, -2)
			log_combat(user, C, "attempted to muzzle")
			if(do_mob(user, C, 30))
				apply_muzzle(C, user)
				C.visible_message("<span class='notice'>[user] muzzles [C].</span>", \
									"<span class='userdanger'>[user] muzzles you.</span>")
				SSblackbox.record_feedback("tally", "muzzles", 1, type)

				log_combat(user, C, "muzzled")
			else
				to_chat(user, "<span class='warning'>You fail to muzzle [C]!</span>")
				log_combat(user, C, "failed to muzzle")
		else
			to_chat(user, "<span class='warning'>[C]'s mask is in the way!</span>")

/obj/item/restraints/vampire/muzzle/proc/apply_muzzle(mob/living/carbon/target, mob/user)
	if(target.muzzled)
		return
	var/obj/item/restraints/handcuffs/muzzle = src
	target.equip_to_slot_if_possible(muzzle, ITEM_SLOT_MASK)
	target.muzzled = src
	target.update_inv_muzzled()
	return


/obj/item/restraints/vampire/muzzle/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.wear_mask)
			to_chat(user, "<span class='warning'>You need help taking this off!</span>")
			return
	..()

/obj/item/restraints/vampire/muzzle/equipped(mob/user,slot)
	var/mob/living/carbon/C = user
	if(!C.muzzled && slot == ITEM_SLOT_MASK)
		apply_muzzle(user)
	..()
