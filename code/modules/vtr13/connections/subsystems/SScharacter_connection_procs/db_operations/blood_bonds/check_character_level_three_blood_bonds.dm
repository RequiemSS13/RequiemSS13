/datum/controller/subsystem/character_connection/proc/check_level_three_blood_bonds(mob/living/target)
	if(!target)
		return FALSE
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			date_ended IS NULL AND \
			group_type = :bb3 AND \
			member_type = :member_type \
		LIMIT 1", 
		list(
			"ckey" = target.ckey,
			"char_name" = target.true_real_name,
			"bb3" = CONNECTION_BLOOD_BOND_3,
			"member_type" = MEMBER_TYPE_THRALL
		)
	)
	if(!query.Execute(async = TRUE) || query.NextRow())
		qdel(query)
		return FALSE
	qdel(query)
	return TRUE