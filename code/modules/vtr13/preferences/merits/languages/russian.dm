/datum/merit/language/russian
	name = "Russian"
	desc = "Russian is commonly spoken as a second language throughout the former Soviet Union, and the 10th most widely spoken language in Los Angeles."

/datum/merit/language/russian/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/russian)