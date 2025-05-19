/datum/merit/language/japanese
	name = "Japanese"
	desc = "Japanese is the defacto national language of Japan, and the 12th most widely spoken language in Los Angeles."

/datum/merit/language/japanese/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/japanese)