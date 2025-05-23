
/mob/living/carbon/human/proc/recalculate_max_health(var/initial = FALSE)
	var/old_max_health = maxHealth
	maxHealth = round((initial(maxHealth) + (initial(maxHealth)/4)*(get_total_stamina()) + 25*(blood_potency)))
	if(initial)
		health = maxHealth
	else if(health > 0)
		health = max(health + maxHealth - old_max_health, 1)