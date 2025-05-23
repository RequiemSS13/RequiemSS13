/datum/mind/proc/mod_tempted(modifier, balloon_popup = TRUE)
	if(!modifier)
		return
	
	var/new_tempted_mod = clamp(tempted_mod + modifier, 0, 3)
	if(balloon_popup && new_tempted_mod != tempted_mod && current)
		if(new_tempted_mod > tempted_mod)
			current.balloon_alert(current, "<span style='color: #0000ff;'>[tempted_mod?"+":""]TEMPTED [new_tempted_mod]</span>")
		else if (!new_tempted_mod)
			current.balloon_alert(current, "<span style='color: #14a833;'>-TEMPTED</span>")
		else
			current.balloon_alert(current, "<span style='color: #14a833;'>TEMPTED [new_tempted_mod]</span>")
	
	if(tempted_mod == new_tempted_mod)
		return
	
	tempted_mod = new_tempted_mod
	var/datum/preferences/P = GLOB.preferences_datums[ckey(src.key)]
	if(P)
		P.tempted = tempted_mod
		P.save_character()