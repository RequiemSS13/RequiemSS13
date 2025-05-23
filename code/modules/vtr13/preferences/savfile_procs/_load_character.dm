/datum/preferences/proc/load_character(slot)
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE
	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"
	if(!slot)
		slot = default_slot
	slot = sanitize_integer(slot, 1, max_save_slots, initial(default_slot))
	if(slot != default_slot)
		default_slot = slot
		WRITE_FILE(S["default_slot"], slot)

	S.cd = "/character[slot]"
	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		return FALSE

//===========GENERAL===========
	//Species
	var/species_id
	READ_FILE(S["species"], species_id)
	if(species_id)
		var/newtype = GLOB.species_list[species_id]
		if(newtype)
			pref_species = new newtype

	READ_FILE(S["info_known"], info_known)
	
	READ_FILE(S["gender"], gender)
	gender = sanitize_gender(gender)

	READ_FILE(S["real_name"], real_name)
	real_name = reject_bad_name(real_name)
	if(!real_name)
		real_name = random_unique_name(gender)

	READ_FILE(S["body_type"], body_type)
	body_type = sanitize_gender(body_type, FALSE, FALSE, gender)

	READ_FILE(S["age"], age)
	age = sanitize_integer(age, AGE_MIN, AGE_MAX, initial(age))
	
	//PROFILE
	READ_FILE(S["flavor_text"], flavor_text)
	flavor_text = sanitize_text(flavor_text)

	READ_FILE(S["ooc_notes"], ooc_notes)
	ooc_notes = sanitize_text(ooc_notes)
	
	READ_FILE(S["headshot_link"], headshot_link)
	if(!valid_headshot_link(null, headshot_link, TRUE))
		headshot_link = null
	
	//ICON FEATURES
	READ_FILE(S["hair_color"], hair_color)
	hair_color = sanitize_hexcolor(hair_color, 3, 0)
	READ_FILE(S["facial_hair_color"], facial_hair_color)
	facial_hair_color = sanitize_hexcolor(facial_hair_color, 3, 0)
	READ_FILE(S["hairstyle_name"], hairstyle)
	hairstyle = sanitize_inlist(hairstyle, GLOB.hairstyles_list)
	READ_FILE(S["facial_style_name"], facial_hairstyle)
	facial_hairstyle = sanitize_inlist(facial_hairstyle, GLOB.facial_hairstyles_list)

	READ_FILE(S["eye_color"], eye_color)
	eye_color = sanitize_hexcolor(eye_color, 3, 0)
	READ_FILE(S["skin_tone"], skin_tone)
	skin_tone = sanitize_hexcolor(convert_old_skintone(skin_tone), 3, 0)

	//UNDERCLOTHES
	READ_FILE(S["underwear_color"], underwear_color)
	underwear_color = sanitize_hexcolor(underwear_color, 3, 0)

	READ_FILE(S["underwear"], underwear)
	underwear = sanitize_inlist(underwear, GLOB.underwear_list)
	
	READ_FILE(S["undershirt"], undershirt)
	undershirt = sanitize_inlist(undershirt, GLOB.undershirt_list)

	READ_FILE(S["socks"], socks)
	socks = sanitize_inlist(socks, GLOB.socks_list)

	READ_FILE(S["backpack"], backpack)
	backpack = sanitize_inlist(backpack, GLOB.backpacklist, initial(backpack))

	//PERSISTANCE
	READ_FILE(S["persistent_scars"], persistent_scars)
	persistent_scars = sanitize_integer(persistent_scars)
	
	READ_FILE(S["reason_of_death"], reason_of_death)
	reason_of_death = sanitize_text(reason_of_death)

	//JOBS
	READ_FILE(S["joblessrole"], joblessrole)
	joblessrole	= sanitize_integer(joblessrole, 1, 3, initial(joblessrole))

	READ_FILE(S["job_preferences"], job_preferences)
	for(var/j in job_preferences)
		if(job_preferences[j] != JP_LOW && job_preferences[j] != JP_MEDIUM && job_preferences[j] != JP_HIGH)
			job_preferences -= j
	
	READ_FILE(S["alt_titles_preferences"], alt_titles_preferences)
	alt_titles_preferences = SANITIZE_LIST(alt_titles_preferences)
	if(SSjob)
		for(var/datum/job/job in sortList(SSjob.occupations, /proc/cmp_job_display_asc))
			if(alt_titles_preferences[job.title])
				if(!(alt_titles_preferences[job.title] in job.alt_titles))
					alt_titles_preferences.Remove(job.title)
	
	//QUIRKS
	READ_FILE(S["all_quirks"], all_quirks)
	all_quirks = SANITIZE_LIST(all_quirks)
	validate_quirks()


	//STATS
	READ_FILE(S["physique"], physique)
	physique = sanitize_integer(physique, 1, 5, 1)
	//-----------NEW ITEMS-----------
	READ_FILE(S["stamina"], stamina)
	stamina = sanitize_integer(stamina, 1, 5, 1)

	READ_FILE(S["charisma"], charisma)
	charisma = sanitize_integer(charisma, 1, 5, 1)

	READ_FILE(S["composure"], composure)
	composure = sanitize_integer(composure, 1, 5, 1)

	READ_FILE(S["wits"], wits)
	wits = sanitize_integer(wits, 1, 5, 1)

	READ_FILE(S["resolve"], resolve)
	resolve = sanitize_integer(resolve, 1, 5, 1)

	READ_FILE(S["equipped_gear"], equipped_gear)
	if(!equipped_gear)
		equipped_gear = list()
	else if(config && (length(equipped_gear) > CONFIG_GET(number/max_loadout_items)))
		to_chat(parent, span_userdanger("Loadout maximum items exceeded in loaded slot, Your loadout has been cleared! You had [length(equipped_gear)]/[CONFIG_GET(number/max_loadout_items)] equipped items!"))
		equipped_gear = list()
	else
		equipped_gear = sanitize_each_inlist(equipped_gear, SSloadout.gear_datums)

	READ_FILE(S["ooc_bond_pref"], ooc_bond_pref)
	if(!ooc_bond_pref)
		ooc_bond_pref = "Ask"
	READ_FILE(S["ooc_ghoul_pref"], ooc_ghoul_pref)
	if(!ooc_ghoul_pref)
		ooc_ghoul_pref = "Ask"
	READ_FILE(S["ooc_embrace_pref"], ooc_embrace_pref)
	if(!ooc_embrace_pref)
		ooc_embrace_pref = "Ask"
	READ_FILE(S["ooc_escalation_pref"], ooc_escalation_pref)
	if(!ooc_escalation_pref)
		ooc_escalation_pref = "No"

//===========GHOUL/VAMPS===========
	var/clane_id
	READ_FILE(S["clan"], clane_id)
	if(clane_id)
		var/newtype = GLOB.clanes_list[clane_id]
		if(newtype)
			clane = new newtype

	READ_FILE(S["humanity"], humanity)
	humanity = sanitize_integer(humanity, 0, 10, initial(humanity))

	//Prevent Wighting upon joining a round
	if(humanity <= 0)
		humanity = 1

	READ_FILE(S["diablerist"], diablerist)
	diablerist = sanitize_integer(diablerist, 0, 1, initial(diablerist))

	READ_FILE(S["masquerade"], masquerade)
	masquerade = sanitize_integer(masquerade, 0, 5, initial(masquerade))

	READ_FILE(S["clan_accessory"], clane_accessory)
	if(clane?.accessories)
		clane_accessory = sanitize_inlist(clane_accessory, clane.accessories, null)
	else
		clane_accessory = null

	//Disciplines
	READ_FILE(S["discipline_types"], discipline_types)
	discipline_types = sanitize_islist(discipline_types, list())
	
	READ_FILE(S["discipline_levels"], discipline_levels)
	discipline_levels = sanitize_islist(discipline_levels, list())
	
	//-----------NEW ITEMS-----------
	READ_FILE(S["vamp_rank"], vamp_rank)
	vamp_rank = sanitize_integer(vamp_rank, VAMP_RANK_GHOUL, VAMP_RANK_ELDER, VAMP_RANK_GHOUL)

	READ_FILE(S["actual_age"], actual_age)
	actual_age = sanitize_integer(actual_age, age, 6000, age)

	var/regent_clan_id
	READ_FILE(S["regent_clan"], regent_clan_id)
	if(regent_clan_id)
		var/newtype = GLOB.clanes_list[regent_clan_id]
		if(newtype)
			regent_clan = new newtype
	
	var/vampire_faction_id
	READ_FILE(S["vamp_faction"], vampire_faction_id)
	if(vampire_faction_id)
		var/faction = GLOB.factions_list[vampire_faction_id]
		if(faction)
			vamp_faction = new faction()
		else
			vamp_faction = new /datum/vtr_faction/vamp_faction/unaligned()
	
	READ_FILE(S["tempted"], tempted)
	tempted = clamp(tempted, 0, 3)

//===========WEREWOLVES===========
	var/auspice_id
	READ_FILE(S["auspice"], auspice_id)
	if(auspice_id)
		var/newtype = GLOB.auspices_list[auspice_id]
		if(newtype)
			auspice = new newtype

	READ_FILE(S["auspice_level"], auspice_level)
	auspice_level = sanitize_integer(auspice_level, 1, 5, initial(auspice_level))

	READ_FILE(S["breed"], breed)
	breed = sanitize_inlist(breed, list("Homid", "Lupus", "Metis"))
	
	READ_FILE(S["tribe"], tribe)
	tribe = sanitize_inlist(tribe, list("Wendigo", "Glasswalkers", "Black Spiral Dancers"))
	
	READ_FILE(S["werewolf_color"], werewolf_color)
	werewolf_color = sanitize_inlist(werewolf_color, list("black", "gray", "red", "white", "ginger", "brown"))
	
	READ_FILE(S["werewolf_scar"], werewolf_scar)
	werewolf_scar = sanitize_integer(werewolf_scar, 0, 7, initial(werewolf_scar))

	READ_FILE(S["werewolf_hair"], werewolf_hair)
	werewolf_hair = sanitize_integer(werewolf_hair, 0, 4, initial(werewolf_hair))

	READ_FILE(S["werewolf_hair_color"], werewolf_hair_color)
	werewolf_hair_color = sanitize_ooccolor(werewolf_hair_color, 3, 0)

	READ_FILE(S["werewolf_eye_color"], werewolf_eye_color)
	werewolf_eye_color = sanitize_ooccolor(werewolf_eye_color, 3, 0)

	READ_FILE(S["werewolf_name"], werewolf_name)
	werewolf_name = reject_bad_name(werewolf_name)



//===========Character Connections===========
	character_connections = SScharacter_connection.get_character_connections(parent.ckey, real_name)
	SScharacter_connection.retire_all_stale_endorsements(parent, parent.ckey, real_name)
	endorsement_roles_eligable = SScharacter_connection.get_eligible_faction_head_roles(parent.ckey, real_name)

	//try to fix any outdated data if necessary
	//preference updating will handle saving the updated data for us.
	if(needs_update >= 0)
		update_character(needs_update, S)		//needs_update == savefile_version if we need an update (positive integer)

	return TRUE
