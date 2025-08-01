/datum/controller/subsystem/character_connection/proc/get_eligible_faction_head_roles(ckey, character_name)
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			group_type, COUNT(*)\
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			member_type = :mem_type AND \
			group_type IN ( :grp_type_1 , :grp_type_2 , :grp_type_3, :grp_type_4, :grp_type_5, :grp_type_6, :grp_type_7, :grp_type_8, :grp_type_9, :grp_type_10, :grp_type_11, :grp_type_12, :grp_type_13, :grp_type_14, :grp_type_15) AND \
			date_ended IS NULL AND \
			date_established >= DATE_SUB(NOW(), INTERVAL :stale_offset MONTH) \
		GROUP BY \
			group_type \
		ORDER BY group_type desc",
		list(
			"ckey" = ckey,
			"char_name" = character_name,
			"mem_type" = MEMBER_TYPE_CANDIDATE,
			"grp_type_1" = CONNECTION_ENDORSEMENT_HIEROPHANT,
			"grp_type_2" = CONNECTION_ENDORSEMENT_VOIVODE,
			"grp_type_3" = CONNECTION_ENDORSEMENT_BISHOP,
			"grp_type_4" = CONNECTION_ENDORSEMENT_REPRESENTATIVE,
			"grp_type_5" = CONNECTION_ENDORSEMENT_SHERIFF,
			"grp_type_6" = CONNECTION_ENDORSEMENT_KEEPER,
			"grp_type_7" = CONNECTION_ENDORSEMENT_SENESCHAL,
			"grp_type_8" = CONNECTION_ENDORSEMENT_FACTION_LEADER_SENESCHAL,
			"grp_type_9" = CONNECTION_ENDORSEMENT_JUDGE,
			"grp_type_10" = CONNECTION_ENDORSEMENT_HOST,
			"grp_type_11" = CONNECTION_ENDORSEMENT_DEPUTY,
			"grp_type_12" = CONNECTION_ENDORSEMENT_VICAR,
			"grp_type_13" = CONNECTION_ENDORSEMENT_HARUSPEX,
			"grp_type_14" = CONNECTION_ENDORSEMENT_CLAW,
			"grp_type_15" = CONNECTION_ENDORSEMENT_WHIP,
			"stale_offset" = ENDORSEMENT_STALE_OFFSET_MONTHS
		)
	)

	if(!query.Execute(async = TRUE))
		qdel(query)
		return list()

	var/list/eligiable_roles =  list()
	var/seneschal_faction_leader_endorsement = FALSE
	var/seneschal_popular_endorsement = FALSE
	while(query.NextRow())
		var/endorsement_type = query.item[1]
		var/endorsement_count = query.item[2]
		switch(endorsement_type)
			if(CONNECTION_ENDORSEMENT_FACTION_LEADER_SENESCHAL)
				if(endorsement_count >= SENESCHAL_SPECIAL_ENDORSEMENT_MIN)
					seneschal_faction_leader_endorsement = TRUE
			if(CONNECTION_ENDORSEMENT_SENESCHAL)
				if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
					seneschal_popular_endorsement = TRUE
			if(CONNECTION_ENDORSEMENT_KEEPER)
				if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Keeper of Elysium")
			if(CONNECTION_ENDORSEMENT_SHERIFF)
				if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Sheriff")
			if(CONNECTION_ENDORSEMENT_REPRESENTATIVE)
				if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Carthian Representative")
			if(CONNECTION_ENDORSEMENT_BISHOP)
				if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Bishop")
			if(CONNECTION_ENDORSEMENT_VOIVODE)
				if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Voivode")
			if(CONNECTION_ENDORSEMENT_HIEROPHANT)
				if(endorsement_count >= FACTION_HEAD_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Hierophant")
			if(CONNECTION_ENDORSEMENT_JUDGE)
				if(endorsement_count >= DEPUTY_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Judge")
			if(CONNECTION_ENDORSEMENT_HOST)
				if(endorsement_count >= DEPUTY_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Host")
			if(CONNECTION_ENDORSEMENT_DEPUTY)
				if(endorsement_count >= DEPUTY_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Deputy")
			if(CONNECTION_ENDORSEMENT_VICAR)
				if(endorsement_count >= DEPUTY_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Vicar")
			if(CONNECTION_ENDORSEMENT_HARUSPEX)
				if(endorsement_count >= DEPUTY_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Haruspex")
			if(CONNECTION_ENDORSEMENT_CLAW)
				if(endorsement_count >= DEPUTY_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Claw")
			if(CONNECTION_ENDORSEMENT_WHIP)
				if(endorsement_count >= DEPUTY_ENDORSEMENT_MIN)
					LAZYADD(eligiable_roles, "Whip")

	if(seneschal_faction_leader_endorsement && seneschal_popular_endorsement)
		LAZYADD(eligiable_roles, "Seneschal")

	qdel(query)
	return eligiable_roles
