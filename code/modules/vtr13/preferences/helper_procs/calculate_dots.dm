/datum/preferences/proc/calculate_dots()
	calculate_character_dots()
	calculate_discipline_dots()
	calculate_loadout_dots()
	calculate_merit_dots()
	adjust_blood_potency()


/datum/preferences/proc/calculate_character_dots()
	character_dots = 0
	switch(vamp_rank)
		if(VAMP_RANK_GHOUL)
			character_dots = CHARACTER_DOTS_GHOUL
		if(VAMP_RANK_FLEDGLING)
			character_dots = CHARACTER_DOTS_FLEDGLING
		if(VAMP_RANK_HALF_DAMNED)
			character_dots = CHARACTER_DOTS_HALF_DAMNED
		if(VAMP_RANK_NEONATE)
			character_dots = CHARACTER_DOTS_NEONATE
		if(VAMP_RANK_ANCILLAE)
			character_dots = CHARACTER_DOTS_ANCILLAE
		if(VAMP_RANK_ELDER)
			character_dots = CHARACTER_DOTS_ELDER
		else
			character_dots = CHARACTER_DOTS_DEFAULT

	character_dots -= clamp(get_physique(FALSE)-1, 5, 0)
	character_dots -= clamp(get_stamina(FALSE)-1, 5, 0)
	character_dots -= clamp(get_charisma(FALSE)-1, 5, 0)
	character_dots -= clamp(get_composure(FALSE)-1, 5, 0)
	character_dots -= clamp(get_wits(FALSE)-1, 5, 0)
	character_dots -= clamp(get_resolve(FALSE)-1, 5, 0)
	character_dots -= max(auspice_level - 1, 0)


/datum/preferences/proc/calculate_discipline_dots()
	discipline_dots = 0
	switch(vamp_rank)
		if(VAMP_RANK_GHOUL)
			discipline_dots = DISCIPLINE_DOTS_GHOUL
		if(VAMP_RANK_HALF_DAMNED)
			discipline_dots = DISCIPLINE_DOTS_HALF_DAMNED
		if(VAMP_RANK_FLEDGLING)
			discipline_dots = DISCIPLINE_DOTS_FLEDGLING
		if(VAMP_RANK_NEONATE)
			discipline_dots = DISCIPLINE_DOTS_NEONATE
		if(VAMP_RANK_ANCILLAE)
			discipline_dots = DISCIPLINE_DOTS_ANCILLAE
		if(VAMP_RANK_ELDER)
			discipline_dots = DISCIPLINE_DOTS_ELDER
		else
			discipline_dots = DISCIPLINE_DOTS_DEFAULT
	for(var/discipline_level in discipline_levels)
		discipline_dots -= discipline_level

	if(discipline_dots < 0)
		CRASH("Error - More discipline dots have been taken than there are dots to have!")

/datum/preferences/proc/calculate_loadout_dots(second_attempt = FALSE)
	if(!SSloadout?.initialized)
		return

	loadout_slots_max = LOADOUT_MAX_SLOTS
	loadout_slots = length(equipped_gear)

	loadout_dots_max = LOADOUT_MAX_DOTS

	if(all_merits.Find("Loaded"))
		loadout_slots_max += LOADOUT_LOADED_SLOT_BONUS
		loadout_dots_max += LOADOUT_LOADED_DOT_BONUS


	loadout_dots = loadout_dots_max
	if(!equipped_gear || !length(equipped_gear))
		return

	for(var/i = 1, i <= length(equipped_gear), i++)
		var/datum/gear/selected_gear = SSloadout.gear_datums[equipped_gear[i]]
		loadout_dots -= selected_gear.cost

	//this can actually happen; in this case we reset the whole thing n try again
	if(loadout_dots < 0 && !second_attempt)
		equipped_gear.Cut()
		calculate_loadout_dots(TRUE)
	else if(loadout_slots > loadout_slots_max && !second_attempt)
		equipped_gear.Cut()
		calculate_loadout_dots(TRUE)
	else if(second_attempt)
		CRASH("Error - More Loadout dots aren't adding up anymore!")

/datum/preferences/proc/calculate_merit_dots()
	merit_dots = MERIT_DOTS_BASE

	for(var/merit_name in all_merits)
		merit_dots -= SSmerits.merit_points[merit_name]

	if(merit_dots < 0)
		CRASH("Error - More merit dots have been taken than there are dots to have!")
