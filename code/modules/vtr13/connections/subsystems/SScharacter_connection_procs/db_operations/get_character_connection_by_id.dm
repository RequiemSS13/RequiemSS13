//get info on a single character connection
/datum/controller/subsystem/character_connection/proc/get_character_connection_by_id(id)
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
