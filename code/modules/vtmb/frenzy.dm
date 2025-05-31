
/datum/species/kindred/spec_life(mob/living/carbon/human/H)
	. = ..()
	//FIRE FEAR
	if(!HAS_TRAIT(H, TRAIT_KNOCKEDOUT))
		var/fearstack = 0
		for(var/obj/effect/fire/F in GLOB.fires_list)
			if(F)
				if(get_dist(F, H) < 8 && F.z == H.z)
					fearstack += F.stage
		for(var/mob/living/carbon/human/U in viewers(7, H))
			if(U.on_fire)
				fearstack += 1

		fearstack = min(fearstack, 10)

		if(fearstack)
			if(prob(fearstack*5))
				H.do_jitter_animation(10)
				if(H.mind && fearstack > 20 && prob(fearstack))
					H.mind.try_frenzy(-2)
			if(!H.has_status_effect(STATUS_EFFECT_FEAR))
				H.apply_status_effect(STATUS_EFFECT_FEAR)
		else
			H.remove_status_effect(STATUS_EFFECT_FEAR)

	//VTR EDIT - frontload masquerade violations into traits, remove clane check
	H.visible_masquerade_check()
	//VTR EDIT END

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
							var/obj/item/card/id/id_card = H.get_idcard(FALSE)
							if(!istype(id_card, /obj/item/card/id/clinic))
								if(H.CheckEyewitness(H, H, 7, FALSE))
									if(H.last_loot_check+50 <= world.time)
										H.last_loot_check = world.time
										H.last_nonraid = world.time
										H.killed_count = H.killed_count+1
										H.set_warrant(H.killed_count >= 5, "SUSPICIOUS ACTION (equipment)")

	if(H.key && (H.stat <= HARD_CRIT))
		var/datum/preferences/P = GLOB.preferences_datums[ckey(H.key)]
		if(P)
			if(P.humanity != H.humanity)
				P.humanity = H.humanity
				P.save_character()
			if(P.masquerade != H.masquerade)
				P.masquerade = H.masquerade
				P.save_character()

			if(P.humanity < 1 && H.mind)
				H.mind.trigger_draugr()
				P.reason_of_death = "Lost control to the Beast ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."

	if(H.mind && !HAS_TRAIT(H, TRAIT_KNOCKEDOUT))
		if(H.bloodpool <= 1 && !HAS_TRAIT(H.mind, TRAIT_IN_FRENZY))
			if((H.last_frenzy_check + 40 SECONDS) <= world.time)
				H.last_frenzy_check = world.time
				H.mind.try_frenzy()
		else
			H.last_frenzy_check = world.time

