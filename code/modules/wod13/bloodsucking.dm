/mob/living/carbon/human/proc/add_bite_animation()
	remove_overlay(BITE_LAYER)
	var/mutable_appearance/bite_overlay = mutable_appearance('icons/wod13/icons.dmi', "bite", -BITE_LAYER)
	overlays_standing[BITE_LAYER] = bite_overlay
	apply_overlay(BITE_LAYER)
	spawn(15)
		if(src)
			remove_overlay(BITE_LAYER)

/proc/get_needed_difference_between_numbers(var/number1, var/number2)
	if(number1 > number2)
		return number1 - number2
	else if(number1 < number2)
		return number2 - number1
	else
		return 1

/mob/living/carbon/human/proc/drinksomeblood(var/mob/living/mob, first_drink = FALSE)
	last_drinkblood_use = world.time
	if(client)
		client.images -= suckbar
	qdel(suckbar)
	suckbar_loc = mob
	if(mob.blood_volume)
		suckbar = image('icons/wod13/bloodcounter.dmi', suckbar_loc, "[round(14*(mob.blood_volume/BLOOD_VOLUME_NORMAL))]", HUD_LAYER)
	suckbar.pixel_z = 40
	suckbar.plane = ABOVE_HUD_PLANE
	suckbar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	if(client)
		client.images += suckbar
	var/sound/heartbeat = sound('code/modules/wod13/sounds/drinkblood2.ogg', repeat = TRUE)
	if(HAS_TRAIT(src, TRAIT_BLOODY_SUCKER))
		src.emote("moan")
		Immobilize(30, TRUE)
	playsound_local(src, heartbeat, 75, 0, channel = CHANNEL_BLOOD, use_reverb = FALSE)
	if(isnpc(mob))
		var/mob/living/carbon/human/npc/NPC = mob
		NPC.danger_source = null
		mob.Stun(40) //NPCs don't get to resist

	if(mob.blood_volume <= BLOOD_VOLUME_BAD)
		to_chat(src, "<span class='warning'>Your victim's heart beats only weakly. Death comes for them.</span>")

	if(mob.bloodpool <= 0)
		if(iskindred(mob) && iskindred(src))
			if(!mob.client)
				to_chat(src, "<span class='warning'>You need [mob]'s attention to do that...</span>")
				return
			message_admins("[ADMIN_LOOKUPFLW(src)] is attempting to Diablerize [ADMIN_LOOKUPFLW(mob)]")
			log_attack("[key_name(src)] is attempting to Diablerize [key_name(mob)].")
			if(mob.key)
				var/vse_taki = TRUE
				if(!GLOB.canon_event)
					to_chat(src, "<span class='warning'>It's not a canon event!</span>")
					return

				if(vse_taki)
					to_chat(src, "<span class='userdanger'><b>YOU TRY TO COMMIT DIABLERIE ON [mob].</b></span>")
				else
					to_chat(src, "<span class='warning'>You find the idea of drinking your own <b>KIND</b> disgusting!</span>")
					return
			else
				to_chat(src, "<span class='warning'>You need [mob]'s attention to do that...</span>")
				return

	if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
		if(CheckEyewitness(src, src, 7, FALSE))
			AdjustMasquerade(-1)
	if(do_after(src, 30, target = mob, timed_action_flags = NONE, progress = FALSE))
		if(!iskindred(mob)) // vampires give vitae directly
			if(mob.maxbloodpool < 2) // very small animals just die instantly if you drink from them
				mob.blood_volume = 0
			else
				var/blood_coefficient = (5 / mob.bloodpool) //most animals give less blood; very large animals/misc supernaturals/unusual humans give more
				if(isghoul(mob)) // ghouls don't give more blood just because of their high bloodpool
					blood_coefficient = 1
				mob.blood_volume = max(0, (mob.blood_volume - (70*blood_coefficient)))
		else
			mob.adjustBloodPool(-1)
		suckbar.icon_state = "[round(14*(mob.blood_volume/BLOOD_VOLUME_NORMAL))]"
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			drunked_of |= "[H.dna.real_name]"
			if(H.reagents)
				if(length(H.reagents.reagent_list))
					if(prob(50))
						H.reagents.trans_to(src, min(10, H.reagents.total_volume), transfered_by = mob, methods = VAMPIRE)
		if(!(SEND_SIGNAL(mob, COMSIG_MOB_VAMPIRE_SUCKED, mob) & COMPONENT_RESIST_VAMPIRE_KISS))
			mob.apply_status_effect(/datum/status_effect/kissed)
		if(!ishuman(mob))
			if(get_potency() > 1)
				to_chat(src, "<span class='warning'>You drink the seawater blood of the creature, only sharpening the thirst at the back of your mind. It will not sustain you.</span>")
			else
				to_chat(src, "<span class='warning'>The thin, acrid blood of this creature can sustain you, for now, but your Beast howls its complaints.</span>")
		else if(!HAS_TRAIT(src, TRAIT_METHUSELAHS_THIRST) && HAS_TRAIT(mob, TRAIT_HONEYPOT))
			to_chat(src, "<span class='userlove'>You drink deeply of rich-tasting, powerful blood. There's something special about this vessel.</span>")
		else if(iskindred(mob))
			if (HAS_TRAIT(src, TRAIT_METHUSELAHS_THIRST))
				to_chat(src, "<span class='userlove'>The rich, sweet Vitae of your fellow monsters saturates your tongue, silencing your ancient thirst... for now.</span>")
			else
				to_chat(src, "<span class='userlove'>As you fill yourself with second-hand life, your Beast sings out a sickly, cannibalistic note.</span>")
		else if(HAS_TRAIT(src, TRAIT_METHUSELAHS_THIRST))
			to_chat(src, "<span class='warning'>You drink [mob]'s blood, but it is like eating air. It is not enough. You need the blood of your own kind; no other will do.</span>")
		else
			to_chat(src, "<span class='userlove'>Stolen life flows down your throat, as your thirst subsides...</span>")


		if(iskindred(mob))
			adjustBruteLoss(-10, TRUE)
			adjustFireLoss(-5, TRUE)
			if(first_drink)
				SScharacter_connection.add_connection(CONNECTION_BLOOD_BOND, src, mob)

		if(ishumanbasic(mob) && first_drink && HAS_TRAIT(src, TRAIT_WANTON_CURSE))
			SScharacter_connection.add_connection(CONNECTION_DAEVA_ADDITION, src, mob)

		var/drink_mod = 1
		if(!ishuman(mob) && get_potency() > 1)
			drink_mod = 0

		if(HAS_TRAIT(src, TRAIT_METHUSELAHS_THIRST) && !iskindred(mob))
			drink_mod = 0

		if(HAS_TRAIT(src, TRAIT_HUNGRY))
			drink_mod *= 0.5

		if(get_potency() >= 4 && !iskindred(mob))
			drink_mod *= 0.5

		if(HAS_TRAIT(mob, TRAIT_HONEYPOT))
			drink_mod *= 2

		if(drink_mod)
			adjustBloodPool(drink_mod*max(1, mob.bloodquality-1))

			adjustBruteLoss(-10, TRUE)
			adjustFireLoss(-5, TRUE)
			update_damage_overlays()
			update_health_hud()
			update_blood_hud()

		if(mob.bloodpool <= 0 || mob.blood_volume <= 50)
			if(iskindred(mob))
				var/mob/living/carbon/human/eaten_vampire = mob
				if(iskindred(src))
					var/datum/preferences/victim_prefs = GLOB.preferences_datums[ckey(mob.key)]
					if(victim_prefs)
						victim_prefs.reason_of_death =  "Diablerized by [true_real_name ? true_real_name : real_name] ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."

					AdjustHumanity(-1, 0)
					adjustBruteLoss(-50, TRUE)
					adjustFireLoss(-50, TRUE)
					if(SSroll.storyteller_roll(src.humanity + src.get_resolve() - eaten_vampire.get_potency(), 4, list(src, eaten_vampire), eaten_vampire) <= 4)
						to_chat(src, span_warning("You fail to diablerize [eaten_vampire]."))
						/*
						to_chat(src, "<span class='userdanger'><b>[eaten_vampire]'s SOUL OVERCOMES YOURS AND GAINS CONTROL OF YOUR BODY.</b></span>")
						message_admins("[ADMIN_LOOKUPFLW(src)] tried to Diablerize [ADMIN_LOOKUPFLW(mob)] and was overtaken.")
						log_attack("[key_name(src)] tried to Diablerize [key_name(mob)] and was overtaken.")
						blood_potency = eaten_vampire.get_potency()
						recalculate_max_health()
						if(our_prefs)
							our_prefs.reason_of_death = "Failed the Diablerie ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
						if(eaten_vampire.mind)
							eaten_vampire.mind.transfer_to(src, TRUE)
						else
							death()
						*/
						return
					else
						message_admins("[ADMIN_LOOKUPFLW(src)] successfully Diablerized [ADMIN_LOOKUPFLW(mob)]")
						log_attack("[key_name(src)] successfully Diablerized [key_name(mob)].")
						set_potency(max(eaten_vampire.get_potency(), get_potency()))
						ADD_TRAIT(src, TRAIT_DIABLERIE, eaten_vampire)
						recalculate_max_health()
						if(eaten_vampire.client)
							var/datum/brain_trauma/special/imaginary_friend/trauma = gain_trauma(/datum/brain_trauma/special/imaginary_friend)
							trauma.friend.key = eaten_vampire.key
						mob.death()

					if(client)
						client.images -= suckbar
					qdel(suckbar)
					return
				else
					eaten_vampire.blood_volume = 0
			if(ishuman(mob))
				if(mob.stat != DEAD)
					if(isnpc(mob))
						var/mob/living/carbon/human/npc/Npc = mob
						Npc.last_attacker = null
						killed_count = killed_count+1
						src.set_warrant(killed_count >= 5, sound='code/modules/wod13/sounds/humanity_loss.ogg')
					SEND_SOUND(src, sound('code/modules/wod13/sounds/feed_failed.ogg', 0, 0, 75))
					to_chat(src, "<span class='warning'>This sad sacrifice for your own pleasure affects something deep in your mind.</span>")
					AdjustMasquerade(-1)
					AdjustHumanity(-1, 0)
					mob.death()
			else
				if(mob.stat != DEAD)
					mob.death()
			stop_sound_channel(CHANNEL_BLOOD)
			last_drinkblood_use = 0
			if(client)
				client.images -= suckbar
			qdel(suckbar)
			return
		if(grab_state >= GRAB_PASSIVE)
			stop_sound_channel(CHANNEL_BLOOD)
			drinksomeblood(mob)
	else
		last_drinkblood_use = 0
		if(client)
			client.images -= suckbar
		qdel(suckbar)
		stop_sound_channel(CHANNEL_BLOOD)
		if(!(SEND_SIGNAL(mob, COMSIG_MOB_VAMPIRE_SUCKED, mob) & COMPONENT_RESIST_VAMPIRE_KISS))
			mob.remove_status_effect(/datum/status_effect/kissed)
