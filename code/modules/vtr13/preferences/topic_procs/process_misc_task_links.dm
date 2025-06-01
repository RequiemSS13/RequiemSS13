/datum/preferences/proc/process_misc_task_links(mob/user, list/href_list)

	if(href_list["task"] == "input" || href_list["task"] == "random")
		CRASH("process_tasks_other called on topic with incorrect task type!")

	switch(href_list["preference"])
		if("gender")
			var/list/friendlyGenders = list("Masculine (He/Him)" = "male", "Feminine (She/Her)" = "female", "Other (They/Them)" = "plural")
			var/pickedGender = tgui_input_list(user, "Choose your gender.", "Character Preference", friendlyGenders, gender)
			if(pickedGender && friendlyGenders[pickedGender] != gender)
				gender = friendlyGenders[pickedGender]
				underwear = random_underwear(gender)
				undershirt = random_undershirt(gender)
				socks = random_socks()
				facial_hairstyle = random_facial_hairstyle(gender)
				hairstyle = random_hairstyle(gender)
		if("body_type")
			if(body_type == MALE)
				body_type = FEMALE
			else
				body_type = MALE
		if("hotkeys")
			hotkeys = !hotkeys
			if(hotkeys)
				winset(user, null, "input.focus=true input.background-color=[COLOR_INPUT_ENABLED]")
			else
				winset(user, null, "input.focus=true input.background-color=[COLOR_INPUT_DISABLED]")

		if("keybindings_capture")
			var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
			var/old_key = href_list["old_key"]
			CaptureKeybinding(user, kb, old_key)
			return

		if("keybindings_set")
			var/kb_name = href_list["keybinding"]
			if(!kb_name)
				user << browse(null, "window=capturekeypress")
				ShowChoices(user)
				return

			var/clear_key = text2num(href_list["clear_key"])
			var/old_key = href_list["old_key"]
			if(clear_key)
				if(key_bindings[old_key])
					key_bindings[old_key] -= kb_name
					LAZYADD(key_bindings["Unbound"], kb_name)
					if(!length(key_bindings[old_key]))
						key_bindings -= old_key
				user << browse(null, "window=capturekeypress")
				user.client.set_macros()
				user.client.update_special_keybinds()
				save_preferences()
				ShowChoices(user)
				return

			var/new_key = uppertext(href_list["key"])
			var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
			var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
			var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
			var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
			// var/key_code = text2num(href_list["key_code"])

			if(GLOB._kbMap[new_key])
				new_key = GLOB._kbMap[new_key]

			var/full_key
			switch(new_key)
				if("Alt")
					full_key = "[new_key][CtrlMod][ShiftMod]"
				if("Ctrl")
					full_key = "[AltMod][new_key][ShiftMod]"
				if("Shift")
					full_key = "[AltMod][CtrlMod][new_key]"
				else
					full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
			if(kb_name in key_bindings[full_key]) //We pressed the same key combination that was already bound here, so let's remove to re-add and re-sort.
				key_bindings[full_key] -= kb_name
			if(key_bindings[old_key])
				key_bindings[old_key] -= kb_name
				if(!length(key_bindings[old_key]))
					key_bindings -= old_key
			key_bindings[full_key] += list(kb_name)
			key_bindings[full_key] = sortList(key_bindings[full_key])

			user << browse(null, "window=capturekeypress")
			user.client.set_macros()
			user.client.update_special_keybinds()
			save_preferences()

		if("keybindings_reset")
			var/choice = tgui_alert(user, "Would you prefer 'hotkey' or 'classic' defaults?", "Setup keybindings", list("Hotkey", "Classic", "Cancel"))
			if(choice == "Cancel")
				ShowChoices(user)
				return
			hotkeys = (choice == "Hotkey")
			key_bindings = (hotkeys) ? deepCopyList(GLOB.hotkey_keybinding_list_by_key) : deepCopyList(GLOB.classic_keybinding_list_by_key)
			user.client.set_macros()
			user.client.update_special_keybinds()

		if("chat_on_map")
			chat_on_map = !chat_on_map
		if("see_chat_non_mob")
			see_chat_non_mob = !see_chat_non_mob
		if("see_rc_emotes")
			see_rc_emotes = !see_rc_emotes

		if("action_buttons")
			buttons_locked = !buttons_locked
		if("tgui_fancy")
			tgui_fancy = !tgui_fancy
		if("tgui_input_mode")
			tgui_input_mode = !tgui_input_mode
		if("tgui_large_buttons")
			tgui_large_buttons = !tgui_large_buttons
		if("tgui_swapped_buttons")
			tgui_swapped_buttons = !tgui_swapped_buttons
		if("tgui_lock")
			tgui_lock = !tgui_lock
		if("winflash")
			windowflashing = !windowflashing

		//here lies the badmins
		if("hear_adminhelps")
			user.client.toggleadminhelpsound()
		if("hear_prayers")
			user.client.toggle_prayer_sound()
		if("announce_login")
			user.client.toggleannouncelogin()
		if("combohud_lighting")
			toggles ^= COMBOHUD_LIGHTING
		if("toggle_dead_chat")
			user.client.deadchat()
		if("toggle_radio_chatter")
			user.client.toggle_hear_radio()
		if("toggle_prayers")
			user.client.toggleprayers()
		if("toggle_deadmin_always")
			toggles ^= DEADMIN_ALWAYS
		if("toggle_deadmin_antag")
			toggles ^= DEADMIN_ANTAGONIST
		if("toggle_deadmin_head")
			toggles ^= DEADMIN_POSITION_HEAD
		if("toggle_deadmin_security")
			toggles ^= DEADMIN_POSITION_SECURITY
		if("toggle_deadmin_silicon")
			toggles ^= DEADMIN_POSITION_SILICON
		if("toggle_ignore_cult_ghost")
			toggles ^= ADMIN_IGNORE_CULT_GHOST


		if("be_special")
			var/be_special_type = href_list["be_special_type"]
			if(be_special_type in be_special)
				be_special -= be_special_type
			else
				be_special += be_special_type

		if("toggle_random")
			var/random_type = href_list["random_type"]
			if(randomise[random_type])
				randomise -= random_type
			else
				randomise[random_type] = TRUE

		if("persistent_scars")
			persistent_scars = !persistent_scars

		if("clear_scars")
			var/path = "data/player_saves/[user.ckey[1]]/[user.ckey]/scars.sav"
			fdel(path)
			to_chat(user, "<span class='notice'>All scar slots cleared.</span>")

		if("hear_midis")
			toggles ^= SOUND_MIDI

		if("lobby_music")
			toggles ^= SOUND_LOBBY
			if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
				user.client.playtitlemusic()
			else
				user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

		if("endofround_sounds")
			toggles ^= SOUND_ENDOFROUND

		if("ghost_ears")
			if(istype(user.client.mob, /mob/dead/observer))
				var/mob/dead/observer/obs = user.client.mob
				if(obs.auspex_ghosted)
					return
				else
					chat_toggles ^= CHAT_GHOSTEARS
			else
				chat_toggles ^= CHAT_GHOSTEARS

		if("ghost_sight")
			chat_toggles ^= CHAT_GHOSTSIGHT

		if("ghost_whispers")
			if(istype(user.client.mob, /mob/dead/observer))
				var/mob/dead/observer/obs = user.client.mob
				if(obs.auspex_ghosted)
					return
				else
					chat_toggles ^= CHAT_GHOSTWHISPER
			else
				chat_toggles ^= CHAT_GHOSTWHISPER

		if("ghost_radio")

			chat_toggles ^= CHAT_GHOSTRADIO

		if("ghost_pda")
			chat_toggles ^= CHAT_GHOSTPDA

		if("ghost_laws")
			chat_toggles ^= CHAT_GHOSTLAWS

		if("hear_login_logout")
			chat_toggles ^= CHAT_LOGIN_LOGOUT

		if("broadcast_login_logout")
			broadcast_login_logout = !broadcast_login_logout

		if("income_pings")
			chat_toggles ^= CHAT_BANKCARD

		if("pull_requests")
			chat_toggles ^= CHAT_PULLR

		if("allow_midround_antag")
			toggles ^= MIDROUND_ANTAG

		if("parallaxup")
			parallax = WRAP(parallax + 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
			if (parent?.mob.hud_used)
				parent.mob.hud_used.update_parallax_pref(parent.mob)

		if("parallaxdown")
			parallax = WRAP(parallax - 1, PARALLAX_INSANE, PARALLAX_DISABLE + 1)
			if (parent?.mob.hud_used)
				parent.mob.hud_used.update_parallax_pref(parent.mob)

		if("ambientocclusion")
			ambientocclusion = !ambientocclusion
			if(length(parent?.screen))
				var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in parent.screen
				PM.backdrop(parent.mob)

		if("auto_fit_viewport")
			auto_fit_viewport = !auto_fit_viewport
			if(auto_fit_viewport && parent)
				parent.fit_viewport()


		if("widescreenpref")
			widescreenpref = !widescreenpref
			user.client.view_size.setDefault(getScreenSize(widescreenpref))

		if("pixel_size")
			switch(pixel_size)
				if(PIXEL_SCALING_AUTO)
					pixel_size = PIXEL_SCALING_1X
				if(PIXEL_SCALING_1X)
					pixel_size = PIXEL_SCALING_1_2X
				if(PIXEL_SCALING_1_2X)
					pixel_size = PIXEL_SCALING_2X
				if(PIXEL_SCALING_2X)
					pixel_size = PIXEL_SCALING_3X
				if(PIXEL_SCALING_3X)
					pixel_size = PIXEL_SCALING_AUTO
			user.client.view_size.apply() //Let's winset() it so it actually works

		if("scaling_method")
			switch(scaling_method)
				if(SCALING_METHOD_NORMAL)
					scaling_method = SCALING_METHOD_DISTORT
				if(SCALING_METHOD_DISTORT)
					scaling_method = SCALING_METHOD_BLUR
				if(SCALING_METHOD_BLUR)
					scaling_method = SCALING_METHOD_NORMAL
			user.client.view_size.setZoomMode()

		if("save")
			save_preferences()
			save_character()

		if("load")
			load_preferences()
			load_character()

		if("reset_all")
			if (tgui_alert(user, "Are you sure you want to reset your character? This will retire your character connections!", "Confirmation", list("Yes", "No")) != "Yes")
				return
			reset_character()
			SScharacter_connection.update_retire_all_character_connections(parent, parent.ckey, real_name)
			character_connections = null

		if("changeslot")
			if(merit_sub_tab==PREFS_BANES_SUB_TAB)
				merit_sub_tab = PREFS_MERITS_SUB_TAB
			
			if(!load_character(text2num(href_list["num"])))
				reset_character()

		if("tab")
			if (href_list["tab"])
				current_tab = text2num(href_list["tab"])
				if(current_tab == PREFS_LOADOUT_TAB)
					show_loadout = TRUE
			else if (href_list["merit_tab"])
				merit_sub_tab = text2num(href_list["merit_tab"])

		if("clear_heart")
			hearted = FALSE
			hearted_until = null
			to_chat(user, "<span class='notice'>OOC Commendation Heart disabled</span>")
			save_preferences()
	return TRUE