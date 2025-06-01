/datum/preferences/proc/get_max_blood_potency()
	. = 0
	if(pref_species.name != "Vampire")
		return
	switch(vamp_rank)
		if(VAMP_RANK_HALF_DAMNED)
			. = 1
		if(VAMP_RANK_FLEDGLING)
			. = 1
		if(VAMP_RANK_NEONATE)
			. = 1
		if(VAMP_RANK_ANCILLAE)
			. = 3
		if(VAMP_RANK_ELDER)
			. = 5
		else
			. = 1

/datum/preferences/proc/adjust_blood_potency()
	var/max_blood_potency = get_max_blood_potency()
	if(pref_species.name == "Vampire")
		set_potency(clamp(get_potency(), 1, max_blood_potency))
	else
		set_potency(0)