/**
 * Request endorsement for a position.
 */
/datum/controller/subsystem/character_connection/verb/request_endorsement()
	set name = "Request Endorsement"
	set category = "Connections"
	
	if(!istype(src, /mob/living/carbon/human))
		CRASH("Request endorsement called from a non living mob.")

	
	var/mob/living/carbon/human/human_src = src

	if(human_src.has_status_effect(STATUS_EFFECT_REQUEST_CONNECTION))
		return

	if(!human_src.vtr_faction || !SScharacter_connection.endorsement_connection_list[human_src.vtr_faction.name])
		return

	var/list/connection_selection = list()
	for(var/key in SScharacter_connection.endorsement_connection_list[human_src.vtr_faction.name])
		var/datum/character_connection_type/endorsement/endorsement_type = SScharacter_connection.endorsement_connection_list[human_src.vtr_faction.name][key]
		if(endorsement_type.minimum_candidate_rank > human_src.vamp_rank)
			continue
		connection_selection += key

	if(human_src.vamp_rank >= VAMP_RANK_ANCILLAE && human_src?.vtr_faction?.name == "Invictus")
		connection_selection += CONNECTION_ENDORSEMENT_FACTION_LEADER_SENESCHAL
	
	if(!length(connection_selection))
		return
	//if there are multiple, build a menu about it
	else if(length(connection_selection) > 1)
		var/choice = tgui_input_list(human_src, "Select an endorsement to request:", "Endorsement Selection", connection_selection)
		if(!choice)
			return
		human_src.apply_status_effect(STATUS_EFFECT_REQUEST_CONNECTION, choice, FALSE)
	//if there is only one, then you already know what you're doin'
	else
		human_src.apply_status_effect(STATUS_EFFECT_REQUEST_CONNECTION, connection_selection[1], FALSE)