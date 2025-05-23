/datum/controller/subsystem/character_connection/proc/retire_all_endorsements(user, ckey, character_name)

	if(!ckey || !character_name)
		return

	var/datum/db_query/query_update = SSdbcore.NewQuery(
		"UPDATE [format_table_name("character_connection")] \
			SET date_ended = Now() \
			WHERE \
				date_ended IS NULL AND\
				group_id IN ( \
					SELECT group_id \
					FROM [format_table_name("character_connection")] \
					WHERE \
						member_type IN ( :mem_type_1 , :mem_type_2 ) AND \
						player_ckey = :ckey AND \
						character_name = :c_name \
				) ",
		list(
			"mem_type_1" = MEMBER_TYPE_CANDIDATE,
			"mem_type_2" = MEMBER_TYPE_ENDORSER,
			"ckey" = ckey,
			"c_name" = character_name
		)
	)
	query_update.Execute()
	qdel(query_update)
	
	to_chat(user, span_notice("All active endorsements have been retired."))
