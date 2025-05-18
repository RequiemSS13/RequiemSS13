/datum/merit/language/hebrew
	name = "Hebrew"
	desc = "elgeon describe this language pls"

/datum/merit/language/hebrew/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/hebrew)