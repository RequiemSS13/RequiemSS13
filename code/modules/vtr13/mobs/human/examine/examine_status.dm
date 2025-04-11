/mob/living/carbon/human/proc/examine_status(mob/user)
	. = list()
	var/t_He = p_they(TRUE)
	var/t_is = p_are()
	
	//Status effects
	var/list/status_examines = status_effect_examines()
	if (length(status_examines))
		. += status_examines

	//Jitters
	switch(jitteriness)
		if(300 to INFINITY)
			. += "<span class='warning'><B>[t_He] [t_is] convulsing violently!</B></span>"
		if(200 to 300)
			. += "<span class='warning'>[t_He] [t_is] extremely jittery.</span>"
		if(100 to 200)
			. += "<span class='warning'>[t_He] [t_is] twitching ever so slightly.</span>"
	
	return length(.) ? . : null