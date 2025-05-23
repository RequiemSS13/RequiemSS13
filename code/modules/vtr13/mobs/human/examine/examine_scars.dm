//You wanna know how I got these scars?
/mob/living/carbon/human/proc/examine_scars(mob/user)
	. = list()
	var/t_He = p_they(TRUE)
	var/t_has = p_have()
	var/t_is = p_are()
	var/scar_severity = 0
	for(var/i in all_scars)
		var/datum/scar/S = i
		if(S.is_visible(user))
			scar_severity += S.severity

	switch(scar_severity)
		if(1 to 4)
			. += "<span class='tinynoticeital'>[t_He] [t_has] visible scarring, you can look again to take a closer look...</span>\n"
		if(5 to 8)
			. += "<span class='smallnoticeital'>[t_He] [t_has] several bad scars, you can look again to take a closer look...</span>\n"
		if(9 to 11)
			. += "<span class='notice'><i>[t_He] [t_has] significantly disfiguring scarring, you can look again to take a closer look...</i></span>\n"
		if(12 to INFINITY)
			. += "<span class='notice'><b><i>[t_He] [t_is] just absolutely fucked up, you can look again to take a closer look...</i></b></span>\n"

	var/trait_exam = common_trait_examine()
	if (!isnull(trait_exam))
		. += trait_exam