/datum/merit/language/hebrew
	name = "Hebrew"
	desc = "Among the oldest commonly spoken languages, Hebrew is a Near-Eastern language that spent over a thousand years extinct as a mother tongue, before an unprecedented revival movement in the 1800s. It is also the liturgical language of Judaism."

/datum/merit/language/hebrew/add()
	var/mob/living/carbon/H = merit_holder
	H.grant_language(/datum/language/hebrew)