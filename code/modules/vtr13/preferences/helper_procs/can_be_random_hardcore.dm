/datum/preferences/proc/can_be_random_hardcore()
	if(parent && (parent.mob.mind?.assigned_role in GLOB.command_positions)) //No command staff
		return FALSE
	for(var/A in parent?.mob.mind?.antag_datums)
		var/datum/antagonist/antag
		if(antag.get_team()) //No team antags
			return FALSE
	return TRUE
