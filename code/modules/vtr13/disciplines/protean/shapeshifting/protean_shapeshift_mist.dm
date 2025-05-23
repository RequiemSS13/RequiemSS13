/mob/living/simple_animal/hostile/blood_mist
	name = "Blood Mist"
	desc = "Levitating fumes."
	icon = 'icons/effects/effects.dmi'
	icon_state = "smoke"
	icon_living = "smoke"
	color = "red"
	mob_biotypes = MOB_ORGANIC
	density = FALSE
	ventcrawler = VENTCRAWLER_ALWAYS
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB | PASSSTRUCTURE
	mob_size = MOB_SIZE_TINY
	speak_chance = 0
	speed = 1
	maxHealth = 1000
	health = 1000
	butcher_results = list(/obj/item/stack/human_flesh = 1)
	harm_intent_damage = 1
	melee_damage_lower = 1
	melee_damage_upper = 1
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 0
	maxbloodpool = 0
	alpha = 30
	color = "#9C3636"



