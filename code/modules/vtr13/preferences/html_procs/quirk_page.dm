/datum/preferences/proc/quirk_page(mob/user, list/dat)
	if(!SSquirks || !SSquirks.quirks.len)
		dat += "The quirk subsystem hasn't finished initializing, please hold..."
		return

	dat += "<center><b>Choose quirk setup</b></center><br>"
	dat += "<div align='center'>Left-click to add or remove quirks. You need negative quirks to have positive ones.<br>\
	Quirks are applied at roundstart and cannot normally be removed.</div>"
	dat += "<hr>"
	dat += "<center><b>Current quirks:</b> [all_quirks.len ? all_quirks.Join(", ") : "None"]</center>"
	dat += "<center>[GetPositiveQuirkCount()] / [MAX_QUIRKS] max positive quirks<br>\
	<b>Quirk balance remaining:</b> [GetQuirkBalance()]</center><br>"
	for(var/V in SSquirks.quirks)
		var/datum/quirk/T = SSquirks.quirks[V]
		var/quirk_name = initial(T.name)
		var/has_quirk
		var/quirk_cost = initial(T.value) * -1
		var/lock_reason = "This trait is unavailable."
		var/quirk_conflict = FALSE
		for(var/_V in all_quirks)
			if(_V == quirk_name)
				has_quirk = TRUE
		if(initial(T.mood_quirk) && CONFIG_GET(flag/disable_human_mood))
			lock_reason = "Mood is disabled."
			quirk_conflict = TRUE
		if(has_quirk)
			if(quirk_conflict)
				all_quirks -= quirk_name
				has_quirk = FALSE
			else
				quirk_cost *= -1 //invert it back, since we'd be regaining this amount
		if(quirk_cost > 0)
			quirk_cost = "+[quirk_cost]"
		var/font_color = "#AAAAFF"
		if(initial(T.value) != 0)
			font_color = initial(T.value) > 0 ? "#AAFFAA" : "#FFAAAA"

		if(!initial(T.mood_quirk))
			var/datum/quirk/Q = new T()

			if(length(Q.allowed_species))
				var/species_restricted = TRUE
				for(var/i in Q.allowed_species)
					if(i == pref_species.name)
						species_restricted = FALSE
				if(species_restricted)
					lock_reason = "[pref_species.name] restricted."
					quirk_conflict = TRUE
			qdel(Q)

		if(quirk_conflict && lock_reason != "Mood is disabled.")
			dat += "<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)] \
			<font color='red'><b>LOCKED: [lock_reason]</b></font><br>"
		else if(lock_reason != "Mood is disabled.")
			if(has_quirk)
				dat += "<a href='byond://?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
				<b><font color='[font_color]'>[quirk_name]</font></b> - [initial(T.desc)]<br>"
			else
				dat += "<a href='byond://?_src_=prefs;preference=trait;task=update;trait=[quirk_name]'>[has_quirk ? "Remove" : "Take"] ([quirk_cost] pts.)</a> \
				<font color='[font_color]'>[quirk_name]</font> - [initial(T.desc)]<br>"
	dat += "<br><center><a href='byond://?_src_=prefs;preference=trait;task=reset'>Reset Quirks</a></center>"