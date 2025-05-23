/datum/controller/subsystem/character_connection/proc/update_retire_all_character_connections(target, ckey, character_name)

	
	if(!ckey || !character_name)
		return

	var/datum/db_query/query_update = SSdbcore.NewQuery(
		"UPDATE [format_table_name("character_connection")] \
			SET date_ended = Now() \
			WHERE \
				date_ended IS NULL AND \
				group_id IN ( \
					SELECT group_id \
					FROM [format_table_name("character_connection")] \
					WHERE \
						player_ckey = :ckey AND \
						character_name = :c_name \
				) ",
		list(
			"ckey" = ckey,
			"c_name" = character_name
		)
	)
	query_update.Execute()
	qdel(query_update)
	
	to_chat(target, span_notice("All connections have been retired."))


