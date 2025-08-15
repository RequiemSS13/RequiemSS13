/datum/preferences/proc/save_character()
	if(!path)
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/character[default_slot]"

	WRITE_FILE(S["version"], SAVEFILE_VERSION_MAX)	//load_character will sanitize any bad data, so assume up-to-date.)

//===========GENERAL===========
	WRITE_FILE(S["species"], pref_species.id)
	WRITE_FILE(S["info_known"], info_known)
	WRITE_FILE(S["gender"], gender)
	WRITE_FILE(S["real_name"], real_name)
	WRITE_FILE(S["true_real_name"], true_real_name)
	WRITE_FILE(S["body_type"], body_type)
	WRITE_FILE(S["age"], age)
	WRITE_FILE(S["flavor_text"], flavor_text)
	WRITE_FILE(S["ooc_notes"], ooc_notes)
	WRITE_FILE(S["headshot_link"], headshot_link) // TFN EDIT: headshot saving
	WRITE_FILE(S["hair_color"], hair_color)
	WRITE_FILE(S["facial_hair_color"], facial_hair_color)
	WRITE_FILE(S["hairstyle_name"], hairstyle)
	WRITE_FILE(S["facial_style_name"], facial_hairstyle)
	WRITE_FILE(S["eye_color"], eye_color)
	WRITE_FILE(S["skin_tone"], skin_tone)
	WRITE_FILE(S["underwear"], underwear)
	WRITE_FILE(S["underwear_color"], underwear_color)
	WRITE_FILE(S["undershirt"], undershirt)
	WRITE_FILE(S["undershirt_color"], undershirt_color)
	WRITE_FILE(S["socks"], socks)
	WRITE_FILE(S["backpack"], backpack)
	WRITE_FILE(S["persistent_scars"], persistent_scars)
	WRITE_FILE(S["reason_of_death"], reason_of_death)

	//Jobs
	WRITE_FILE(S["joblessrole"], joblessrole)

	//Write prefs
	WRITE_FILE(S["job_preferences"], job_preferences)
	WRITE_FILE(S["alt_titles_preferences"], alt_titles_preferences)

	//Merits
	WRITE_FILE(S["all_merits"], all_merits)
	WRITE_FILE(S["merit_custom_settings"], merit_custom_settings)

	//STATS
	WRITE_FILE(S["physique"], get_physique(FALSE))
	WRITE_FILE(S["stamina"], get_stamina(FALSE))
	WRITE_FILE(S["charisma"], get_charisma(FALSE))
	WRITE_FILE(S["composure"], get_composure(FALSE))
	WRITE_FILE(S["wits"], get_wits(FALSE))
	WRITE_FILE(S["resolve"], get_resolve(FALSE))
	WRITE_FILE(S["potency"], get_potency(FALSE))


	WRITE_FILE(S["equipped_gear"], equipped_gear)

	WRITE_FILE(S["ooc_bond_pref"], ooc_bond_pref)
	WRITE_FILE(S["ooc_ghoul_pref"], ooc_ghoul_pref)
	WRITE_FILE(S["ooc_embrace_pref"], ooc_embrace_pref)
	WRITE_FILE(S["ooc_escalation_pref"], ooc_escalation_pref)

//===========GHOUL/VAMPS===========
	WRITE_FILE(S["clan"], clane?.name)

	WRITE_FILE(S["humanity"], humanity)

	WRITE_FILE(S["masquerade"], masquerade)
	WRITE_FILE(S["clan_accessory"], clane_accessory)

	WRITE_FILE(S["discipline_types"], discipline_types)
	WRITE_FILE(S["discipline_levels"], discipline_levels)

	//-----------NEW ITEMS-----------
	WRITE_FILE(S["vamp_rank"], vamp_rank)
	WRITE_FILE(S["actual_age"], actual_age)
	WRITE_FILE(S["regent_clan"], regent_clan?.name)
	WRITE_FILE(S["vamp_faction"], vamp_faction?.name)
	WRITE_FILE(S["tempted"], tempted)

//===========WEREWOLVES===========
	WRITE_FILE(S["auspice"], auspice.name)
	WRITE_FILE(S["auspice_level"], auspice_level)
	WRITE_FILE(S["breed"], breed)
	WRITE_FILE(S["tribe"], tribe)
	WRITE_FILE(S["werewolf_color"], werewolf_color)
	WRITE_FILE(S["werewolf_scar"], werewolf_scar)
	WRITE_FILE(S["werewolf_hair"], werewolf_hair)
	WRITE_FILE(S["werewolf_hair_color"], werewolf_hair_color)
	WRITE_FILE(S["werewolf_eye_color"], werewolf_eye_color)
	WRITE_FILE(S["werewolf_name"], werewolf_name)
	return TRUE
