/datum/preferences/proc/merit_page(mob/user, list/dat)
	if(!SSmerits || !SSmerits.merits.len)
		dat += "The merit subsystem hasn't finished initializing, please hold..."
		return
	calculate_merit_dots()
	dat += "<center><b>Choose your setup</b></center><br>"
	switch(merit_sub_tab)
		if(PREFS_MERITS_SUB_TAB)
			dat += "<div align='center'>Left-click to add or remove merits. You can gain merit dots by taking flaws.<br>\
			These traits are applied at round start, and cannot normally be removed.</div>"
		if(PREFS_FLAWS_SUB_TAB)
			dat += "<div align='center'>Left-click to add or remove flaws. You flaws grant you merit dots- you can spend them by taking merits.<br>\
			These traits are applied at round start, and cannot normally be removed.</div>"
		if(PREFS_BANES_SUB_TAB)
			dat += "<div align='center'>Left-click to add or remove banes. Banes are part of the vampiric curse, and confer no bonuses.<br>\
			These traits are applied at round start, and cannot normally be removed.</div>"
		if(PREFS_LANGUAGES_SUB_TAB)
			dat += "<div align='center'>Left-click to add or remove languages. You know these languages in addition to english.<br>\
			These traits are applied at round start, and cannot normally be removed.</div>"
	dat += "<hr>"
	dat += "<table align='center'><tr>"
	dat += "<td width='20%' align='center'><a href='byond://?_src_=prefs;preference=tab;merit_tab=[PREFS_MERITS_SUB_TAB]' [merit_sub_tab == PREFS_MERITS_SUB_TAB ? "class='linkOn'" : ""]>[make_font_cool("MERITS")]</a></td>"
	dat += "<td width='20%' align='center'><a href='byond://?_src_=prefs;preference=tab;merit_tab=[PREFS_FLAWS_SUB_TAB]' [merit_sub_tab == PREFS_FLAWS_SUB_TAB ? "class='linkOn'" : ""]>[make_font_cool("FLAWS")]</a></td>"
	if(pref_species.name == "Vampire")
		dat += "<td width='20%' align='center'><a href='byond://?_src_=prefs;preference=tab;merit_tab=[PREFS_BANES_SUB_TAB]' [merit_sub_tab ==PREFS_BANES_SUB_TAB  ? "class='linkOn'" : ""]>[make_font_cool("BANES")]</a></td>"
	dat += "<td width='20%' align='center'><a href='byond://?_src_=prefs;preference=tab;merit_tab=[PREFS_LANGUAGES_SUB_TAB]' [merit_sub_tab == PREFS_LANGUAGES_SUB_TAB ? "class='linkOn'" : ""]>[make_font_cool("LANGUAGES")]</a></td>"
	dat += "</tr><table>"


	dat += "<hr>"
	dat += "<center><b>Current traits:</b> [all_merits.len ? all_merits.Join(", ") : "None"]</center>"
	switch(merit_sub_tab)
		if(PREFS_BANES_SUB_TAB)
			dat += "<br><center><b>Banes Required:</b> [GetMeritCount(MERIT_BANE)]/[GetRequiredBanes()]</center><BR>"
		if(PREFS_LANGUAGES_SUB_TAB)
			dat += "<br><center><b>Languages:</b> [GetMeritCount(MERIT_LANGUAGE)]/[GetMaxLanguages()]</center><BR>"
		else
			dat += "<br><center><b>Merit Dots Remaining:</b> [merit_dots]</center><BR>"

	dat += "<table align='center' width='90%'>"
	dat += "<tr>"
	if(merit_sub_tab == PREFS_MERITS_SUB_TAB)
		dat += "<td><center><b>Cost</b></center></td>"
	else if (merit_sub_tab == PREFS_FLAWS_SUB_TAB)
		dat += "<td><center><b>Bonus</b></center></td>"
	else
		dat += "<td></td>"
	dat += "<td></td>"
	dat += "<td><center><b>Name</b></center></td>"
	dat += "<td><center><b>Description</b></center></td>"
	dat += "</tr>"


	var/list/source_list = null
	switch(merit_sub_tab)
		if(PREFS_MERITS_SUB_TAB)
			source_list = SSmerits.merits_merits
		if(PREFS_FLAWS_SUB_TAB)
			source_list = SSmerits.merits_flaws
		if(PREFS_BANES_SUB_TAB)
			source_list = SSmerits.merits_banes
		if(PREFS_LANGUAGES_SUB_TAB)
			source_list = SSmerits.merits_languages
		else
			source_list = SSmerits.merits

	var/i = 1
	for(var/merit_name in source_list)
		
		var/datum/merit/merit_type = SSmerits.merits[merit_name]

		var/has_merit = all_merits.Find(merit_name)

		switch(merit_sub_tab)
			if(PREFS_MERITS_SUB_TAB)
				if(initial(merit_type.category) != MERIT_MERIT)
					continue
			if(PREFS_FLAWS_SUB_TAB)
				if(initial(merit_type.category) != MERIT_FLAW)
					continue
			if(PREFS_BANES_SUB_TAB)
				if(initial(merit_type.category) != MERIT_BANE)
					continue

		if(has_merit)
			dat += "<tr style='vertical-align:top; background-color:rgba(0, 125, 0, 0.2);'>"
		else if( (i % 2) == 0)
			dat += "<tr style='vertical-align:top; background-color:rgba(128, 128, 128, 0.2);'>"
		else
			dat += "<tr style='vertical-align:top; background-color:rgba(64, 64, 64, 0.2);'>"
		i++

		var/dot_cost_display = ""
		if(initial(merit_type.dots))
			for (var/y in 1 to abs(initial(merit_type.dots)))
				dot_cost_display += "<font size=5>●</font>"
		else
			dot_cost_display = "<font size=5>○</font>"
		dat += "<td width='10%' align='center'><p style='vertical-align: middle;'>[dot_cost_display]</p></td>"

		var/lock_reason = SSmerits.CanAddMerit(src, merit_type, TRUE)
		if(lock_reason)
			dat += "<td width='15%' align='center'><p style='vertical-align: middle;'><font color='red'><b>LOCKED</b></font></p></td>"
			dat += "<td width='20%' align='center'><p style='vertical-align: middle;'><s>[merit_name]</s></p></td>"
			dat += "<td align='center'><font color='red'><p style='vertical-align: middle;'><b>[lock_reason]</b></font></p></td>"
			dat+="</tr>"
			continue

		if(has_merit)
			dat += "<td width='15%' align='center'><p style='vertical-align: middle;'><a href='byond://?_src_=prefs;preference=trait;task=remove;trait=[merit_name]'>Remove</a></p></td>"
		else
			dat += "<td width='15%' align='center'><p style='vertical-align: middle;'><a href='byond://?_src_=prefs;preference=trait;task=add;trait=[merit_name]'>Add</a></p></td>"
		dat += "<td width='20%' align='center'><p style='vertical-align: middle;'><b>[merit_name]</b></p></td>"
		dat += "<td align='center'><p style='vertical-align: middle;'>[initial(merit_type.desc)]</p></td>"
		dat += "</tr>"
		
	dat += "</table>"
	dat += "<br><center><a href='byond://?_src_=prefs;preference=trait;task=reset'>Reset Quirks</a></center>"