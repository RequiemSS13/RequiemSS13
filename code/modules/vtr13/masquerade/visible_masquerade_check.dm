/mob/living/carbon/human/proc/visible_masquerade_check()
	var/check_dist = 0
	if(HAS_TRAIT(src, TRAIT_EYES_VIOLATING_MASQUERADE) && !src.is_eyes_covered())
		check_dist = 2
	if(HAS_TRAIT(src, TRAIT_NONMASQUERADE))
		check_dist = 3
	if(HAS_TRAIT(src, TRAIT_UNMASQUERADE))
		check_dist = 7
	if(check_dist && src.CheckEyewitness(src, src, check_dist, FALSE))
		src.AdjustMasquerade(-1)