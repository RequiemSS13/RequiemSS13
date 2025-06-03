/mob/living/carbon/human/proc/examine_humanity(mob/user, temp_gender = null)
	if(!is_face_visible())
		return

	var/t_He = p_they(TRUE, temp_gender)
	var/t_he = p_they(FALSE, temp_gender)
	var/t_is = p_are(temp_gender)
	var/t_s = p_s(temp_gender)
	var/adjusted_humanity = humanity
	if(HAS_TRAIT(src, TRAIT_LONELY_CURSE))
		adjusted_humanity = min(0, (adjusted_humanity-2))

	if(adjusted_humanity <= 3)
		switch(adjusted_humanity)
			if(3)
				return (span_danger("[t_He] feel[t_s] unusual to you. Sickly."))
			if(2)
				return (span_danger("[t_He] [t_is]n't well. More like a shambling corpse than a person."))
			if(1)
				return (span_danger("[t_He] [t_is] a macabre puppet of sinew and flesh. Barely human."))
			if(0)
				return (span_danger("[t_He] [t_is] a monster. You understand that [t_he] [t_is] a monster. You must fight, or make flight."))