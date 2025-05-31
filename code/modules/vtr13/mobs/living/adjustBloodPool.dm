/mob/living/proc/adjustBloodPool(blood_delta, on_spawn = FALSE)
	if(on_spawn)
		bloodpool=0

	bloodpool = clamp(bloodpool+blood_delta, 0, maxbloodpool)



/mob/living/carbon/human/adjustBloodPool(blood_delta, on_spawn = FALSE)
	..()
	if(HAS_TRAIT(src, TRAIT_FACE_OF_HUNGER))
		if(!dna?.species?.limbs_id)
			return
		if(bloodpool <= 5 && !HAS_TRAIT_FROM(src, TRAIT_UNMASQUERADE, TRAIT_FACE_OF_HUNGER))
			dna.species.limbs_id = "nosferatu"
			update_body_parts()
			update_body()
			update_icon()
			ADD_TRAIT(src, TRAIT_UNMASQUERADE, TRAIT_FACE_OF_HUNGER)
		
		else if(!HAS_TRAIT_FROM(src, TRAIT_UNMASQUERADE, TRAIT_FACE_OF_HUNGER))
			dna.species.limbs_id = initial(dna.species.limbs_id)
			update_body_parts()
			update_body()
			update_icon()
			REMOVE_TRAIT(src, TRAIT_UNMASQUERADE, TRAIT_FACE_OF_HUNGER)