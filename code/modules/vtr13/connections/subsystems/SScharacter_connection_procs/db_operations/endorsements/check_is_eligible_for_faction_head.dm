
//check if the user is eligable to be head of a non invictus faction
//endorsements are only good for the last ENDORSEMENT_STALE_OFFSET_MONTHS months
/datum/controller/subsystem/character_connection/proc/check_is_eligible_for_faction_head(ckey, character_name)
	if(!ckey || !character_name)
		return FALSE

	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			group_type, COUNT(*)\
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			member_type = :mem_type AND \
			group_type IN ( :grp_type_1 , :grp_type_2 , :grp_type_3, :grp_type_4 ) AND \
			date_ended IS NULL AND \
			date_established >= DATE_SUB(NOW(), INTERVAL :stale_offset MONTH) \
		GROUP BY \
			group_type",
		list(
			"ckey" = ckey,
			"char_name" = character_name,
			"mem_type" = MEMBER_TYPE_CANDIDATE,
			"grp_type_1" = CONNECTION_ENDORSEMENT_HIEROPHANT,
			"grp_type_2" = CONNECTION_ENDORSEMENT_VOIVODE,
			"grp_type_3" = CONNECTION_ENDORSEMENT_BISHOP,
			"grp_type_4" = CONNECTION_ENDORSEMENT_REPRESENTATIVE,
			"stale_offset" = ENDORSEMENT_STALE_OFFSET_MONTHS
		)
	)

	if(!query.Execute(async = TRUE))
		qdel(query)
		return FALSE

	var/is_eligable = FALSE
	while(query.NextRow())
		var/endorsement_count = query.item[2]
		if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
			is_eligable = TRUE
			break
	qdel(query)
	return is_eligable