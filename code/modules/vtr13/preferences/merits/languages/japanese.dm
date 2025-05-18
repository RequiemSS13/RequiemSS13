/datum/merit/language/japanese
	name = "Japanese"
	desc = "elgeon describe this language pls"

/datum/merit/language/japanese/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/japanese)