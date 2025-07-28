/datum/controller/subsystem/character_connection/proc/check_can_endorse(mob/living/endorser, mob/living/candidate, connection_type, endorser_must_be_faction_head)
	if(!endorser || !candidate)
		return FALSE

	if(endorser.ckey == candidate.ckey)
		return FALSE

	//A given ckey cannot endorse the same ckey/player combination twice.
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT \
			id \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			date_ended IS NULL AND \
			member_type = :mem_type AND \
			group_id IN ( \
				SELECT group_id \
				FROM [format_table_name("character_connection")] \
				WHERE \
					player_ckey = :candidate_ckey AND \
					character_name = :candidate_name AND \
					date_ended IS NULL ) \
		LIMIT 1",
		list(
			"ckey" = endorser.ckey,
			"mem_type" = MEMBER_TYPE_ENDORSER,
			"candidate_ckey" = candidate.ckey,
			"candidate_name" = candidate.real_name
		)
	)

	if(!query.Execute(async = TRUE) || query.NextRow())
		to_chat(endorser, span_notice("Your account is already endorsing this character."))
		to_chat(candidate, span_notice("[endorser] cannot endorse you."))
		qdel(query)
		return FALSE
	qdel(query)

	//a given character cannot endorse more than once
	var/datum/db_query/query_2 = SSdbcore.NewQuery(
		"SELECT \
			id \
		FROM [format_table_name("character_connection")] \
		WHERE \
			player_ckey = :ckey AND \
			character_name = :char_name AND \
			member_type = :mem_type AND \
			group_type = :grp_type AND \
			date_ended IS NULL \
		LIMIT 1",
		list(
			"ckey" = endorser.ckey,
			"char_name" = endorser.real_name,
			"mem_type" = MEMBER_TYPE_ENDORSER,
			"grp_type" = connection_type
		)
	)

	if(!query_2.Execute(async = TRUE) || query_2.NextRow())
		to_chat(endorser, span_notice("Your character cannot endorse two different characters for the same position."))
		to_chat(candidate, span_notice("[endorser] cannot endorse you."))
		qdel(query_2)
		return FALSE
	qdel(query_2)



	if(endorser_must_be_faction_head)
		if(!SScharacter_connection.check_is_eligible_for_faction_head(endorser.ckey, endorser.real_name))
			to_chat(endorser, span_notice("Your character cannot give this endorsement without being an eligible faction head for the Lancea et Sanctum, Ordo Dracul, Circle of the Crone, or the Carthian Movement."))
			to_chat(candidate, span_notice("[endorser] cannot endorse you."))
			return FALSE
	return TRUE
