/datum/character_connection_type
	var/name = "Default character connection"
	var/alert_type

/datum/character_connection_type/proc/add_connection(mob/party_a, mob/party_b, ...)
	if(!party_a || !party_b)
		return null
	return attempt_connection_add(arglist(args))

/datum/character_connection_type/proc/attempt_connection_add(...)
	return null

/datum/character_connection_type/proc/get_custom_alert_name(mob/party_a)
	return null

/datum/character_connection_type/proc/get_custom_alert_description(mob/party_a)
	return null