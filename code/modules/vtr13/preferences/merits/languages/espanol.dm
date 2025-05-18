
/datum/merit/language/espanol
	name = "Espanol"
	desc = "elgeon describe this language pls"

/datum/merit/language/espanol/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/espanol)