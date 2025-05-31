/datum/merit/bane/face_of_hunger
	name = "Face of Hunger"
	desc = "Your appearence violates the masquerade when you are starving (5 hunger or below)."
	mob_trait = TRAIT_FACE_OF_HUNGER



/datum/merit/bane/face_of_hunger/on_spawn()
	. = ..()
	merit_holder.adjustBloodPool(0)


/datum/merit/bane/face_of_hunger/remove()
	merit_holder.adjustBloodPool(0)