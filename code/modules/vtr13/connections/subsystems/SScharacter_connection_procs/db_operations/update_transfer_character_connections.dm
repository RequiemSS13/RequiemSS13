/datum/controller/subsystem/character_connection/proc/update_transfer_character_connections(ckey, character_name, new_character_name)
	if(!ckey || !character_name || !new_character_name)
		return
	var/datum/db_query/query = SSdbcore.NewQuery(
		"UPDATE [format_table_name("character_connection")] SET character_name = :new_cname WHERE player_ckey = :p_ckey AND character_name = :cname",
		list("p_ckey" = ckey,
			"cname" = character_name,
			"new_cname" = new_character_name)
	)
	query.Execute()
	qdel(query)