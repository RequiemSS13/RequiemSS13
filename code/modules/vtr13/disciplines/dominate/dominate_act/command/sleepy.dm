/datum/dominate_act/command/sleepy
	phrase = "Sleep."
	activate_verb = "sleep"
	no_remove = TRUE

/datum/dominate_act/command/sleepy/apply(mob/living/target)
	..()
	target.Sleeping(40)