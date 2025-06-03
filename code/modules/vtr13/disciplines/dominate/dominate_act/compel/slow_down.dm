/datum/movespeed_modifier/vtr_dominate
	multiplicative_slowdown = 5

/datum/dominate_act/compel/slow_down
	phrase = "Slow down."
	activate_verb = "doubt yourself"
	linked_trait = TRAIT_COMPEL_THINK_TWICE
	duration = 1 MINUTES

/datum/dominate_act/compel/slow_down/apply(mob/living/target)
	..()
	target.add_movespeed_modifier(/datum/movespeed_modifier/vtr_dominate)

/datum/dominate_act/compel/slow_down/remove(mob/living/target)
	. = ..()
	if(!.)
		return
	target.remove_movespeed_modifier(/datum/movespeed_modifier/vtr_dominate)