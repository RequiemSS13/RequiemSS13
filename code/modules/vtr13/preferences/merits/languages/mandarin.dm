/datum/merit/language/chinese
	name = "Mandarin"
	desc = "Mandarin is the most widely spoken language on the planet, and the third-most spoken language in Los Angeles."

/datum/merit/language/chinese/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/mandarin)
