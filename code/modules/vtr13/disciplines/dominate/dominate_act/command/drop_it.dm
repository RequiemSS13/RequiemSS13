/datum/dominate_act/command/drop_it
	phrase = "Drop it."
	activate_verb = "drop your possessions"
	no_remove = TRUE

/datum/dominate_act/command/drop_it/apply(mob/living/target)
	..()
	target.drop_all_held_items()