/datum/controller/subsystem/character_connection/proc/update_date_on_endorsements(ckey, character_name)
	//Update all non-expired connections
	var/datum/db_query/query_update = SSdbcore.NewQuery(
		"UPDATE [format_table_name("character_connection")] \
		SET date_established = Now() \
		WHERE \
			group_id IN ( \
				SELECT group_id \
				FROM [format_table_name("character_connection")] \
				WHERE \
					member_type = :mem_type AND \
					date_ended IS NULL AND \
					player_ckey = :ckey AND \
					character_name = :c_name AND \
					date_ended IS NULL\
			)",
		list(
			"mem_type" = MEMBER_TYPE_ENDORSER,
			"stale_offset" = ENDORSEMENT_STALE_OFFSET_MONTHS,
			"ckey" = ckey,
			"c_name" = character_name
		)
	)
	query_update.Execute()
	qdel(query_update)