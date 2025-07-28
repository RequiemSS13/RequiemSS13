/datum/controller/subsystem/character_connection/proc/get_existing_daeva_addiction(mob/living/victim, mob/living/daeva)
	if(!daeva || !victim || !daeva.ckey || !daeva.real_name || !victim.ckey || !victim.real_name)
		return FALSE
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id, group_id, group_type, member_type, \
			player_ckey, character_name, connection_desc, \
			round_id_established, date_established, date_ended, \
			hidden \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey_daeva AND \
			character_name = :char_name_daeva AND \
			date_ended IS NULL AND \
			member_type = :member_type_daeva AND \
			group_id IN ( \
				SELECT group_id \
				FROM [format_table_name("character_connection")] \
				WHERE \
					player_ckey = :ckey_victim AND \
					character_name = :char_name_victim AND \
					member_type = :member_type_victim AND \
					date_ended IS NULL ) \
		LIMIT 1",
		list(
			"ckey_daeva" = daeva.ckey,
			"char_name_daeva" = daeva.real_name,
			"member_type_daeva" = MEMBER_TYPE_DAEVA_VAMPIRE,
			"ckey_victim" = victim.ckey,
			"char_name_victim" = victim.real_name,
			"member_type_victim" = MEMBER_TYPE_DAEVA_VICTIM,
		)
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
			query.item[11])
	qdel(query)
	return connection
