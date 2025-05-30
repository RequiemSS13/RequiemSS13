/datum/preferences/proc/reset_character()

//===========GENERAL===========
	real_name = random_unique_name(gender)
	ooc_notes = null
	flavor_text = null
	headshot_link = null // TFN EDIT
	info_known = INFO_KNOWN_UNKNOWN
	QDEL_NULL(stats)
	ooc_bond_pref = "Ask"
	ooc_ghoul_pref = "Ask"
	ooc_embrace_pref = "Ask"
	ooc_escalation_pref = "No"
	clane = null
	humanity = 7
	diablerist = 0
	masquerade = initial(masquerade)
	equipped_gear = list()
	random_species()
	random_character()
	save_character()
