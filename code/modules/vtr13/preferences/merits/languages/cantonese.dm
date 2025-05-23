/datum/merit/language/cantonese
	name = "Cantonese"
	desc = "One of the official languages of Hong Kong, and the fourth most widely spoken language in Los Angeles."

/datum/merit/language/cantonese/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/cantonese)