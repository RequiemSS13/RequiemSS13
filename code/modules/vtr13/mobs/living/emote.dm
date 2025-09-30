/datum/emote/living/howl/run_emote(mob/user, params , type_override, intentional)
	. = ..()
	var/mob/living/ = user
	if(HAS_TRAIT(user, TRAIT_FERAL_CURSE) || istype(user, /mob/living/simple_animal/hostile/beastmaster) && !istype(user, /mob/living/simple_animal/hostile/beastmaster/rat/flying))
		if(rand(1,2) == 1)
			playsound(get_turf(user), 'code/modules/wod13/sounds/awo1.ogg', 75, TRUE)
		else
			playsound(get_turf(user), 'code/modules/wod13/sounds/awo2.ogg', 75, TRUE)