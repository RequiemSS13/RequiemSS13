/mob/living/carbon/human/proc/examine_beast(mob/user, temp_gender = null)
	var/t_He = p_they(TRUE, temp_gender)
	var/t_he = p_they(FALSE, temp_gender)
	var/t_him = p_them(FALSE, temp_gender)
	var/t_is = p_are(temp_gender)
	var/t_do = p_do(temp_gender)



	if(ishuman(user))
		if(HAS_TRAIT(src, TRAIT_LONELY_CURSE) && prob(3))
			return span_userdanger("You realize that [t_he] [t_is] an enemy. A predator. A psychopath. Something. Something that should be avoided; reviled.")
		if(HAS_TRAIT(src, TRAIT_ALOOF_CURSE) && prob(5))
			return span_userdanger("You realize [t_he] [t_do] not care about you. Not really. You do not matter to [t_him].")

	if(iskindred(src) && HAS_TRAIT(user, TRAIT_UNSEEN_SENSE))
		return span_danger("You sense something deeply unnatural about [t_him].")

	if(iskindred(src) && (iskindred(user) || HAS_TRAIT(user, TRAIT_USING_AUSPEX)))
		return span_danger("You sense the Beast within [t_him] - [t_He] [t_is] Kindred.")

	if(isghoul(src) && HAS_TRAIT(user, TRAIT_USING_AUSPEX))
		return span_danger("You sense the faint dregs of the Beast within [t_him] - [t_He] [t_is] a Ghoul.")
