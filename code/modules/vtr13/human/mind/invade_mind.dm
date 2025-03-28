/datum/mind/proc/invade_mind(mob/invader)
	SEND_SIGNAL(src, COMSIG_MEMORY_AUSPEX_INVADE, invader)