/mob/living/proc/adjustBloodPool(blood_delta, on_spawn = FALSE)
	if(on_spawn)
		bloodpool=0

	bloodpool = clamp(bloodpool+blood_delta, 0, maxbloodpool)



/mob/living/carbon/human/adjustBloodPool(blood_delta, on_spawn = FALSE)
	..()
	if(HAS_TRAIT(src, TRAIT_FACE_OF_HUNGER))
		if(bloodpool <= 5 && !HAS_TRAIT_FROM(src, TRAIT_UNMASQUERADE, TRAIT_FACE_OF_HUNGER))
			eye_color = "#ff0000"
			ADD_TRAIT(src, TRAIT_UGLY, TRAIT_FACE_OF_HUNGER)
			update_body()
		
		else if(!HAS_TRAIT_FROM(src, TRAIT_UNMASQUERADE, TRAIT_FACE_OF_HUNGER))
			var/pref_eye_color = client?.prefs?.eye_color
			if(pref_eye_color)
				eye_color = pref_eye_color
			else
				eye_color = initial(eye_color)
			update_body()
			REMOVE_TRAIT(src, TRAIT_UGLY, TRAIT_FACE_OF_HUNGER)