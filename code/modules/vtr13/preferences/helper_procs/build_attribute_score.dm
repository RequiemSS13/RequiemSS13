/datum/preferences/proc/build_attribute_score(datum/attribute/attribute)
	var/score = attribute.score
	var/bonus_score = attribute.bonus_score
	var/dat

	for(var/a in 1 to score)
		dat += "●"
	for(var/b in 1 to bonus_score)
		dat += "●"
	var/leftover_circles = 5 - score //5 is the default number of blank circles
	for(var/c in 1 to leftover_circles)
		dat += "○"
	dat += "  "
	if (score > 1)
		dat += "<a href='byond://?_src_=prefs;preference=decrease_stat;attribute=[FAST_REF(attribute)];task=input'>-</a>"
	if (character_dots && (score < ATTRIBUTE_BASE_LIMIT))
		dat += "<a href='byond://?_src_=prefs;preference=increase_stat;attribute=[FAST_REF(attribute)];task=input'>+</a>"

	dat += "<br>"
	return dat
