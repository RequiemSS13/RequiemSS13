
//Stupid shitty function used by things that have nothing to do with frenzy
//Remove when someone sensible changes that
/mob/living/carbon/proc/CheckFrenzyMove()
	if(stat >= SOFT_CRIT)
		return TRUE
	if(IsSleeping())
		return TRUE
	if(IsUnconscious())
		return TRUE
	if(IsParalyzed())
		return TRUE
	if(IsKnockdown())
		return TRUE
	if(IsStun())
		return TRUE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE