/datum/preferences/proc/generate_discipline_menu(mob/user, list/dat)
	var/discipline_count = 0
	dat += "<h2><center>[make_font_cool("DISCIPLINES")]</center></h2>"
	calculate_discipline_dots()
	dat += "<br><center><b>Discipline Dots Remaining:</b> [discipline_dots]</center><BR>"
	for (var/i in 1 to discipline_types.len)
		var/discipline_type = discipline_types[i]
		if(!discipline_type)
			continue
		var/datum/discipline/discipline = new discipline_type
		var/discipline_level = discipline_levels[i]
		var/is_clan_discipline = FALSE
		
		if(clane?.clane_disciplines)
			is_clan_discipline = clane.clane_disciplines.Find(discipline.type)
		
		if(!is_clan_discipline && regent_clan?.clane_disciplines)
			is_clan_discipline = regent_clan.clane_disciplines.Find(discipline.type)
		
		discipline_count += 1

		dat += "<b>[discipline.name]</b>: "
		switch(discipline_level)
			if(0)
				dat+= "<font size=5>○○○○○</font>"
			if(1)
				dat+= "<font size=5>●○○○○</font>"
			if(2)
				dat+= "<font size=5>●●○○○</font>"
			if(3)
				dat+= "<font size=5>●●●○○</font>"
			if(4)
				dat+= "<font size=5>●●●●○</font>"
			if(5)
				dat+= "<font size=5>●●●●●</font>"
		if(discipline_dots && (discipline_level != 5))
			dat += " <a href='byond://?_src_=prefs;preference=discipline;task=input;upgradediscipline=[i]'>+</a>"
		if(discipline_level)
			dat += " <a href='byond://?_src_=prefs;preference=discipline_decrease;task=input;upgradediscipline=[i]'>-</a>"
		else if(!is_clan_discipline)
			dat += " <a href='byond://?_src_=prefs;preference=discipline_unlearn;task=input;upgradediscipline=[i]'>Unlearn</a>"
		dat += "<BR>"
		dat += "[discipline.desc]<BR><BR>"
		qdel(discipline)
	dat += "<BR>"
	if(discipline_count < 4 || pref_species.id == "ghoul")
		dat += "<a href='byond://?_src_=prefs;preference=newdiscipline;task=input'>Learn a new Discipline</a><BR>"
