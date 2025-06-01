/mob/living/carbon/human/proc/visible_masquerade_check()
	var/check_dist = 0
	var/check_type = INFRACTION_TYPE_DEFAULT
	if(HAS_TRAIT(src, TRAIT_EYES_VIOLATING_MASQUERADE) && !src.is_eyes_covered())
		check_dist = 2
	if(HAS_TRAIT(src, TRAIT_NONMASQUERADE))
		check_dist = 3
	if(HAS_TRAIT(src, TRAIT_UNMASQUERADE))
		check_dist = 7
	
	if(!check_dist && is_face_visible() && HAS_TRAIT(src, TRAIT_UGLY))
		check_dist = 7
		check_type = INFRACTION_TYPE_UGLY

	if(check_dist && src.CheckEyewitness(src, src, check_dist, FALSE, check_type))
		src.AdjustMasquerade(-1)