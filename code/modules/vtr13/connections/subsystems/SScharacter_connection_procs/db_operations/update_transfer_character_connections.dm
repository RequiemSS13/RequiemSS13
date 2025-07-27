/datum/controller/subsystem/character_connection/proc/update_transfer_character_connections(ckey, character_name, new_character_name)
	if(!ckey || !character_name || !new_character_name)
		return
	var/datum/db_query/query = SSdbcore.NewQuery(
		"UPDATE [format_table_name("character_connection")] SET character_name = :new_character_name WHERE ckey = :ckey AND character_name = :character_name",
		list("ckey" = ckey,
			"character_name" = character_name,
			"new_character_name" = new_character_name)
	)
	query.Execute()
	qdel(query)