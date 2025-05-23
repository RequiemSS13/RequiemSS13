/datum/merit/bane/profane_blood
	name = "Profane Blood"
	desc = "Physical manifestations of faith, such as a cross or the inside of a church, cause your skin to burn. The mere sight of it can repel you."
	mob_trait = TRAIT_HOLY_WEAKNESS
	gain_text = "<span class='warning'>The presence of the local church fills you with unease.</span>"


/datum/merit/bane/profane_blood/post_add()
	merit_holder.AddElement(/datum/element/holy_weakness)

/datum/merit/bane/profane_blood/remove()
	merit_holder.RemoveElement(/datum/element/holy_weakness)