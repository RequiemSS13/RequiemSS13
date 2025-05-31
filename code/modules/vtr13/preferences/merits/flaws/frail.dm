/datum/merit/flaw/frail
	name = "Frail"
	desc = "You are extremely flimsy, like a little baby bird. Your max health is lower."
	mob_trait = TRAIT_FRAIL
	dots = -3

/datum/merit/flaw/frail/post_add()
	var/mob/living/carbon/human/human_holder = merit_holder
	human_holder.recalculate_max_health()

/datum/merit/flaw/frail/remove()
	var/mob/living/carbon/human/human_holder = merit_holder
	human_holder.recalculate_max_health()