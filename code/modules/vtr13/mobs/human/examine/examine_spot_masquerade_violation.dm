/mob/living/carbon/human/proc/examine_spot_masquerade_violation(mob/user)
	if(ishumanbasic(user))
		return "<a href='byond://?src=[REF(src)];masquerade=1'>Spot a Masquerade violation</a>"