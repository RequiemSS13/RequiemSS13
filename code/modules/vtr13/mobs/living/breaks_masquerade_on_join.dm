//determines if a given player must spawn at the river as a fallback
/mob/living/proc/breaks_masquerade_on_join()
	if(bloodpool <= 1)
		return TRUE
	if(HAS_TRAIT(src, TRAIT_FACE_OF_HUNGER) &&  src.bloodpool <= 5)
		return TRUE
	if(HAS_TRAIT(src, TRAIT_UGLY))
		return TRUE
	return FALSE
