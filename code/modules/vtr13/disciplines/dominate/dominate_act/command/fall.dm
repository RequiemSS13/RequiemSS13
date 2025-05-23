/datum/dominate_act/command/get_down
	phrase = "Fall."
	activate_verb = "fall to the floor"
	linked_trait = TRAIT_COMMAND_FALL
	duration = 2 SECONDS

/datum/dominate_act/command/get_down/apply(mob/living/target)
	..()
	ADD_TRAIT(target, TRAIT_FLOORED, DOMINATE_ACT_TRAIT)
	target.set_resting(TRUE, FALSE)

/datum/dominate_act/command/get_down/remove(mob/living/target)
	. = ..()
	if(!.)
		return
	REMOVE_TRAIT(target, TRAIT_FLOORED, DOMINATE_ACT_TRAIT)
	target.set_resting(FALSE, FALSE, TRUE)

