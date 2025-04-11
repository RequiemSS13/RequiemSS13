
/mob/living/proc/check_character_level_three_blood_bonds()
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			date_ended IS NULL AND \
			group_type = :bb3 AND \
			member_type = :member_type \
		LIMIT 1", 
		list(
			"ckey" = ckey,
			"char_name" = true_real_name,
			"bb3" = CONNECTION_BLOOD_BOND_3,
			"member_type" = MEMBER_TYPE_THRALL
		)
	)
	if(!query.Execute(async = TRUE))
		qdel(query)
		return FALSE
	if(query.NextRow())
		return FALSE
	
	qdel(query)
	return TRUE


/mob/living/proc/check_mutual_blood_bonds_made_this_round(mob/living/carbon/human/domitor)
	if(!domitor)
		return FALSE
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			date_ended IS NULL AND \
			group_type IN ( :bb2 , :bb1 ) AND \
			round_id_established = :round_id AND \
			member_type = :member_type AND \
			group_id IN ( \
				SELECT group_id \
				FROM [format_table_name("character_connection")] \
				WHERE \
					player_ckey = :domitor_ckey AND \
					character_name = :domitor_name AND \
					date_ended IS NULL ) \
		LIMIT 1",
		list(
			"ckey" = ckey,
			"char_name" = true_real_name,
			"bb2" = CONNECTION_BLOOD_BOND_2,
			"bb1" = CONNECTION_BLOOD_BOND_1,
			"member_type" = MEMBER_TYPE_THRALL,
			"domitor_ckey" = domitor.ckey,
			"domitor_name" = domitor.true_real_name,
			"round_id" = GLOB.round_id
		)
	)
	if(!query.Execute(async = TRUE))
		qdel(query)
		return FALSE
	if(query.NextRow())
		return TRUE
	qdel(query)
	return FALSE


/mob/living/proc/get_existing_mutual_blood_bond(mob/living/carbon/human/domitor)
	if(!domitor)
		return null
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id, group_id, group_type, member_type, \
			player_ckey, character_name, connection_desc, \
			round_id_established, date_established, date_ended, \
			hidden \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			date_ended IS NULL AND \
			group_type IN ( :bb3 , :bb2 , :bb1 ) AND \
			member_type = :member_type AND \
			group_id IN ( \
				SELECT group_id \
				FROM [format_table_name("character_connection")] \
				WHERE \
					player_ckey = :domitor_ckey AND \
					character_name = :domitor_name AND \
					date_ended IS NULL ) \
		LIMIT 1",
		list(
			"ckey" = ckey,
			"char_name" = true_real_name,
			"bb3" = CONNECTION_BLOOD_BOND_3,
			"bb2" = CONNECTION_BLOOD_BOND_2,
			"bb1" = CONNECTION_BLOOD_BOND_1,
			"member_type" = MEMBER_TYPE_THRALL,
			"domitor_ckey" = domitor.ckey,
			"domitor_name" = domitor.true_real_name
		)
	)

	if(!query.Execute(async = TRUE))
		qdel(query)
		return null

	var/datum/character_connection/connection = null
	if(query.NextRow())
		connection = new(
			query.item[1],
			query.item[2],
			query.item[3],
			query.item[4],
			query.item[5],
			query.item[6],
			query.item[7],
			query.item[8],
			query.item[9],
			query.item[10],
			query.item[11])
	qdel(query)
	return connection

/mob/living/proc/get_next_character_connection_group_id()
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT MAX(group_id) FROM [format_table_name("character_connection")]")
	if(!query.Execute(async = TRUE))
		qdel(query)
		return null
	var/group_id = 1
	if(query.NextRow())
		group_id = query.item[1] + 1
	qdel(query)
	return group_id


//Get all active connection datums for a single character
/mob/living/proc/get_character_connections()
	var/list/connection_list = list()
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id, group_id, group_type, member_type, \
			player_ckey, character_name, connection_desc, \
			round_id_established, date_established, date_ended, \
			hidden \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			date_ended IS NULL \
		ORDER BY group_type, member_type DESC", 
		list("ckey" = ckey, "char_name" = true_real_name)
	)

	if(!query.Execute(async = TRUE))
		qdel(query)
		return null
	while(query.NextRow())
		var/datum/character_connection/connection = new(
			query.item[1],
			query.item[2],
			query.item[3],
			query.item[4],
			query.item[5],
			query.item[6],
			query.item[7],
			query.item[8],
			query.item[9],
			query.item[10],
			query.item[11]
		)
		connection_list += connection
	qdel(query)
	return connection_list


/mob/living/proc/get_character_connection_by_id(id)
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id, group_id, group_type, member_type, \
			player_ckey, character_name, connection_desc, \
			round_id_established, date_established, date_ended, \
			hidden \
		FROM [format_table_name("character_connection")] \
		WHERE \
			id = :connection_id\
		ORDER BY group_type, member_type DESC", 
		list("connection_id" = id)
	)

	if(!query.Execute(async = TRUE))
		qdel(query)
		return null
	
	var/datum/character_connection/connection = null
	if(query.NextRow())
		connection = new(
			query.item[1],
			query.item[2],
			query.item[3],
			query.item[4],
			query.item[5],
			query.item[6],
			query.item[7],
			query.item[8],
			query.item[9],
			query.item[10],
			query.item[11]
		)
	qdel(query)
	return connection

//Get all active connection datums for a single character
/mob/living/proc/get_connection_by_group_id(var/group_id)
	if(!group_id)
		return null

	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id, group_id, group_type, member_type, \
			player_ckey, character_name, connection_desc, \
			round_id_established, date_established, date_ended, \
			hidden \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			group_id = :grp_id \
			date_ended IS NULL \
		LIMIT 1", 
		list("ckey" = ckey, "char_name" = true_real_name, "grp_id" = group_id)
	)

	if(!query.Execute(async = TRUE))
		qdel(query)
		return null
	var/datum/character_connection/connection = null
	if(query.NextRow())
		connection = new /datum/character_connection(
			query.item[1],
			query.item[2],
			query.item[3],
			query.item[4],
			query.item[5],
			query.item[6],
			query.item[7],
			query.item[8],
			query.item[9],
			query.item[10],
			query.item[11]
		)

	qdel(query)
	
	return connection