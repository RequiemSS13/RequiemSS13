/mob/living/carbon/human/add_stamina_mod(amount, source)
	stats.add_modifier(amount, STAT_STAMINA, source)
	recalculate_max_health()


/mob/living/carbon/human/remove_stamina_mod(source)
	stats.remove_modifier(STAT_STAMINA, source)
	recalculate_max_health()