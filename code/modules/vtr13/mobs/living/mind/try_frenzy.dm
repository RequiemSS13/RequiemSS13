//Send a signal to the frenzy component, if we have one.
/datum/mind/proc/try_frenzy(modifier)
	if(!current)
		return
	SEND_SIGNAL(src, COMSIG_MIND_TRY_FRENZY, modifier)