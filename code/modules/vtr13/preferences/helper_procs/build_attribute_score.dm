/datum/preferences/proc/build_attribute_score(datum/attribute/attribute)
	var/score = attribute.score
	var/bonus_score = attribute.bonus_score
	if(merit_custom_settings["expertise_stat"] == attribute.name)
		bonus_score += 1
	
	var/dat
	for(var/a in 1 to score)
		dat += "<font size=5>●</font>"
	for(var/b in 1 to bonus_score)
		dat += "<font color='red' size=5>●</font>"
	var/leftover_circles = 5 - score - bonus_score //5 is the default number of blank circles
	for(var/c in 1 to leftover_circles)
		dat += "<font size=5>○</font>"
	dat += "  "
	if (score > 1)
		dat += "<a href='byond://?_src_=prefs;preference=decrease_stat;attribute=[FAST_REF(attribute)];task=input'>-</a>"
	if (character_dots && (score < ATTRIBUTE_BASE_LIMIT))
		dat += "<a href='byond://?_src_=prefs;preference=increase_stat;attribute=[FAST_REF(attribute)];task=input'>+</a>"

	dat += "<br>"
	return dat
