/mob/living/setDir(newdir)
	if(SEND_SIGNAL(src, COMSIG_LIVING_DIR_CHANGE, dir, newdir) & COMPONENT_LIVING_DIR_CHANGE_BLOCK)
		return
	..()