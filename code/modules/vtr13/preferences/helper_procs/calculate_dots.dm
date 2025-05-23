/datum/preferences/proc/calculate_dots()
	calculate_character_dots()
	calculate_discipline_dots()


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
	
	character_dots -= clamp(physique-1, 5, 0)
	character_dots -= clamp(stamina-1, 5, 0)
	character_dots -= clamp(charisma-1, 5, 0)
	character_dots -= clamp(composure-1, 5, 0)
	character_dots -= clamp(wits-1, 5, 0)
	character_dots -= clamp(resolve-1, 5, 0)
	character_dots -= max(auspice_level - 1, 0)
	if(character_dots < 0)
		CRASH("Error - More character dots have been taken than there are dots to have!")


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

/datum/preferences/proc/calculate_loadout_dots()
	loadout_slots_max = CONFIG_GET(number/max_loadout_items)
	loadout_slots = length(equipped_gear)

	loadout_dots_max = CONFIG_GET(number/base_loadout_points)
	loadout_dots = CONFIG_GET(number/base_loadout_points)
	if(!equipped_gear || !length(equipped_gear))
		return

	for(var/i = 1, i <= length(equipped_gear), i++)
		var/datum/gear/selected_gear = SSloadout.gear_datums[equipped_gear[i]]
		loadout_dots -= selected_gear.cost
	if(loadout_slots < 0)
		CRASH("Error - More Loadout Slots have been used then there are to begin with.")