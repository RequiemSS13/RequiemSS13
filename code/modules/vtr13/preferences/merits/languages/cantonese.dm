/datum/merit/language/cantonese
	name = "Cantonese"
	desc = "elgeon describe this language pls"

/datum/merit/language/cantonese/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/cantonese)