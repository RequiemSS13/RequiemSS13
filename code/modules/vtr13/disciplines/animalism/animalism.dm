/datum/discipline/vtr/animalism
	name = "Animalism"
	desc = "Summon and control animals, including the Beasts of other Kindred."
	icon_state = "animalism"
	power_type = /datum/discipline_power/vtr/animalism

	//Allowed animal possession types
	var/list/allowed_types = list(
		/mob/living/simple_animal/hostile/beastmaster/rat,
		/mob/living/simple_animal/hostile/beastmaster/cat,
		/mob/living/simple_animal/pet/rat,
		/mob/living/simple_animal/pet/cat/vampire
	)

/datum/discipline/vtr/animalism/post_gain()
	. = ..()
	if(level > 3)
		allowed_types += /mob/living/simple_animal/hostile/beastmaster
		allowed_types += /mob/living/simple_animal/hostile/beastmaster/rat/flying
		allowed_types += /mob/living/simple_animal/deer
	if(level == 5)
		allowed_types += /mob/living/simple_animal/hostile/bear/wod13




/datum/discipline_power/vtr/animalism
	name = "Animalism power name"
	desc = "Animalism power description"

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	effect_sound = 'code/modules/wod13/sounds/wolves.ogg'
	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS


