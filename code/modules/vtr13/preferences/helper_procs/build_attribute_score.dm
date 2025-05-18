/datum/preferences/proc/build_attribute_score(var/attribute, var/bonus_number, var/price, var/variable_name)
	var/dat
	for(var/a in 1 to attribute)
		dat += "<font size=5>●</font>"
	for(var/b in 1 to bonus_number)
		dat += "<font size=5>●</font>"

	var/expertise_bonus = 0
	if(merit_custom_settings["expertise_stat"] == variable_name)
		expertise_bonus = 1
	
	var/leftover_circles = 5 - attribute - expertise_bonus //5 is the default number of blank circles

	if(leftover_circles <= 5 && merit_custom_settings["expertise_stat"] == variable_name)
		dat += "<font color='red' size=5>●</font>"

	if(leftover_circles > 0)
		for(var/c in 1 to leftover_circles)
			dat += "<font size=5>○</font>"

	dat += "  "

	if (attribute > 1)
		dat += "<a href='byond://?_src_=prefs;preference=[variable_name]_decrease;task=input'>-</a>"
	if (character_dots && (attribute < ATTRIBUTE_BASE_LIMIT))
		dat += "<a href='byond://?_src_=prefs;preference=[variable_name];task=input'>+</a>"

	dat += "<br>"
	return dat