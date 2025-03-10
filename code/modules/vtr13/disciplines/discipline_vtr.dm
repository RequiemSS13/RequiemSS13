/datum/discipline_power/vtr/proc/violate_masquerade(mob/living/carbon/human/source, mob/attacker, range = 7, affects_source = FALSE)
	set waitfor = FALSE
	if(owner && owner.CheckEyewitness(source, attacker, range, affects_source))
		owner.AdjustMasquerade(-1)