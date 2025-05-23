/datum/dominate_act/compel/say_my_name
	phrase = "Say my name."
	activate_verb = "speak"
	no_remove = TRUE

/datum/dominate_act/compel/say_my_name/apply(mob/living/target, mob/living/aggressor)
	..()
	var/mob/living/carbon/human/aggressor_human = aggressor
	if(aggressor_human?.wear_mask?.flags_inv&HIDEFACE || aggressor_human?.head?.flags_inv&HIDEFACE)
		addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, say), "I- don't know your name!"), 5)
		return
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom/movable, say), "[aggressor.name]!"), 5)