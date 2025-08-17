/mob/living/carbon/human/proc/AdjustHumanity(var/value, var/limit, var/forced = FALSE)
	if(iskindred(src) && GLOB.canon_event && !is_special_character(src)) // combined checks into one
		var/mod = 1
		if(clane && value < 0)
			mod = clane.humanitymod
		var/new_humanity = humanity
		var/adjustedvalue = clamp(humanity+(value * mod), 0, 10) // Clamp into valid range
		if(forced)
			new_humanity = adjustedvalue
		else if(value < 0 && adjustedvalue < limit || value > 0 && adjustedvalue > limit) // Don't move humanity past the action's adjustment limit
			new_humanity = limit
		else
			new_humanity = adjustedvalue
		if(new_humanity < 1 && !forced) // Only admins should be able to trigger a 0 humanity. Alert them if it almost happened.
			message_admins("[src?.key] on [src?.real_name] triggered a humanity loss that would place them at 0. The value has instead been set to 1.")
			SEND_SOUND(src, sound('code/modules/wod13/sounds/humanity_loss.ogg', 0, 0, 75))
			to_chat(src, "<span class='userdanger'><b>Your humanity hangs on by threads...!</b></span>")
			humanity = 1
			return
		if(new_humanity > humanity)
			SEND_SOUND(src, sound('code/modules/wod13/sounds/humanity_gain.ogg', 0, 0, 75))
			to_chat(src, "<span class='userhelp'><b>HUMANITY INCREASED!</b></span>")
		if(new_humanity < humanity)
			SEND_SOUND(src, sound('code/modules/wod13/sounds/humanity_loss.ogg', 0, 0, 75))
			to_chat(src, "<span class='userdanger'><b>HUMANITY DECREASED!</b></span>")
		humanity = new_humanity

/mob/living/carbon/human/proc/AdjustMasquerade(var/value, var/forced = FALSE)
	if(!iskindred(src) && !isghoul(src))
		return
	if(!GLOB.canon_event)
		return
	if (!forced)
		if(value > 0)
			if(HAS_TRAIT(src, TRAIT_VIOLATOR))
				return
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.zone_type != "masquerade")
				return
	if(!is_special_character(src) || forced)
		if(((last_masquerade_violation + 10 SECONDS) < world.time) || forced)
			last_masquerade_violation = world.time
			if(value < 0)
				if(masquerade > 0)
					masquerade = max(0, masquerade+value)
					SEND_SOUND(src, sound('code/modules/wod13/sounds/masquerade_violation.ogg', 0, 0, 75))
					to_chat(src, "<span class='userdanger'><b>MASQUERADE VIOLATION!</b></span>")
				SSbad_guys_party.next_fire = max(world.time, SSbad_guys_party.next_fire - 2 MINUTES)
			if(value > 0)
				for(var/mob/living/carbon/human/H in GLOB.player_list)
					H.voted_for -= dna.real_name
				if(masquerade < 5)
					masquerade = min(5, masquerade+value)
					SEND_SOUND(src, sound('code/modules/wod13/sounds/general_good.ogg', 0, 0, 75))
					to_chat(src, "<span class='userhelp'><b>MASQUERADE REINFORCED!</b></span>")
				SSbad_guys_party.next_fire = max(world.time, SSbad_guys_party.next_fire + 1 MINUTES)

	if(src in GLOB.masquerade_breakers_list)
		if(masquerade > 3)
			GLOB.masquerade_breakers_list -= src
	else if(masquerade < 4)
		GLOB.masquerade_breakers_list |= src

/mob/living/carbon/human/npc/proc/backinvisible(var/atom/A)
	switch(dir)
		if(NORTH)
			if(A.y >= y)
				return TRUE
		if(SOUTH)
			if(A.y <= y)
				return TRUE
		if(EAST)
			if(A.x >= x)
				return TRUE
		if(WEST)
			if(A.x <= x)
				return TRUE
	return FALSE

/mob/living/proc/CheckEyewitness(var/mob/living/source, var/mob/attacker, var/range = 0, var/affects_source = FALSE, var/type_of_infraction = INFRACTION_TYPE_DEFAULT)
	if(attacker.invisibility)
		return

	var/actual_range = range
	/*
	 = max(1, round(range*(attacker.alpha/255)))
	if(SScityweather.fogging)
		actual_range = round(actual_range/2)
	*/
	var/list/seenby = list()
	if(source.ignores_warrant)
		return

	for(var/mob/living/carbon/human/npc/NPC in oviewers(1, source))
		if(NPC.CheckMove())
			continue

		if(get_turf(src) == turn(NPC.dir, 180))
			continue

		if(!infraction_matters_to_npc(NPC, type_of_infraction))
			continue

		seenby |= NPC
		NPC.Aggro(attacker, FALSE)

	for(var/mob/living/carbon/human/npc/NPC in viewers(actual_range, source))
		if(NPC.CheckMove())
			continue

		if(affects_source && NPC == source)
			NPC.Aggro(attacker, TRUE)
			seenby |= NPC
			continue

		if(NPC.pulledby)
			continue

		var/turf/LC = get_turf(attacker)
		if(LC.get_lumcount() <= 0.25 && get_dist(NPC, attacker) >= 1)
			continue

		if(!NPC.backinvisible(attacker))
			continue

		if(!infraction_matters_to_npc(NPC, type_of_infraction))
			continue

		seenby |= NPC
		NPC.Aggro(attacker, FALSE)

	if(length(seenby) >= 1)
		return TRUE
	return FALSE

/mob/living/proc/infraction_matters_to_npc(mob/living/carbon/human/npc/our_npc, type_of_infraction = INFRACTION_TYPE_DEFAULT)
	switch(type_of_infraction)
		if(INFRACTION_TYPE_UGLY)
			if(our_npc.tolerates_ugly)
				return FALSE
	return TRUE

/mob/proc/can_respawn()
	if (client?.ckey)
		if (GLOB.respawn_timers[client.ckey])
			if ((GLOB.respawn_timers[client.ckey] + 10 MINUTES) > world.time)
				return FALSE
	return TRUE

/proc/get_vamp_skin_color(var/value = "albino")
	switch(value)
		if("caucasian1")
			return "vamp1"
		if("caucasian2")
			return "vamp2"
		if("caucasian3")
			return "vamp3"
		if("latino")
			return "vamp4"
		if("mediterranean")
			return "vamp5"
		if("asian1")
			return "vamp6"
		if("asian2")
			return "vamp7"
		if("arab")
			return "vamp8"
		if("indian")
			return "vamp9"
		if("african1")
			return "vamp10"
		if("african2")
			return "vamp11"
		else
			return value
