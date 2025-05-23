/datum/preferences/proc/game_preferences_page(mob/user, list/dat)
	dat += "<table><tr><td width='340px' height='300px' valign='top'>"
	dat += "<h2>[make_font_cool("GENERAL")]</h2>"
	dat += "<b>UI Style:</b> <a href='byond://?_src_=prefs;task=input;preference=ui'>[UI_style]</a><br>"
	dat += "<b>tgui Window Mode:</b> <a href='byond://?_src_=prefs;preference=tgui_fancy'>[(tgui_fancy) ? "Fancy (default)" : "Compatible (slower)"]</a><br>"
	dat += "<b>Input Framework:</b> <a href='byond://?_src_=prefs;preference=tgui_input_mode'>[(tgui_input_mode) ? "tgui" : "BYOND"]</a><br>"
	dat += "<b>tgui Button Size:</b> <a href='byond://?_src_=prefs;preference=tgui_large_buttons'>[(tgui_large_buttons) ? "Large" : "Small"]</a><br>"
	dat += "<b>tgui Buttons Swapped:</b> <a href='byond://?_src_=prefs;preference=tgui_swapped_buttons'>[(tgui_swapped_buttons) ? "Yes" : "No"]</a><br>"
	dat += "<b>tgui Window Placement:</b> <a href='byond://?_src_=prefs;preference=tgui_lock'>[(tgui_lock) ? "Primary monitor" : "Free (default)"]</a><br>"
	dat += "<b>Show Runechat Chat Bubbles:</b> <a href='byond://?_src_=prefs;preference=chat_on_map'>[chat_on_map ? "Enabled" : "Disabled"]</a><br>"
	dat += "<b>Runechat message char limit:</b> <a href='byond://?_src_=prefs;preference=max_chat_length;task=input'>[max_chat_length]</a><br>"
	dat += "<b>See Runechat for non-mobs:</b> <a href='byond://?_src_=prefs;preference=see_chat_non_mob'>[see_chat_non_mob ? "Enabled" : "Disabled"]</a><br>"
	dat += "<b>See Runechat emotes:</b> <a href='byond://?_src_=prefs;preference=see_rc_emotes'>[see_rc_emotes ? "Enabled" : "Disabled"]</a><br>"
	dat += "<br>"
	dat += "<b>Action Buttons:</b> <a href='byond://?_src_=prefs;preference=action_buttons'>[(buttons_locked) ? "Locked In Place" : "Unlocked"]</a><br>"
	dat += "<b>Hotkey mode:</b> <a href='byond://?_src_=prefs;preference=hotkeys'>[(hotkeys) ? "Hotkeys" : "Default"]</a><br>"
	dat += "<br>"
	dat += "<b>PDA Color:</b> <span style='border:1px solid #161616; background-color: [pda_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=pda_color;task=input'>Change</a><BR>"
	dat += "<b>PDA Style:</b> <a href='byond://?_src_=prefs;task=input;preference=pda_style'>[pda_style]</a><br>"
	dat += "<br>"
	dat += "<b>Ghost Ears:</b> <a href='byond://?_src_=prefs;preference=ghost_ears'>[(chat_toggles & CHAT_GHOSTEARS) ? "All Speech" : "Nearest Creatures"]</a><br>"
	dat += "<b>Ghost Radio:</b> <a href='byond://?_src_=prefs;preference=ghost_radio'>[(chat_toggles & CHAT_GHOSTRADIO) ? "All Messages":"No Messages"]</a><br>"
	dat += "<b>Ghost Sight:</b> <a href='byond://?_src_=prefs;preference=ghost_sight'>[(chat_toggles & CHAT_GHOSTSIGHT) ? "All Emotes" : "Nearest Creatures"]</a><br>"
	dat += "<b>Ghost Whispers:</b> <a href='byond://?_src_=prefs;preference=ghost_whispers'>[(chat_toggles & CHAT_GHOSTWHISPER) ? "All Speech" : "Nearest Creatures"]</a><br>"
	dat += "<b>Ghost PDA:</b> <a href='byond://?_src_=prefs;preference=ghost_pda'>[(chat_toggles & CHAT_GHOSTPDA) ? "All Messages" : "Nearest Creatures"]</a><br>"
	dat += "<b>Ghost Law Changes:</b> <a href='byond://?_src_=prefs;preference=ghost_laws'>[(chat_toggles & CHAT_GHOSTLAWS) ? "All Law Changes" : "No Law Changes"]</a><br>"
	dat += "<b>Ghost Form:</b> <a href='byond://?_src_=prefs;task=input;preference=ghostform'>[ghost_form]</a><br>"
	dat += "<B>Ghost Orbit: </B> <a href='byond://?_src_=prefs;task=input;preference=ghostorbit'>[ghost_orbit]</a><br>"

	var/button_name = "If you see this something went wrong."
	switch(ghost_accs)
		if(GHOST_ACCS_FULL)
			button_name = GHOST_ACCS_FULL_NAME
		if(GHOST_ACCS_DIR)
			button_name = GHOST_ACCS_DIR_NAME
		if(GHOST_ACCS_NONE)
			button_name = GHOST_ACCS_NONE_NAME

	dat += "<b>Ghost Accessories:</b> <a href='byond://?_src_=prefs;task=input;preference=ghostaccs'>[button_name]</a><br>"

	switch(ghost_others)
		if(GHOST_OTHERS_THEIR_SETTING)
			button_name = GHOST_OTHERS_THEIR_SETTING_NAME
		if(GHOST_OTHERS_DEFAULT_SPRITE)
			button_name = GHOST_OTHERS_DEFAULT_SPRITE_NAME
		if(GHOST_OTHERS_SIMPLE)
			button_name = GHOST_OTHERS_SIMPLE_NAME

	dat += "<b>Ghosts of Others:</b> <a href='byond://?_src_=prefs;task=input;preference=ghostothers'>[button_name]</a><br>"
	dat += "<br>"

	dat += "<b>Broadcast Login/Logout:</b> <a href='byond://?_src_=prefs;preference=broadcast_login_logout'>[broadcast_login_logout ? "Broadcast" : "Silent"]</a><br>"
	dat += "<b>See Login/Logout Messages:</b> <a href='byond://?_src_=prefs;preference=hear_login_logout'>[(chat_toggles & CHAT_LOGIN_LOGOUT) ? "Allowed" : "Muted"]</a><br>"
	dat += "<br>"

	dat += "<b>Income Updates:</b> <a href='byond://?_src_=prefs;preference=income_pings'>[(chat_toggles & CHAT_BANKCARD) ? "Allowed" : "Muted"]</a><br>"
	dat += "<br>"

	dat += "<b>FPS:</b> <a href='byond://?_src_=prefs;preference=clientfps;task=input'>[clientfps]</a><br>"

	dat += "<b>Parallax (Fancy Space):</b> <a href='?_src_=prefs;preference=parallaxdown' oncontextmenu='window.location.href=\"?_src_=prefs;preference=parallaxup\";return false;'>"
	switch (parallax)
		if (PARALLAX_LOW)
			dat += "Low"
		if (PARALLAX_MED)
			dat += "Medium"
		if (PARALLAX_INSANE)
			dat += "Insane"
		if (PARALLAX_DISABLE)
			dat += "Disabled"
		else
			dat += "High"
	dat += "</a><br>"
	dat += "<b>Ambient Occlusion:</b> <a href='byond://?_src_=prefs;preference=ambientocclusion'>[ambientocclusion ? "Enabled" : "Disabled"]</a><br>"
	dat += "<b>Fit Viewport:</b> <a href='byond://?_src_=prefs;preference=auto_fit_viewport'>[auto_fit_viewport ? "Auto" : "Manual"]</a><br>"
	if (CONFIG_GET(string/default_view) != CONFIG_GET(string/default_view_square))
		dat += "<b>Widescreen:</b> <a href='byond://?_src_=prefs;preference=widescreenpref'>[widescreenpref ? "Enabled ([CONFIG_GET(string/default_view)])" : "Disabled ([CONFIG_GET(string/default_view_square)])"]</a><br>"

	button_name = pixel_size
	dat += "<b>Pixel Scaling:</b> <a href='byond://?_src_=prefs;preference=pixel_size'>[(button_name) ? "Pixel Perfect [button_name]x" : "Stretch to fit"]</a><br>"

	switch(scaling_method)
		if(SCALING_METHOD_DISTORT)
			button_name = "Nearest Neighbor"
		if(SCALING_METHOD_NORMAL)
			button_name = "Point Sampling"
		if(SCALING_METHOD_BLUR)
			button_name = "Bilinear"
	dat += "<b>Scaling Method:</b> <a href='byond://?_src_=prefs;preference=scaling_method'>[button_name]</a><br>"

	if (CONFIG_GET(flag/maprotation))
		var/p_map = preferred_map
		if (!p_map)
			p_map = "Default"
			if (config.defaultmap)
				p_map += " ([config.defaultmap.map_name])"
		else
			if (p_map in config.maplist)
				var/datum/map_config/VM = config.maplist[p_map]
				if (!VM)
					p_map += " (No longer exists)"
				else
					p_map = VM.map_name
			else
				p_map += " (No longer exists)"
		if(CONFIG_GET(flag/preference_map_voting))
			dat += "<b>Preferred Map:</b> <a href='byond://?_src_=prefs;preference=preferred_map;task=input'>[p_map]</a><br>"
