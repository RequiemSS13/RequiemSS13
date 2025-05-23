/datum/character_connection_type/endorsement
	name = CONNECTION_ENDORSEMENT
	var/required_faction
	var/desired_position
	var/endorser_must_be_faction_head = FALSE
	var/minimum_candidate_rank = VAMP_RANK_ANCILLAE
	var/minimum_endorser_rank = VAMP_RANK_NEONATE
	alert_type = /atom/movable/screen/alert/connection/endorsement

/datum/character_connection_type/endorsement/add_connection(mob/living/carbon/human/candidate, mob/living/carbon/human/endorser)
	if(!candidate?.mind || !endorser?.mind)
		return FALSE
	
	//your char must have the prerequisite rank in vampire society
	if(minimum_endorser_rank && endorser.vamp_rank < minimum_endorser_rank)
		to_chat(endorser, span_notice("You must be at least a [GLOB.vampire_rank_names[minimum_endorser_rank]] to endorse [candidate] for [desired_position]."))
		to_chat(candidate, span_notice("[endorser] must be at least a [GLOB.vampire_rank_names[minimum_endorser_rank]] to endorse you for [desired_position]."))
		return FALSE
	
	if(minimum_candidate_rank && candidate.vamp_rank < minimum_candidate_rank)
		to_chat(candidate, span_notice("You must be at least a [GLOB.vampire_rank_names[minimum_candidate_rank]] to be endorsed for [desired_position]."))
		to_chat(endorser, span_notice("[candidate] must be at least a [GLOB.vampire_rank_names[minimum_candidate_rank]] before you can endorse them for [desired_position]."))
		return FALSE

	//your char must be in the same faction to endorse
	if(required_faction && endorser?.vtr_faction?.name != required_faction)
		to_chat(endorser, span_notice("You must be a part of [required_faction] to endorse [candidate] for [desired_position]."))
		to_chat(candidate, span_notice("[endorser] must be a part of [required_faction] to endorse you for [desired_position]."))
		return FALSE

	//check the database for validity
	if(!SScharacter_connection.check_can_endorse(endorser, candidate, name, endorser_must_be_faction_head))
		return FALSE

	return attempt_connection_add(arglist(args))


/datum/character_connection_type/endorsement/attempt_connection_add(mob/living/candidate, mob/living/carbon/human/endorser)

	var/candidate_phrase = "[endorser.true_real_name][endorser_must_be_faction_head?", as a faction head,":""] endorses me for the position of [desired_position]."
	var/endorser_phrase = "I endorse [candidate.true_real_name][endorser_must_be_faction_head?", as a faction head,":""] for the position of [desired_position]."

	var/group_id = SScharacter_connection.insert_character_connection(candidate, src.name, MEMBER_TYPE_CANDIDATE, candidate_phrase)

	if(group_id)
		group_id = SScharacter_connection.insert_character_connection(endorser, src.name, MEMBER_TYPE_ENDORSER, endorser_phrase, group_id)

	if(!group_id)
		return FALSE

	to_chat(candidate, span_notice("[endorser] endorses you for the position of [desired_position]."))
	to_chat(endorser, span_notice("You endorse [candidate.true_real_name] for the position of [desired_position]."))

	return TRUE