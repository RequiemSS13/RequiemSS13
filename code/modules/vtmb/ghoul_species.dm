/datum/species/ghoul
	name = "Ghoul"
	id = "ghoul"
	default_color = "FFFFFF"
	toxic_food = RAW
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_NOCRITDAMAGE)
	use_skintones = TRUE
	limbs_id = "human"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 1	//0.8 instead, if changing.
	burnmod = 1
	punchdamagelow = 10
	punchdamagehigh = 20
	dust_anim = "dust-h"
	var/mob/living/carbon/human/master
	var/last_vitae = 0
	var/list/datum/discipline/disciplines = list()
	selectable = TRUE

/datum/species/ghoul/on_species_gain(mob/living/carbon/human/C)
	..()
	C.update_body(0)
	C.last_experience = world.time+3000
	// TFN EDIT BEGIN - Memories should be components
	if(C.mind)
		C.mind.refresh_memory()
	// TFN EDIT END

	var/datum/discipline/bloodheal/giving_bloodheal = new(1)
	C.give_discipline(giving_bloodheal)


	C.maxbloodpool = 5 + C.get_stamina()
	C.adjustBloodPool(rand(C.get_composure(), C.maxbloodpool), TRUE)
	C.recalculate_max_health()
	C.update_auspex_hud_vtr()

/datum/species/ghoul/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	for(var/datum/action/A in C.actions)
		if(A)
			if(A.vampiric)
				A.Remove(C)
	C.update_auspex_hud_vtr()

/datum/action/take_vitae //unused
	name = "Take Vitae"
	desc = "Take vitae from a Vampire by force."
	button_icon_state = "ghoul"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/taking = FALSE

/datum/action/take_vitae/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		if(istype(H.pulling, /mob/living/carbon/human))
			var/mob/living/carbon/human/VIT = H.pulling
			if(iskindred(VIT))
				if(VIT.bloodpool)
					if(VIT.getBruteLoss() > 30)
						taking = TRUE
						if(do_mob(owner, VIT, 10 SECONDS))
							taking = FALSE
							H.drunked_of |= "[VIT.dna.real_name]"
							H.adjustBruteLoss(-25, TRUE)
							H.adjustFireLoss(-25, TRUE)
							VIT.adjustBloodPool(-1)
							H.adjustBloodPool(1)
							H.update_blood_hud()
							to_chat(owner, "<span class='warning'>You feel precious <b>VITAE</b> entering your mouth and suspending your addiction.</span>")
							return
						else
							taking = FALSE
							return
					else
						to_chat(owner, "<span class='warning'>Damage [VIT] before taking vitae.</span>")
						return
				else
					to_chat(owner, "<span class='warning'>There is not enough <b>VITAE</b> in [VIT] to feed your addiction.</span>")
					return
			else
				to_chat(owner, "<span class='warning'>You don't sense the <b>VITAE</b> in [VIT].</span>")
				return
/*
/datum/action/blood_heal
	name = "Blood Heal"
	desc = "Use vitae in your blood to heal your wounds."
	button_icon_state = "bloodheal"
	button_icon = 'icons/wod13/UI/actions.dmi'
	background_icon_state = "discipline"
	icon_icon = 'icons/wod13/UI/actions.dmi'
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/last_heal = 0
	var/level = 1

/datum/action/blood_heal/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	if(owner.mind)
		button_icon = 'icons/wod13/UI/actions.dmi'
		icon_icon = 'icons/wod13/UI/actions.dmi'
	. = ..()

/datum/action/blood_heal/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		if (HAS_TRAIT(owner, TRAIT_TORPOR))
			return
		var/mob/living/carbon/human/H = owner
		level = clamp(H.get_potency(), 1, 4)
		if(HAS_TRAIT(H, TRAIT_COFFIN_THERAPY))
			if(!istype(H.loc, /obj/structure/closet/crate/coffin))
				to_chat(usr, "<span class='warning'>You need to be in a coffin to use that!</span>")
				return
		if(H.bloodpool < 1)
			to_chat(owner, "<span class='warning'>You don't have enough <b>BLOOD</b> to do that!</span>")
			SEND_SOUND(H, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
			return
		if((last_heal + 30) >= world.time)
			return
		last_heal = world.time
		H.adjustBloodPool(-1)
		SEND_SOUND(H, sound('code/modules/wod13/sounds/bloodhealing.ogg', 0, 0, 50))
		H.heal_overall_damage(15*level, 2.5*level, 20*level)
		H.adjustBruteLoss(-15*level, TRUE)
		H.adjustFireLoss(-2.5*level, TRUE)
		H.adjustOxyLoss(-20*level, TRUE)
		H.adjustToxLoss(-20*level, TRUE)
		H.blood_volume = min((H.blood_volume + 50), BLOOD_VOLUME_NORMAL)
		button.color = "#970000"
		animate(button, color = "#ffffff", time = 20, loop = 1)
		if(length(H.all_wounds))
			for(var/i in 1 to min(5, length(H.all_wounds)))
				var/datum/wound/W = pick(H.all_wounds)
				W.remove_wound()
		H.adjustCloneLoss(-5, TRUE)
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			H.adjust_blindness(-2)
			H.adjust_blurriness(-2)
			eyes.applyOrganDamage(-5)
		var/obj/item/organ/brain/brain = H.getorganslot(ORGAN_SLOT_BRAIN)
		if(brain)
			brain.applyOrganDamage(-100)
		H.update_damage_overlays()
		H.update_health_hud()
		H.update_blood_hud()
		H.visible_message("<span class='warning'>Some of [H]'s visible injuries disappear!</span>", "<span class='warning'>Some of your injuries disappear!</span>")

*/
/datum/species/ghoul/check_roundstart_eligible()
	return TRUE

/datum/species/ghoul/spec_life(mob/living/carbon/human/H)
	. = ..()
	H.visible_masquerade_check()
	if(istype(get_area(H), /area/vtm))
		var/area/vtm/V = get_area(H)
		if(V.zone_type == "masquerade" && V.upper)
			if(H.pulling)
				if(ishuman(H.pulling))
					var/mob/living/carbon/human/pull = H.pulling
					if(pull.stat == DEAD)
						var/obj/item/card/id/id_card = H.get_idcard(FALSE)
						if(!istype(id_card, /obj/item/card/id/clinic))
							if(H.CheckEyewitness(H, H, 7, FALSE))
								if(H.last_loot_check+50 <= world.time)
									H.last_loot_check = world.time
									H.last_nonraid = world.time
									H.killed_count = H.killed_count+1
									H.set_warrant(H.killed_count >= 5, "SUSPICIOUS ACTION (corpse)")
			for(var/obj/item/I in H.contents)
				if(I)
					if(I.masquerade_violating)
						if(I.loc == H)
							if(H.CheckEyewitness(H, H, 7, FALSE))
								if(H.last_loot_check+50 <= world.time)
									H.last_loot_check = world.time
									H.last_nonraid = world.time
									H.killed_count = H.killed_count+1
									H.set_warrant(H.killed_count >= 5, "SUSPICIOUS ACTION (equipment)")

	if(H.key && H.stat != DEAD)
		var/datum/preferences/P = GLOB.preferences_datums[ckey(H.key)]
		if(P)
			if(P.masquerade != H.masquerade)
				P.masquerade = H.masquerade
				P.save_preferences()
				P.save_character()

/datum/species/human/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(istype(get_area(H), /area/vtm))
		var/area/vtm/V = get_area(H)
		if(V.zone_type == "masquerade" && V.upper)
			if(H.pulling)
				if(ishuman(H.pulling))
					var/mob/living/carbon/human/pull = H.pulling
					if(pull.stat == DEAD)
						var/obj/item/card/id/id_card = H.get_idcard(FALSE)
						if(!istype(id_card, /obj/item/card/id/clinic))
							if(H.CheckEyewitness(H, H, 7, FALSE))
								if(H.last_loot_check+50 <= world.time)
									H.last_loot_check = world.time
									H.last_nonraid = world.time
									H.killed_count = H.killed_count+1
									H.set_warrant(H.killed_count >= 5, "SUSPICIOUS ACTION (corpse)")
			for(var/obj/item/I in H.contents)
				if(I)
					if(I.masquerade_violating)
						if(I.loc == H)
							if(H.CheckEyewitness(H, H, 7, FALSE))
								if((H.last_loot_check + 5 SECONDS) <= world.time)
									H.last_loot_check = world.time
									H.last_nonraid = world.time
									H.killed_count = H.killed_count+1
									H.set_warrant(H.killed_count >= 5, "SUSPICIOUS ACTION (equipment)")

/datum/species/garou/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(HAS_TRAIT(H, TRAIT_UNMASQUERADE))
		if(H.CheckEyewitness(H, H, 7, FALSE))
			H.adjust_veil(-1)
	if(istype(get_area(H), /area/vtm))
		var/area/vtm/V = get_area(H)
		if(V.zone_type == "masquerade" && V.upper)
			if(H.pulling)
				if(ishuman(H.pulling))
					var/mob/living/carbon/human/pull = H.pulling
					if(pull.stat == DEAD)
						var/obj/item/card/id/id_card = H.get_idcard(FALSE)
						if(!istype(id_card, /obj/item/card/id/clinic))
							if(H.CheckEyewitness(H, H, 7, FALSE))
								if(H.last_loot_check+50 <= world.time)
									H.last_loot_check = world.time
									H.last_nonraid = world.time
									H.killed_count = H.killed_count+1
									H.set_warrant(H.killed_count >= 5, "SUSPICIOUS ACTION (corpse)")
			for(var/obj/item/I in H.contents)
				if(I)
					if(I.masquerade_violating)
						if(I.loc == H)
							if(H.CheckEyewitness(H, H, 7, FALSE))
								if(H.last_loot_check+50 <= world.time)
									H.last_loot_check = world.time
									H.last_nonraid = world.time
									H.killed_count = H.killed_count+1
									H.set_warrant(H.killed_count >= 5, "SUSPICIOUS ACTION (equipment)")
	if((H.last_bloodpool_restore + 60 SECONDS) <= world.time)
		H.last_bloodpool_restore = world.time
		H.adjustBloodPool(1)
	if(glabro)
		if(H.CheckEyewitness(H, H, 7, FALSE))
			H.adjust_veil(-1)

/**
 * Accesses a certain Discipline that a Ghoul has. Returns false if they don't.
 *
 * Arguments:
 * * searched_discipline - Name or typepath of the Discipline being searched for.
 */
/datum/species/ghoul/proc/get_discipline(searched_discipline)
	for(var/datum/discipline/discipline in disciplines)
		if (ispath(searched_discipline, /datum/discipline))
			if (istype(discipline, searched_discipline))
				return discipline
		else if (istext(searched_discipline))
			if (discipline.name == searched_discipline)
				return discipline

	return FALSE
