/datum/merit/language/greek
	name = "Greek"
	desc = "elgeon describe this language pls"

/datum/merit/language/greek/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/greek)
