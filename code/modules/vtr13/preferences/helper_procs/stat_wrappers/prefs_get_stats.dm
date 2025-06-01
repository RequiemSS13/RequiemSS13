/datum/preferences/proc/get_physique(include_bonus = TRUE)
	return stats.get_stat(STAT_PHYSIQUE, include_bonus)

/datum/preferences/proc/get_stamina(include_bonus = TRUE)
	return stats.get_stat(STAT_STAMINA, include_bonus)

/datum/preferences/proc/get_charisma(include_bonus = TRUE)
	return stats.get_stat(STAT_CHARISMA, include_bonus)

/datum/preferences/proc/get_composure(include_bonus = TRUE)
	return stats.get_stat(STAT_COMPOSURE, include_bonus)

/datum/preferences/proc/get_wits(include_bonus = TRUE)
	return stats.get_stat(STAT_WITS, include_bonus)

/datum/preferences/proc/get_resolve(include_bonus = TRUE)
	return stats.get_stat(STAT_RESOLVE, include_bonus)

/datum/preferences/proc/get_potency(include_bonus = TRUE)
	return stats.get_stat(STAT_POTENCY, include_bonus)