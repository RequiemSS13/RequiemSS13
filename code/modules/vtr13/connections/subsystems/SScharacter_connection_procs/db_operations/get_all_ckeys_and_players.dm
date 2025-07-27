//Get all active connection datums for a single character
/datum/controller/subsystem/character_connection/proc/get_all_ckeys_from_players()
	. = list()
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT DISTINCT \
			player_ckey, character_name \
		FROM [format_table_name("character_connection")]"
	)
	if(!query.Execute(async = TRUE))
		qdel(query)
		return null
	
	while(query.NextRow())
		if(!.[query.item[1]])
			.[query.item[1]] = list(query.item[2])
		else
			.[query.item[1]] += query.item[2]
	qdel(query)

