
/datum/controller/subsystem/character_connection/proc/check_mutual_blood_bonds_made_this_round(mob/living/thrall, mob/living/domitor)
	if(!domitor || !thrall)
		return FALSE
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			date_ended IS NULL AND \
			group_type IN ( :bb2 , :bb1 ) AND \
			round_id_established = :round_id AND \
			member_type = :member_type AND \
			group_id IN ( \
				SELECT group_id \
				FROM [format_table_name("character_connection")] \
				WHERE \
					player_ckey = :domitor_ckey AND \
					character_name = :domitor_name AND \
					date_ended IS NULL ) \
		LIMIT 1",
		list(
			"ckey" = thrall.ckey,
			"char_name" = thrall.real_name,
			"bb2" = CONNECTION_BLOOD_BOND_2,
			"bb1" = CONNECTION_BLOOD_BOND_1,
			"member_type" = MEMBER_TYPE_THRALL,
			"domitor_ckey" = domitor.ckey,
			"domitor_name" = domitor.real_name,
			"round_id" = GLOB.round_id
		)
	)
	if(!query.Execute(async = TRUE))
		qdel(query)
		return FALSE
	if(query.NextRow())
		qdel(query)
		return TRUE
	qdel(query)
	return FALSE