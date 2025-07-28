/datum/character_connection_type/boon
	name = CONNECTION_BOON
	alert_type = /atom/movable/screen/alert/connection/trivial_boon

/datum/character_connection_type/boon/add_connection(mob/living/recipient, mob/living/granter)

	if(!iskindred(granter))
		to_chat(recipient, span_notice("[granter] cannot give you a boon if they aren't a vampire."))
		to_chat(granter, span_notice("You are not a vampire; you cannot grant boons!"))
		return FALSE

	if(!iskindred(recipient))
		to_chat(recipient, span_notice("You are not a vampire; there is no expectation for [granter] to uphold any boon they may claim to grant."))
		to_chat(granter, span_notice("[recipient] is not a vampire; giving [recipient.p_them()] a boon is a humiliation for you and worthless to them."))
		return FALSE

	return attempt_connection_add(arglist(args))


/datum/character_connection_type/boon/attempt_connection_add(mob/living/recipient, mob/living/granter)
	var/granter_phrase = "I owe [recipient.real_name] a [src.name]."
	var/recipient_phrase = "[granter.real_name] owes you a [src.name]."

	var/group_id = SScharacter_connection.insert_character_connection(granter, src.name, MEMBER_TYPE_BOON_GRANTER, granter_phrase)

	if(group_id)
		group_id = SScharacter_connection.insert_character_connection(recipient, src.name, MEMBER_TYPE_BOON_RECIPIENT, recipient_phrase, group_id)

	if(!group_id)
		return FALSE

	to_chat(granter, span_notice("You grant [recipient] a [name]."))
	to_chat(recipient, span_notice("You recieve a [src.name] from [granter]."))
	return TRUE