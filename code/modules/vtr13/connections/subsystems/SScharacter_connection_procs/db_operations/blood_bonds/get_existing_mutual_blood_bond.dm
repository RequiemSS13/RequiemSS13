/datum/controller/subsystem/character_connection/proc/get_existing_mutual_blood_bond(mob/living/thrall, mob/living/domitor)
	if(!domitor || !thrall)
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
			"ckey" = thrall.ckey,
			"char_name" = thrall.real_name,
			"bb3" = CONNECTION_BLOOD_BOND_3,
			"bb2" = CONNECTION_BLOOD_BOND_2,
			"bb1" = CONNECTION_BLOOD_BOND_1,
			"member_type" = MEMBER_TYPE_THRALL,
			"domitor_ckey" = domitor.ckey,
			"domitor_name" = domitor.real_name
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
