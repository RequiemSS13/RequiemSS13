/datum/merit/language/arabic
	name = "Arabic"
	desc = "elgeon describe this language pls"

/datum/merit/language/arabic/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/arabic)