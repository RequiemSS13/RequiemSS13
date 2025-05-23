//Get all active connection datums for a single character
/datum/controller/subsystem/character_connection/proc/get_character_connections(ckey, character_name)
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
		list("ckey" = ckey, "char_name" = character_name)
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
