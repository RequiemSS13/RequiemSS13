/datum/preferences/proc/build_attribute_score(var/attribute, var/bonus_number, var/price, var/variable_name)
	var/dat
	for(var/a in 1 to attribute)
		dat += "●"
	for(var/b in 1 to bonus_number)
		dat += "●"
	var/leftover_circles = 5 - attribute //5 is the default number of blank circles
	for(var/c in 1 to leftover_circles)
		dat += "○"
	dat += "  "
	if (attribute > 1)
		dat += "<a href='byond://?_src_=prefs;preference=[variable_name]_decrease;task=input'>-</a>"
	if (character_dots && (attribute < ATTRIBUTE_BASE_LIMIT))
		dat += "<a href='byond://?_src_=prefs;preference=[variable_name];task=input'>+</a>"

	dat += "<br>"
	return dat