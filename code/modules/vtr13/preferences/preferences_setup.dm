

///Setup a hardcore random character and calculate their hardcore random score
/datum/preferences/proc/hardcore_random_setup(mob/living/carbon/human/character, antagonist, is_latejoiner)
	var/rand_gender = pick(list(MALE, FEMALE, PLURAL))
	random_character(rand_gender, antagonist)