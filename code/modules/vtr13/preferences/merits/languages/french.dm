/datum/merit/language/french
	name = "French"
	desc = "The sixth most widely spoken language in the world, common in Africa, parts of North America and southeast Asia, and a couple countries in Europe."

/datum/merit/language/french/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/french)