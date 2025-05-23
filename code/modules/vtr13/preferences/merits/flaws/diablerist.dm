/datum/merit/flaw/diablerist
	name = "Diablerist"
	desc = "For one reason or another, you have committed Diablerie in your past, a great crime within Kindred society. <b>This is not a license to Diablerize without proper reason!</b>"
	dots = -2
	splat_flags = MERIT_SPLAT_KINDRED

/datum/merit/flaw/diablerist/on_spawn()
	var/mob/living/carbon/human/H = merit_holder
	H.diablerist = TRUE