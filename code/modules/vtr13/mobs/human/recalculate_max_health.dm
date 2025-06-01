
/mob/living/carbon/human/proc/recalculate_max_health(var/initial = FALSE)
	var/old_max_health = maxHealth
	var/trait_bonus = (HAS_TRAIT(src, TRAIT_HARDY)? 75 : 0) + (HAS_TRAIT(src, TRAIT_FRAIL)? 75 : 0)
	maxHealth = round(initial(maxHealth) + (initial(maxHealth)/4)*(get_stamina()) + trait_bonus)
	if(initial)
		health = maxHealth
	else if(health > 0)
		health = max(health + maxHealth - old_max_health, 1)
