/datum/merit/language/latin
	name = "Latin"
	desc = "Latin was the state language of the Roman Empire, and the language of law and government throughout much of Europe for more than a thousand years. It is also the liturgical language of the Catholic Church."

/datum/merit/language/latin/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/latin)