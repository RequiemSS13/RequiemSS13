/datum/merit/hardy
	name = "Hardy"
	desc = "You are more durable than your peers. Your max health is higher."
	mob_trait = TRAIT_HARDY
	dots = 3

/datum/merit/hardy/post_add()
	var/mob/living/carbon/human/human_holder = merit_holder
	human_holder.recalculate_max_health()

/datum/merit/hardy/remove()
	var/mob/living/carbon/human/human_holder = merit_holder
	human_holder.recalculate_max_health()