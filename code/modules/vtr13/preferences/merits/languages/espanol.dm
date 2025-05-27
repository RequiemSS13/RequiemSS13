
/datum/merit/language/espanol
	name = "Spanish"
	desc = "The second most commonly spoken language in the world, the United States, and Los Angeles county."

/datum/merit/language/espanol/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/espanol)