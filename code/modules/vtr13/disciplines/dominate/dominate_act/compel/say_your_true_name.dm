/datum/dominate_act/compel/say_your_true_name
	phrase = "Say your name."
	activate_verb = "introduce yourself"
	no_remove = TRUE

/datum/dominate_act/compel/say_your_true_name/apply(mob/living/target)
	..()
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, say), "My name is [target?.true_real_name ? target.true_real_name : target.real_name]!"), 5)