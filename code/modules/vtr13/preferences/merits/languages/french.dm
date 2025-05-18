/datum/merit/language/french
	name = "French"
	desc = "elgeon describe this language pls"

/datum/merit/language/french/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/french)