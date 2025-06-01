/datum/preferences/proc/GetMeritCount(merit_category = MERIT_MERIT)
	. = 0
	for(var/merit_name in all_merits)
		var/datum/merit/merit_type = SSmerits.merits[merit_name]
		if(initial(merit_type.category) != merit_category)
			continue
		.++

/datum/preferences/proc/GetRequiredBanes()
	. = 0

	if(clane?.name == "Mekhet")
		. += BANES_MEKHET

	switch(vamp_rank)
		if(VAMP_RANK_ANCILLAE)
			. += BANES_ANCILLAE
		if(VAMP_RANK_ELDER)
			. += BANES_ELDER

/datum/preferences/proc/GetMaxLanguages()
	. = MAX_LANGUAGES
	if(all_merits.Find("Polyglot"))
		. += POLYGLOT_LANGUAGE_BONUS

/datum/preferences/proc/AddBanesUntilItIsDone()
	if(pref_species.name != "Vampire" )
		return

	var/banes_needed = GetRequiredBanes()
	var/current_banes = GetMeritCount(MERIT_BANE)


	if(current_banes >= banes_needed)
		return

	for(var/merit_name in SSmerits.merits_banes)
		if(all_merits.Find(merit_name))
			continue
		
		if(!SSmerits.CanAddMerit(src, SSmerits.merits_banes[merit_name]))
			continue
		
		all_merits += merit_name
		current_banes++
		if(current_banes >= banes_needed)
			break

	if(current_banes < banes_needed)
		CRASH("Could not add the minimum amount of required banes to character.")