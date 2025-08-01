/datum/character_connection_type/endorsement
	name = CONNECTION_ENDORSEMENT
	
	var/required_faction
	var/desired_position
	
	var/endorser_must_be_faction_head = FALSE
	var/exact_faction_head_endorser
	
	var/minimum_candidate_rank = VAMP_RANK_ANCILLAE
	var/minimum_endorser_rank = VAMP_RANK_NEONATE
	var/required_count_for_role = FACTION_HEAD_ENDORSEMENT_MIN

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

	//check if there is an exact head role. If so, query db and compare.
	if(exact_faction_head_endorser)
		var/list/endorser_faction_head_roles = SScharacter_connection.get_eligible_faction_head_roles(endorser.ckey, endorser.real_name)
		if(!endorser_faction_head_roles || !length(endorser_faction_head_roles) || !endorser_faction_head_roles.Find(exact_faction_head_endorser))
			return FALSE
		qdel(endorser_faction_head_roles)
	else if(endorser_must_be_faction_head && !SScharacter_connection.check_is_eligible_for_faction_head(endorser.ckey, endorser.real_name))
		to_chat(endorser, span_notice("Your character cannot give this endorsement without being an eligible faction head for the Lancea et Sanctum, Ordo Dracul, Circle of the Crone, or the Carthian Movement."))
		to_chat(candidate, span_notice("[endorser] cannot endorse you."))
		return FALSE


	//check the database for validity
	if(!SScharacter_connection.check_can_endorse(endorser, candidate, name))
		return FALSE


	return attempt_connection_add(arglist(args))


/datum/character_connection_type/endorsement/attempt_connection_add(mob/living/candidate, mob/living/carbon/human/endorser)
	var/descriptor_blurb = ""
	if(exact_faction_head_endorser)
		descriptor_blurb = ", as the [exact_faction_head_endorser],"
	else if(endorser_must_be_faction_head)
		descriptor_blurb = ", as a faction head,"

	var/candidate_phrase = "[endorser.real_name][descriptor_blurb] endorses me for the position of [desired_position]."
	var/endorser_phrase = "I endorse [candidate.real_name][descriptor_blurb] for the position of [desired_position]."

	var/group_id = SScharacter_connection.insert_character_connection(candidate, src.name, MEMBER_TYPE_CANDIDATE, candidate_phrase)

	if(group_id)
		group_id = SScharacter_connection.insert_character_connection(endorser, src.name, MEMBER_TYPE_ENDORSER, endorser_phrase, group_id)

	if(!group_id)
		return FALSE

	to_chat(candidate, span_notice("[endorser] endorses you for the position of [desired_position]."))
	to_chat(endorser, span_notice("You endorse [candidate.real_name] for the position of [desired_position]."))

	return TRUE