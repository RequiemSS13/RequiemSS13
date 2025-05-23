//Get all the group-linked character connection for a single character
/datum/controller/subsystem/character_connection/proc/get_connection_by_group_id(mob/living/target, group_id)
	if(!group_id)
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
			group_id = :grp_id \
			date_ended IS NULL \
		LIMIT 1", 
		list("ckey" = target.ckey, "char_name" = target.true_real_name, "grp_id" = group_id)
	)

	if(!query.Execute(async = TRUE))
		qdel(query)
		return null
	var/datum/character_connection/connection = null
	if(query.NextRow())
		connection = new /datum/character_connection(
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
