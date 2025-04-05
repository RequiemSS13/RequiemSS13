/datum/dominate_act/compel/clap
	phrase = "Clap."
	activate_verb = "clap your hands"
	no_remove = TRUE

/datum/dominate_act/compel/clap/apply(mob/living/target)
	..()
	addtimer(CALLBACK(target, TYPE_PROC_REF(/mob/living/, emote), "clap"), 5)