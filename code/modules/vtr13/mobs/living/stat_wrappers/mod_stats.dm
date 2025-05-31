
/mob/living/proc/add_physique_mod(amount, source)
	stats.add_modifier(amount, STAT_PHYSIQUE, source)

/mob/living/proc/add_stamina_mod(amount, source)
	stats.add_modifier(amount, STAT_STAMINA, source)

/mob/living/proc/add_charisma_mod(amount, source)
	stats.add_modifier(amount, STAT_CHARISMA, source)

/mob/living/proc/add_composure_mod(amount, source)
	stats.add_modifier(amount, STAT_COMPOSURE, source)

/mob/living/proc/add_wits_mod(amount, source)
	stats.add_modifier(amount, STAT_WITS, source)

/mob/living/proc/add_resolve_mod(amount, source)
	stats.add_modifier(amount, STAT_RESOLVE, source)


/mob/living/proc/remove_physique_mod(source)
	stats.remove_modifier(STAT_PHYSIQUE, source)

/mob/living/proc/remove_stamina_mod(source)
	stats.remove_modifier(STAT_STAMINA, source)

/mob/living/proc/remove_charisma_mod(source)
	stats.remove_modifier(STAT_CHARISMA, source)

/mob/living/proc/remove_composure_mod(source)
	stats.remove_modifier(STAT_COMPOSURE, source)

/mob/living/proc/remove_wits_mod(source)
	stats.remove_modifier(STAT_WITS, source)

/mob/living/proc/remove_resolve_mod(source)
	stats.remove_modifier(STAT_RESOLVE, source)