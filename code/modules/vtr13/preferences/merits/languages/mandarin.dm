/datum/merit/language/chinese
	name = "Mandarin"
	desc = "elgeon describe this language pls"

/datum/merit/language/chinese/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/mandarin)
