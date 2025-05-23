/datum/dominate_act/compel/break_it_down
	phrase = "Break it down."
	activate_verb = "bust a move"
	no_remove = TRUE

/datum/dominate_act/compel/break_it_down/apply(mob/living/target)
	..()
	target.set_resting(FALSE, TRUE, TRUE)
	target.vtr_dance()