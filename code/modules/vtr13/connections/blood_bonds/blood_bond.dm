/datum/character_connection_type/blood_bond
	name = CONNECTION_BLOOD_BOND

/datum/character_connection_type/blood_bond/attempt_connection_add(mob/living/party_a, mob/living/party_b, artificial = FALSE)
	return create_blood_bond_to(party_a, party_b, artificial)