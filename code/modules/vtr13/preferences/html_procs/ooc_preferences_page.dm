/datum/preferences/proc/ooc_preferences_page(mob/user, list/dat)
	dat += "<table><tr><td width='340px' height='300px' valign='top'>"
	dat += "<h2>[make_font_cool("OOC")]</h2>"
	dat += "<b>Window Flashing:</b> <a href='byond://?_src_=prefs;preference=winflash'>[(windowflashing) ? "Enabled":"Disabled"]</a><br>"
	dat += "<br>"
	dat += "<b>Play Admin MIDIs:</b> <a href='byond://?_src_=prefs;preference=hear_midis'>[(toggles & SOUND_MIDI) ? "Enabled":"Disabled"]</a><br>"
	dat += "<b>Play Lobby Music:</b> <a href='byond://?_src_=prefs;preference=lobby_music'>[(toggles & SOUND_LOBBY) ? "Enabled":"Disabled"]</a><br>"
	dat += "<b>Play End of Round Sounds:</b> <a href='byond://?_src_=prefs;preference=endofround_sounds'>[(toggles & SOUND_ENDOFROUND) ? "Enabled":"Disabled"]</a><br>"
	dat += "<b>See Pull Requests:</b> <a href='byond://?_src_=prefs;preference=pull_requests'>[(chat_toggles & CHAT_PULLR) ? "Enabled":"Disabled"]</a><br>"
	dat += "<br>"

	if(user.client)
		if(check_rights_for(user.client, R_ADMIN))
			dat += "<b>OOC Color:</b> <span style='border: 1px solid #161616; background-color: [ooccolor ? ooccolor : GLOB.normal_ooc_colour];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=ooccolor;task=input'>Change</a><br>"
		if(hearted_until)
			dat += "<a href='byond://?_src_=prefs;preference=clear_heart'>Clear OOC Commend Heart</a><br>"

	dat += "</td>"

	if(user.client.holder)
		dat +="<td width='300px' height='300px' valign='top'>"

		dat += "<h2>[make_font_cool("ADMIN")]</h2>"

		dat += "<b>Adminhelp Sounds:</b> <a href='byond://?_src_=prefs;preference=hear_adminhelps'>[(toggles & SOUND_ADMINHELP)?"Enabled":"Disabled"]</a><br>"
		dat += "<b>Prayer Sounds:</b> <a href = 'byond://?_src_=prefs;preference=hear_prayers'>[(toggles & SOUND_PRAYERS)?"Enabled":"Disabled"]</a><br>"
		dat += "<b>Announce Login:</b> <a href='byond://?_src_=prefs;preference=announce_login'>[(toggles & ANNOUNCE_LOGIN)?"Enabled":"Disabled"]</a><br>"
		dat += "<br>"
		dat += "<b>Combo HUD Lighting:</b> <a href = 'byond://?_src_=prefs;preference=combohud_lighting'>[(toggles & COMBOHUD_LIGHTING)?"Full-bright":"No Change"]</a><br>"
		dat += "<br>"
		dat += "<b>Hide Dead Chat:</b> <a href = 'byond://?_src_=prefs;preference=toggle_dead_chat'>[(chat_toggles & CHAT_DEAD)?"Shown":"Hidden"]</a><br>"
		dat += "<b>Hide Radio Messages:</b> <a href = 'byond://?_src_=prefs;preference=toggle_radio_chatter'>[(chat_toggles & CHAT_RADIO)?"Shown":"Hidden"]</a><br>"
		dat += "<b>Hide Prayers:</b> <a href = 'byond://?_src_=prefs;preference=toggle_prayers'>[(chat_toggles & CHAT_PRAYER)?"Shown":"Hidden"]</a><br>"
		dat += "<b>Ignore Being Summoned as Cult Ghost:</b> <a href = 'byond://?_src_=prefs;preference=toggle_ignore_cult_ghost'>[(toggles & ADMIN_IGNORE_CULT_GHOST)?"Don't Allow Being Summoned":"Allow Being Summoned"]</a><br>"
		if(CONFIG_GET(flag/allow_admin_asaycolor))
			dat += "<br>"
			dat += "<b>ASAY Color:</b> <span style='border: 1px solid #161616; background-color: [asaycolor ? asaycolor : "#FF4500"];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=asaycolor;task=input'>Change</a><br>"

		//deadmin
		dat += "<h2>[make_font_cool("DEADMIN")]</h2>"
		var/timegate = CONFIG_GET(number/auto_deadmin_timegate)
		if(timegate)
			dat += "<b>Noted roles will automatically deadmin during the first [FLOOR(timegate / 600, 1)] minutes of the round, and will defer to individual preferences after.</b><br>"

		if(CONFIG_GET(flag/auto_deadmin_players) && !timegate)
			dat += "<b>Always Deadmin:</b> FORCED</a><br>"
		else
			dat += "<b>Always Deadmin:</b> [timegate ? "(Time Locked) " : ""]<a href = 'byond://?_src_=prefs;preference=toggle_deadmin_always'>[(toggles & DEADMIN_ALWAYS)?"Enabled":"Disabled"]</a><br>"
			if(!(toggles & DEADMIN_ALWAYS))
				dat += "<br>"
				if(!CONFIG_GET(flag/auto_deadmin_antagonists) || (CONFIG_GET(flag/auto_deadmin_antagonists) && !timegate))
					dat += "<b>As Antag:</b> [timegate ? "(Time Locked) " : ""]<a href = 'byond://?_src_=prefs;preference=toggle_deadmin_antag'>[(toggles & DEADMIN_ANTAGONIST)?"Deadmin":"Keep Admin"]</a><br>"
				else
					dat += "<b>As Antag:</b> FORCED<br>"

				if(!CONFIG_GET(flag/auto_deadmin_heads) || (CONFIG_GET(flag/auto_deadmin_heads) && !timegate))
					dat += "<b>As Command:</b> [timegate ? "(Time Locked) " : ""]<a href = 'byond://?_src_=prefs;preference=toggle_deadmin_head'>[(toggles & DEADMIN_POSITION_HEAD)?"Deadmin":"Keep Admin"]</a><br>"
				else
					dat += "<b>As Command:</b> FORCED<br>"

				if(!CONFIG_GET(flag/auto_deadmin_security) || (CONFIG_GET(flag/auto_deadmin_security) && !timegate))
					dat += "<b>As Security:</b> [timegate ? "(Time Locked) " : ""]<a href = 'byond://?_src_=prefs;preference=toggle_deadmin_security'>[(toggles & DEADMIN_POSITION_SECURITY)?"Deadmin":"Keep Admin"]</a><br>"
				else
					dat += "<b>As Security:</b> FORCED<br>"

				if(!CONFIG_GET(flag/auto_deadmin_silicons) || (CONFIG_GET(flag/auto_deadmin_silicons) && !timegate))
					dat += "<b>As Silicon:</b> [timegate ? "(Time Locked) " : ""]<a href = 'byond://?_src_=prefs;preference=toggle_deadmin_silicon'>[(toggles & DEADMIN_POSITION_SILICON)?"Deadmin":"Keep Admin"]</a><br>"
				else
					dat += "<b>As Silicon:</b> FORCED<br>"

		dat += "</td>"
	dat += "</tr></table>"