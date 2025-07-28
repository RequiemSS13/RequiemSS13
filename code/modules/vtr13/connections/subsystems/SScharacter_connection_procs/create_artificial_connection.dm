//creates a fake character connection, only visible for the current round.
/datum/controller/subsystem/character_connection/proc/create_artificial_connection(mob/living/party_a, mob/living/party_b, bond_type, member_type_a, member_type_b, bond_description_a, bond_description_b, datum/character_connection/replacing_connection)
	if(!party_a?.mind || !party_b?.mind)
		return

	var/datum/character_connection/fake_connection_a = new (null, null, bond_type, member_type_a, party_a.ckey, party_a.real_name, "[bond_description_a] (Temporary)", GLOB.round_id)
	LAZYADD(party_a.mind.fake_character_connections, fake_connection_a)

	var/datum/character_connection/fake_connection_b = new (null, null, bond_type, member_type_b, party_b.ckey, party_b.real_name, "[bond_description_b] (Temporary)", GLOB.round_id)
	LAZYADD(party_b.mind.fake_character_connections, fake_connection_b)

	if(replacing_connection)
		replacing_connection.hidden = TRUE