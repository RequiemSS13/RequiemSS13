/datum/preferences/proc/get_max_blood_potency()
	. = 0
	if(pref_species.name != "Vampire")
		return
	switch(vamp_rank)
		if(VAMP_RANK_HALF_DAMNED)
			. = 1
		if(VAMP_RANK_FLEDGLING)
			. = 1
		if(VAMP_RANK_NEONATE)
			. = 1
		if(VAMP_RANK_ANCILLAE)
			. = 3
		if(VAMP_RANK_ELDER)
			. = 5
		else
			. = 0

/datum/preferences/proc/adjust_blood_potency()
	var/max_blood_potency = get_max_blood_potency()
	set_potency(min(max_blood_potency, get_potency()))

/datum/preferences/proc/build_blood_potency_menu(var/list/dat)

	var/max_blood_potency = get_max_blood_potency()
	adjust_blood_potency()
	dat += "<h2><center>[make_font_cool("BLOOD POTENCY")]</center></h2><br>"
	dat += "Blood Potency:"
	for(var/a in 1 to get_potency())
		dat += "<font size=5>●</font>"
	
	var/diablerie_bonus = 0
	if(all_merits.Find("Diablerist"))
		dat += "<font size=5 color='red'>●</font>"
		diablerie_bonus = 1

	var/leftover_circles = max_blood_potency - get_potency() - diablerie_bonus
	for(var/c in 1 to leftover_circles)
		dat += "<font size=5>○</font>"
	
	if(get_potency(FALSE) > 1)
		dat += "<a href='byond://?_src_=prefs;preference=decrease_potency;task=input'>-</a>"
	if(get_potency(FALSE) != max_blood_potency)
		dat += "<a href='byond://?_src_=prefs;preference=increase_potency;task=input'>+</a>"

	dat += "<br><i>[POTENCY_DESCRIPTION]</i><br>"
