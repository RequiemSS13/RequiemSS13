/mob/living/carbon/human/proc/examine_death(mob/user)
	. = list()
	var/t_He = p_they(TRUE)
	var/t_his = p_their()

	if((stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH))))
		if(suiciding)
			. += "<span class='warning'>[t_He] appear[p_s()] to have committed suicide... there is no hope of recovery.</span>"
		. += generate_death_examine_text()
	if(get_bodypart(BODY_ZONE_HEAD) && !getorgan(/obj/item/organ/brain) && surgeries.len)
		. += "<span class='deadsay'>It appears that [t_his] brain is missing...</span>"
	return length(.) ? . : null