/mob/living/proc/get_physique(include_bonus = TRUE)
	return stats.get_stat(STAT_PHYSIQUE, include_bonus)

/mob/living/proc/get_stamina(include_bonus = TRUE)
	return stats.get_stat(STAT_STAMINA)

/mob/living/proc/get_charisma(include_bonus = TRUE)
	return stats.get_stat(STAT_CHARISMA, include_bonus)

/mob/living/proc/get_composure(include_bonus = TRUE)
	return stats.get_stat(STAT_COMPOSURE, include_bonus)

/mob/living/proc/get_wits(include_bonus = TRUE)
	return stats.get_stat(STAT_WITS, include_bonus)

/mob/living/proc/get_resolve(include_bonus = TRUE)
	return stats.get_stat(STAT_RESOLVE, include_bonus)
