/datum/character_connection_type/blood_bond/proc/handle_insert_blood_bond_db(mob/living/thrall, mob/living/domitor, bond_type, thrall_description, domitor_description, datum/character_connection/existing_connection, purge_other_blood_bonds)
	//Retire existing blood bond connection
	if(existing_connection)
		SScharacter_connection.update_retire_character_connection_by_group_id(existing_connection.group_id)

	if(purge_other_blood_bonds)
		SScharacter_connection.update_retire_all_blood_bonds(thrall)

	var/new_group_id = SScharacter_connection.insert_character_connection(
			thrall,
			bond_type, 
			MEMBER_TYPE_THRALL,
			thrall_description,
			null)
	
	SScharacter_connection.insert_character_connection(
		domitor,
		bond_type, 
		MEMBER_TYPE_DOMITOR,
		domitor_description,
		new_group_id)