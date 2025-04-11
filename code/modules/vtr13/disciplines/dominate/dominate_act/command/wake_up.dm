/datum/dominate_act/command/wake_up
	phrase = "Wake up."
	activate_verb = "awaken"
	no_remove = TRUE

/datum/dominate_act/command/wake_up/apply(mob/living/target)
	..()
	target.SetSleeping(0)
	target.set_resting(FALSE, TRUE, TRUE)
	