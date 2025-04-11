/mob/living/simple_animal/hostile/protean
	name = "Apex Predator"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'code/modules/wod13/32x48.dmi'
	icon_state = "gangrel_f"
	icon_living = "gangrel_f"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	speak_chance = 0
	speed = -0.4
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 40
	melee_damage_upper = 40
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	dextrous = TRUE
	held_items = list(null, null)

/mob/living/simple_animal/hostile/protean/best
	icon_state = "gangrel_m"
	icon_living = "gangrel_m"
	maxHealth = 500
	health = 500
	melee_damage_lower = 55
	melee_damage_upper = 55
