/mob/living/carbon/human/proc/examine_beast(mob/user, temp_gender = null)

	var/t_He = p_they(TRUE, temp_gender)
	var/t_him = p_them(FALSE, temp_gender)
	var/t_is = p_are(temp_gender)
	if(iskindred(src) && (iskindred(user) || HAS_TRAIT(user, TRAIT_USING_AUSPEX)))
		return span_danger("You sense the Beast within [t_him] - [t_He] [t_is] Kindred.")
	else if(isghoul(src) && HAS_TRAIT(user, TRAIT_USING_AUSPEX))
		return span_danger("You sense the faint dregs of the Beast within [t_him] - [t_He] [t_is] a Ghoul.")
