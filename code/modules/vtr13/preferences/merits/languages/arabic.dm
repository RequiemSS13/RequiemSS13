/datum/merit/language/arabic
	name = "Arabic"
	desc = "The fifth most spoken language in the world, and the 11th most spoken in Los Angeles."

/datum/merit/language/arabic/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/arabic)