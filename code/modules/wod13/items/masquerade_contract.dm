/obj/item/masquerade_contract
	name = "Masquerade Contract"
	desc = "See where to search the shitty Masquerade breakers. <b>CLICK ON the Contract to see possible breakers for catching. PUSH the target in torpor, to restore the Masquerade</b>"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	icon_state = "masquerade"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/masquerade_contract/attack_self(mob/user)
	. = ..()
	if(length(GLOB.masquerade_breakers_list))
		var/turf/UT = get_turf(user)
		if(UT)
			to_chat(user, "<b>YOU</b>, [get_area_name(user)] X:[UT.x] Y:[UT.y]")
		for(var/mob/living/carbon/human/H in GLOB.masquerade_breakers_list)
			var/turf/TT = get_turf(H)
			if(TT)
				to_chat(user, "[H.true_real_name], Masquerade: [H.masquerade], Diablerist: [H.diablerist ? "<b>YES</b>" : "NO"], [get_area_name(H)] X:[TT.x] Y:[TT.y]")
	else
		to_chat(user, "No available Masquerade breakers in city...")
/*
/obj/item/masquerade_contract/attack(mob/living/M, mob/living/user)
	. = ..()
	if(iskindred(M) || isghoul(M))
		var/mob/living/carbon/human/D = M
		if(D.diablerist)
			if(!GLOB.canon_event)
				to_chat(user, "This is not a canon event!")
				return
			if(!M.client)
				to_chat(user, "You need [M] attention to do that.")
				return
			if(M.stat >= HARD_CRIT)
				var/datum/preferences/P = GLOB.preferences_datums[ckey(M.key)]
//				var/extra = FALSE
//				if(D.diablerist)
//					extra = TRUE
				M.death()
				if(P)
					P.reason_of_death = "Executed to sustain the Traditions ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
					reset_shit(M)
				M.ghostize(FALSE)
				to_chat(user, "<b>Successfully punished Traditions violator and restored the Masquerade.</b>")
				var/mob/living/carbon/human/HM = user
				HM.AdjustMasquerade(1)
				HM.total_contracted += 2
				return
		if(M in GLOB.masquerade_breakers_list)
			if(!GLOB.canon_event)
				to_chat(user, "This is not a canon event!")
				return
			if(!M.client)
				to_chat(user, "You need [M] attention to do that.")
				return
			if(M.stat >= HARD_CRIT)
				var/datum/preferences/P = GLOB.preferences_datums[ckey(M.key)]
//				var/extra = FALSE
//				if(D.diablerist)
//					extra = TRUE
				M.death()
				if(P)
					P.reason_of_death = "Executed to sustain the Traditions ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
					reset_shit(M)
				M.ghostize(FALSE)
				to_chat(user, "<b>Successfully punished Traditions violator and restored the Masquerade.</b>")
				var/mob/living/carbon/human/HM = user
				HM.AdjustMasquerade(1)
				HM.total_contracted += 1
//				if(user.key)
//					if(P)
//						if(extra)
//							P.exper = min(calculate_mob_max_exper(user), P.exper+1000)
//						else
//							P.exper = min(calculate_mob_max_exper(user), P.exper+500)
				return
			else
				to_chat(user, "Target must be in critical condition or torpor.")
				return
		else
			to_chat(user, "Target must have at least 2 Masquerade violations.")
			return
	else
		to_chat(user, "Target must be kindred or ghoul.")
		return
*/
