/datum/merit/language/german
	name = "German"
	desc = "elgeon describe this language pls"

/datum/merit/language/german/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/german)
