/datum/merit/language/latin
	name = "Latin"
	desc = "elgeon describe this language pls"

/datum/merit/language/latin/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/latin)