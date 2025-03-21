/datum/discipline_power/vtr/proc/violate_masquerade(mob/living/carbon/human/source, mob/attacker, range = 7, affects_source = FALSE)
	set waitfor = FALSE
	if(owner && owner.CheckEyewitness(source, attacker, range, affects_source))
		owner.AdjustMasquerade(-1)

/datum/discipline_power/vtr/proc/prevent_other_powers(datum/source, datum/target)
	SIGNAL_HANDLER
	to_chat(owner, span_warning("You cannot use other disciplines right now!"))
	return POWER_PREVENT_ACTIVATE