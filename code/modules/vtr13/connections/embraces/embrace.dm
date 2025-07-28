/datum/character_connection_type/embrace
	name = CONNECTION_EMBRACE

/datum/character_connection_type/embrace/attempt_connection_add(mob/living/childe, mob/living/sire)
	if(!childe || !sire)
		return FALSE
	var/sire_description = "I am [childe.real_name]'s sire."
	var/childe_description = "I am [sire.real_name]'s childe."
	var/new_group_id = SScharacter_connection.insert_character_connection(childe,
			CONNECTION_EMBRACE,
			MEMBER_TYPE_CHILDE,
			childe_description,
			null)
	SScharacter_connection.insert_character_connection(
		sire,
		CONNECTION_EMBRACE,
		MEMBER_TYPE_SIRE,
		sire_description,
		new_group_id)
	return TRUE