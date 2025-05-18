/datum/merit/language/italian
	name = "Italian"
	desc = "elgeon describe this language pls"

/datum/merit/language/italian/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/italian)