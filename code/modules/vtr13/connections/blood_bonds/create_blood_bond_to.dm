/mob/living/proc/create_blood_bond_to(mob/living/carbon/human/domitor, artificial = FALSE)
	
	if(!can_be_blood_bonded_by(domitor))
		return 0
	
	var/bond_type = CONNECTION_BLOOD_BOND_1
	var/thrall_description = "I am bound by a first-stage blood bond to [domitor.true_real_name]."
	var/domitor_description = "I have put a first-stage blood bond upon [true_real_name]."
	var/resulting_bond = 1

	var/datum/character_connection/existing_connection = get_existing_mutual_blood_bond(domitor)
	if(existing_connection)
		switch(existing_connection.group_type)
			if(CONNECTION_BLOOD_BOND_1)
				bond_type = CONNECTION_BLOOD_BOND_2
				thrall_description = "I am enraptured by a second-stage blood bond to [domitor.true_real_name]."
				domitor_description = "I have caught [true_real_name] in a second-stage blood bond."
				resulting_bond = 2
			if(CONNECTION_BLOOD_BOND_2)
				bond_type = CONNECTION_BLOOD_BOND_3
				thrall_description = "I am a Thrall, transfixed by a third-stage blood bond to [domitor.true_real_name], my Regent."
				domitor_description = "I have trapped [true_real_name] in a third-stage blood bond. I am their Regent and they are my Thrall."
				resulting_bond = 3
			if(CONNECTION_BLOOD_BOND_3)
				return 3 //A blood bond can not go higher than stage 3

	message_admins("[ADMIN_LOOKUPFLW(domitor)] has bloodbonded [ADMIN_LOOKUPFLW(src)] with [bond_type].")
	log_game("[key_name(domitor)] has bloodbonded [key_name(src)] with [bond_type].")

	var/purge_other_blood_bonds = FALSE
	switch(bond_type)
		if(CONNECTION_BLOOD_BOND_1)
			to_chat(src, "<span class='userlove'>You feel a deep sense of familiarity with [domitor].</span>")
		
		if(CONNECTION_BLOOD_BOND_2)
			to_chat(src, "<span class='userlove'>You begin to long for [domitor]'s presence.</span>")

		if(CONNECTION_BLOOD_BOND_3)
			purge_other_blood_bonds = TRUE
			to_chat(src, "<span class='userlove'>You lose yourself in your devotion to [domitor]!</span>")

	if(purge_other_blood_bonds && !artificial)
		artificial = tgui_alert(src, "Do you wish to permanently enter into a third stage blood bond? This will remove all lower level blood bonds.", "Confirmation", list("Yes", "No")) == "Yes"

	//Handle Ghouling
	var/ghoul_response_domitor = tgui_alert(domitor, "Do you wish to turn [src] into a ghoul?.", "Confirmation", list("Yes", "No")) == "Yes"
	var/ghoul_response_thrall = handle_ghouling(domitor, artificial, ghoul_response_domitor)


	if(!artificial)
		handle_insert_blood_bond_db(domitor, bond_type, thrall_description, domitor_description, existing_connection, purge_other_blood_bonds, ghoul_response_domitor, ghoul_response_thrall)
	else
		create_artificial_blood_bond(domitor, bond_type, thrall_description, domitor_description, existing_connection)
	return resulting_bond



/mob/living/proc/handle_ghouling(mob/living/carbon/human/domitor, artificial, ghoul_response_domitor)

	if(artificial || !ishumanbasic(src) || !ghoul_response_domitor)
		return FALSE

	var/mob/living/carbon/human/blood_bonded_human = src
	blood_bonded_human.set_species(/datum/species/ghoul)
	blood_bonded_human.clane = null
	blood_bonded_human.roundstart_vampire = FALSE
	var/datum/species/ghoul/g_species = blood_bonded_human.dna.species
	g_species.master = domitor
	g_species.last_vitae = world.time


	var/response_ghoul  = tgui_alert(src, "You have been ghouled! Do you wish to keep being a ghoul on your save slot?", "Confirmation", list("Yes", "No")) == "Yes"
	if(!response_ghoul)
		return FALSE

	var/datum/preferences/BLOODBONDED_prefs_g = blood_bonded_human.client.prefs
	if(BLOODBONDED_prefs_g.discipline_types.len == 3)
		for (var/i in 1 to 3)
			var/removing_discipline = BLOODBONDED_prefs_g.discipline_types[1]
			if (removing_discipline)
				var/index = BLOODBONDED_prefs_g.discipline_types.Find(removing_discipline)
				BLOODBONDED_prefs_g.discipline_types.Cut(index, index + 1)
				BLOODBONDED_prefs_g.discipline_levels.Cut(index, index + 1)
	BLOODBONDED_prefs_g.pref_species.name = "Ghoul"
	BLOODBONDED_prefs_g.pref_species.id = "ghoul"
	BLOODBONDED_prefs_g.save_character()

	return TRUE

/mob/living/proc/handle_insert_blood_bond_db(mob/living/carbon/human/domitor, bond_type, thrall_description, domitor_description, datum/character_connection/existing_connection, purge_other_blood_bonds, ghoul_response_domitor, ghoul_response_thrall)

	
	var/save_decision = TRUE
	
	if(ghoul_response_domitor && !ghoul_response_thrall)
		save_decision = tgui_alert(src, "Would you like to instead keep the blood bond permanently?", "Confirmation", list("Yes", "No")) == "Yes"
	else if(!ghoul_response_domitor)
		save_decision = tgui_alert(src, "You have been blood bonded by [domitor]! Would you like to keep the blood bond permanently?", "Confirmation", list("Yes", "No")) == "Yes"

	if(!save_decision)
		return
	
	//Retire existing blood bond connection
	if(existing_connection)
		retire_character_connection_by_group_id(existing_connection.group_id)

	if(purge_other_blood_bonds)
		retire_all_character_connection_blood_bonds()

	var/new_group_id = src.insert_character_connection(
			bond_type, 
			MEMBER_TYPE_THRALL,
			thrall_description,
			null)
	mind.character_connections = get_character_connections()
	
	domitor.insert_character_connection(
		bond_type, 
		MEMBER_TYPE_DOMITOR,
		domitor_description,
		new_group_id)
	domitor.mind.character_connections = domitor.get_character_connections()


/mob/living/proc/create_artificial_blood_bond(mob/living/domitor, bond_type, thrall_description, datum/character_connection/existing_connection)
	var/datum/character_connection/fake_connection = new (null, null, bond_type, MEMBER_TYPE_THRALL, ckey, src.true_real_name, "[thrall_description] (Temporary)", GLOB.round_id)
	LAZYADD(mind.fake_character_connections, fake_connection)
