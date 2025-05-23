/datum/controller/subsystem/character_connection/proc/retire_all_stale_endorsements(user, ckey, character_name)

	//report all stale connections we are retiring
	var/datum/db_query/query_get = SSdbcore.NewQuery(
		"SELECT \
			id, group_id, group_type, member_type, \
			player_ckey, character_name, connection_desc, \
			round_id_established, date_established, date_ended, \
			hidden \
		FROM [format_table_name("character_connection")] \
		WHERE \
			member_type IN ( :mem_type_1 , :mem_type_2 ) AND \
			date_ended IS NULL AND \
			player_ckey != :ckey AND \
			( \
				( \
					date_established < DATE_SUB(NOW(), INTERVAL :stale_offset MONTH) AND \
					group_id IN ( \
						SELECT group_id \
						FROM [format_table_name("character_connection")] \
						WHERE \
							player_ckey = :ckey AND \
							character_name = :c_name \
					) \
				) OR \
				( \
					group_id IN ( \
						SELECT group_id \
						FROM [format_table_name("character_connection")] \
						WHERE \
							player_ckey = :ckey AND \
							character_name = :c_name AND \
							date_established < DATE_SUB(NOW(), INTERVAL :stale_offset MONTH)\
					) \
				) \
			)",
		list(
			"mem_type_1" = MEMBER_TYPE_CANDIDATE,
			"mem_type_2" = MEMBER_TYPE_ENDORSER,
			"stale_offset" = ENDORSEMENT_STALE_OFFSET_MONTHS,
			"ckey" = ckey,
			"c_name" = character_name
		)
	)

	if(!query_get.Execute(async = TRUE))
		qdel(query_get)
		return null
	
	while(query_get.NextRow())
		var/datum/character_connection/connection = new(
			query_get.item[1],
			query_get.item[2],
			query_get.item[3],
			query_get.item[4],
			query_get.item[5],
			query_get.item[6],
			query_get.item[7],
			query_get.item[8],
			query_get.item[9],
			query_get.item[10],
			query_get.item[11]
		)
		if (connection.member_type == MEMBER_TYPE_CANDIDATE)
			to_chat(user, span_warning("[character_name] endorsement for [connection.character_name] has expired from inactivity. (ID: [connection.id], GROUP_ID: [connection.group_id])"))
		else if (connection.member_type == MEMBER_TYPE_ENDORSER)
			to_chat(user, span_warning("[connection.character_name]'s endorsement for [character_name] has expired from inactivity. (ID: [connection.id], GROUP_ID: [connection.group_id])"))
	qdel(query_get)

	//retire all stale connections
	var/datum/db_query/query_update = SSdbcore.NewQuery(
		"UPDATE [format_table_name("character_connection")] \
		SET date_ended = Now() \
		WHERE \
			group_id IN ( \
				SELECT group_id \
				FROM [format_table_name("character_connection")] \
				WHERE \
					member_type IN ( :mem_type_1 , :mem_type_2 ) AND \
					date_ended IS NULL AND \
					( \
						( \
							date_established < DATE_SUB(NOW(), INTERVAL :stale_offset MONTH) AND \
							group_id IN ( \
								SELECT group_id \
								FROM [format_table_name("character_connection")] \
								WHERE \
									player_ckey = :ckey AND \
									character_name = :c_name \
							) \
						) OR \
						( \
							group_id IN ( \
								SELECT group_id \
								FROM [format_table_name("character_connection")] \
								WHERE \
									player_ckey = :ckey AND \
									character_name = :c_name AND \
									date_established < DATE_SUB(NOW(), INTERVAL :stale_offset MONTH)\
							) \
						) \
					) \
			)",
		list(
			"mem_type_1" = MEMBER_TYPE_CANDIDATE,
			"mem_type_2" = MEMBER_TYPE_ENDORSER,
			"stale_offset" = ENDORSEMENT_STALE_OFFSET_MONTHS,
			"ckey" = ckey,
			"c_name" = character_name
		)
	)
	query_update.Execute()
	qdel(query_update)

