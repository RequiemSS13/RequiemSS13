/datum/character_connection_type/blood_bond/proc/create_blood_bond_to(mob/living/thrall, mob/living/domitor, artificial = FALSE)
	if(!can_be_blood_bonded_by(thrall, domitor))
		return 0

	var/bond_type = CONNECTION_BLOOD_BOND_1
	var/thrall_description = "I am bound by a first-stage blood bond to [domitor.real_name]."
	var/domitor_description = "I have put a first-stage blood bond upon [thrall.real_name]."
	var/resulting_bond = 1

	var/datum/character_connection/existing_connection = SScharacter_connection.get_existing_mutual_blood_bond(thrall, domitor)
	if(existing_connection)
		switch(existing_connection.group_type)
			if(CONNECTION_BLOOD_BOND_1)
				bond_type = CONNECTION_BLOOD_BOND_2
				thrall_description = "I am enraptured by a second-stage blood bond to [domitor.real_name]."
				domitor_description = "I have caught [thrall.real_name] in a second-stage blood bond."
				resulting_bond = 2
			if(CONNECTION_BLOOD_BOND_2)
				bond_type = CONNECTION_BLOOD_BOND_3
				thrall_description = "I am a Thrall, transfixed by a third-stage blood bond to [domitor.real_name], my Regent."
				domitor_description = "I have trapped [thrall.real_name] in a third-stage blood bond. I am their Regent and they are my Thrall."
				resulting_bond = 3
			if(CONNECTION_BLOOD_BOND_3)
				return 3 //A blood bond can not go higher than stage 3

	message_admins("[ADMIN_LOOKUPFLW(domitor)] has bloodbonded [ADMIN_LOOKUPFLW(thrall)] with [bond_type].")
	log_game("[key_name(domitor)] has bloodbonded [key_name(thrall)] with [bond_type].")

	var/purge_other_blood_bonds = FALSE
	switch(bond_type)
		if(CONNECTION_BLOOD_BOND_1)
			to_chat(thrall, "<span class='userlove'>You feel a deep sense of familiarity with [domitor].</span>")

		if(CONNECTION_BLOOD_BOND_2)
			to_chat(thrall, "<span class='userlove'>You begin to long for [domitor]'s presence.</span>")

		if(CONNECTION_BLOOD_BOND_3)
			purge_other_blood_bonds = TRUE
			to_chat(thrall, "<span class='userlove'>You lose yourself in your devotion to [domitor]!</span>")

	if(purge_other_blood_bonds && !artificial)
		artificial = tgui_alert(thrall, "Do you wish to permanently enter into a third stage blood bond? This will remove all lower level blood bonds.", "Confirmation", list("Yes", "No")) != "Yes"

	if(!artificial && tgui_alert(thrall, "You have been blood bonded by [domitor]! Would you like to keep the blood bond permanently?", "Confirmation", list("Yes", "No")) == "Yes")
		handle_insert_blood_bond_db(thrall, domitor, bond_type, thrall_description, domitor_description, existing_connection, purge_other_blood_bonds)
	else if (artificial)
		SScharacter_connection.create_artificial_connection(thrall, domitor, bond_type, MEMBER_TYPE_THRALL, MEMBER_TYPE_DOMITOR, thrall_description, domitor_description, existing_connection)

	return resulting_bond







