/datum/merit/language/russian
	name = "Russian"
	desc = "elgeon describe this language pls"

/datum/merit/language/russian/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/russian)