/datum/preferences/proc/handle_upgrade(var/number, var/cost = 1)
	if ((character_dots < cost) || (number >= ATTRIBUTE_BASE_LIMIT))
		return FALSE
	return TRUE