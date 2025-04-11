/mob/living/carbon/human/proc/examine_drunkenness(mob/user)
	
	if(!drunkenness || is_face_visible()) //Drunkenness
		return null

	var/t_He = p_they(TRUE)
	var/t_his = p_their()
	var/t_is = p_are()

	switch(drunkenness)
		if(11 to 21)
			return "[t_He] [t_is] slightly flushed."
		if(21.01 to 41) //.01s are used in case drunkenness ends up to be a small decimal
			return "[t_He] [t_is] flushed."
		if(41.01 to 51)
			return "[t_He] [t_is] quite flushed and [t_his] breath smells of alcohol."
		if(51.01 to 61)
			return "[t_He] [t_is] very flushed and [t_his] movements jerky, with breath reeking of alcohol."
		if(61.01 to 91)
			return "[t_He] look[p_s()] like a drunken mess."
		if(91.01 to INFINITY)
			return "[t_He] [t_is] a shitfaced, slobbering wreck."