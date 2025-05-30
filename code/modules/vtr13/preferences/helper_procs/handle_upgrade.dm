/datum/preferences/proc/handle_upgrade(number, cost = 1)
	if ((character_dots < cost) || (number >= ATTRIBUTE_BASE_LIMIT))
		return FALSE
	return TRUE
