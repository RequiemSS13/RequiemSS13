/datum/merit/language/italian
	name = "Italian"
	desc = "Italian is the language they speak in Italy."

/datum/merit/language/italian/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/italian)