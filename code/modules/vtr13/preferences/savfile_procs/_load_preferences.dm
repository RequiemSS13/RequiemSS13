/datum/preferences/proc/load_preferences()
	if(!path)
		return FALSE
	if(!fexists(path))
		return FALSE

	var/savefile/S = new /savefile(path)
	if(!S)
		return FALSE
	S.cd = "/"

	var/needs_update = savefile_needs_update(S)
	if(needs_update == -2)		//fatal, can't load any data
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		return FALSE

	//general preferences
	READ_FILE(S["default_slot"], default_slot)
	READ_FILE(S["asaycolor"], asaycolor)
	READ_FILE(S["ooccolor"], ooccolor)
	READ_FILE(S["lastchangelog"], lastchangelog)
	READ_FILE(S["UI_style"], UI_style)
	READ_FILE(S["hotkeys"], hotkeys)
	READ_FILE(S["chat_on_map"], chat_on_map)
	READ_FILE(S["max_chat_length"], max_chat_length)
	READ_FILE(S["see_chat_non_mob"], see_chat_non_mob)
	READ_FILE(S["see_rc_emotes"], see_rc_emotes)
	READ_FILE(S["broadcast_login_logout"], broadcast_login_logout)
	READ_FILE(S["tgui_fancy"], tgui_fancy)
	READ_FILE(S["tgui_input_mode"], tgui_input_mode)
	READ_FILE(S["tgui_large_buttons"], tgui_large_buttons)
	READ_FILE(S["tgui_swapped_buttons"], tgui_swapped_buttons)
	READ_FILE(S["tgui_lock"], tgui_lock)
	READ_FILE(S["buttons_locked"], buttons_locked)
	READ_FILE(S["windowflash"], windowflashing)
	READ_FILE(S["be_special"], be_special)
	READ_FILE(S["chat_toggles"], chat_toggles)
	READ_FILE(S["toggles"], toggles)
	READ_FILE(S["ghost_form"], ghost_form)
	READ_FILE(S["ghost_orbit"], ghost_orbit)
	READ_FILE(S["ghost_accs"], ghost_accs)
	READ_FILE(S["ghost_others"], ghost_others)
	READ_FILE(S["ghost_hud"], ghost_hud)
	READ_FILE(S["inquisitive_ghost"], inquisitive_ghost)
	READ_FILE(S["preferred_map"], preferred_map)
	READ_FILE(S["ignoring"], ignoring)
	READ_FILE(S["uses_glasses_colour"], uses_glasses_colour)
	READ_FILE(S["clientfps"], clientfps)
	READ_FILE(S["parallax"], parallax)
	READ_FILE(S["ambientocclusion"], ambientocclusion)
	READ_FILE(S["auto_fit_viewport"], auto_fit_viewport)
	READ_FILE(S["widescreenpref"], widescreenpref)
	READ_FILE(S["pixel_size"], pixel_size)
	READ_FILE(S["scaling_method"], scaling_method)
	READ_FILE(S["menuoptions"], menuoptions)
	READ_FILE(S["enable_tips"], enable_tips)
	READ_FILE(S["tip_delay"], tip_delay)
	READ_FILE(S["pda_style"], pda_style)
	READ_FILE(S["pda_color"], pda_color)

	// Custom hotkeys
	READ_FILE(S["key_bindings"], key_bindings)
	check_keybindings()
	// hearted
	READ_FILE(S["hearted_until"], hearted_until)
	if(hearted_until > world.realtime)
		hearted = TRUE

	//try to fix any outdated data if necessary
	if(needs_update >= 0)
		var/bacpath = "[path].updatebac" //todo: if the savefile version is higher then the server, check the backup, and give the player a prompt to load the backup
		if (fexists(bacpath))
			fdel(bacpath) //only keep 1 version of backup
		fcopy(S, bacpath) //byond helpfully lets you use a savefile for the first arg.
		update_preferences(needs_update, S)		//needs_update = savefile_version if we need an update (positive integer)



	//Sanitize
	asaycolor = sanitize_ooccolor(sanitize_hexcolor(asaycolor, 6, 1, initial(asaycolor)))
	ooccolor = sanitize_ooccolor(sanitize_hexcolor(ooccolor, 6, 1, initial(ooccolor)))
	lastchangelog = sanitize_text(lastchangelog, initial(lastchangelog))
	UI_style = sanitize_inlist(UI_style, GLOB.available_ui_styles, GLOB.available_ui_styles[1])
	hotkeys = sanitize_integer(hotkeys, FALSE, TRUE, initial(hotkeys))
	chat_on_map = sanitize_integer(chat_on_map, FALSE, TRUE, initial(chat_on_map))
	max_chat_length = sanitize_integer(max_chat_length, 1, CHAT_MESSAGE_MAX_LENGTH, initial(max_chat_length))
	see_chat_non_mob = sanitize_integer(see_chat_non_mob, FALSE, TRUE, initial(see_chat_non_mob))
	see_rc_emotes = sanitize_integer(see_rc_emotes, FALSE, TRUE, initial(see_rc_emotes))
	broadcast_login_logout = sanitize_integer(broadcast_login_logout, FALSE, TRUE, initial(broadcast_login_logout))
	tgui_fancy = sanitize_integer(tgui_fancy, FALSE, TRUE, initial(tgui_fancy))
	tgui_input_mode = sanitize_integer(tgui_input_mode, 0, 1, initial(tgui_input_mode))
	tgui_large_buttons = sanitize_integer(tgui_large_buttons, 0, 1, initial(tgui_large_buttons))
	tgui_swapped_buttons = sanitize_integer(tgui_swapped_buttons, 0, 1, initial(tgui_swapped_buttons))
	tgui_lock = sanitize_integer(tgui_lock, FALSE, TRUE, initial(tgui_lock))
	buttons_locked = sanitize_integer(buttons_locked, FALSE, TRUE, initial(buttons_locked))
	windowflashing = sanitize_integer(windowflashing, FALSE, TRUE, initial(windowflashing))
	default_slot = sanitize_integer(default_slot, 1, max_save_slots, initial(default_slot))
	toggles = sanitize_integer(toggles, 0, (2**24)-1, initial(toggles))
	clientfps = sanitize_integer(clientfps, -1, 1000, 0)
	parallax = sanitize_integer(parallax, PARALLAX_INSANE, PARALLAX_DISABLE, null)
	ambientocclusion = sanitize_integer(ambientocclusion, FALSE, TRUE, initial(ambientocclusion))
	auto_fit_viewport = sanitize_integer(auto_fit_viewport, FALSE, TRUE, initial(auto_fit_viewport))
	widescreenpref  = sanitize_integer(widescreenpref, FALSE, TRUE, initial(widescreenpref))
	pixel_size = sanitize_float(pixel_size, PIXEL_SCALING_AUTO, PIXEL_SCALING_3X, 0.5, initial(pixel_size))
	scaling_method  = sanitize_text(scaling_method, initial(scaling_method))
	ghost_form = sanitize_inlist(ghost_form, GLOB.ghost_forms, initial(ghost_form))
	ghost_orbit  = sanitize_inlist(ghost_orbit, GLOB.ghost_orbits, initial(ghost_orbit))
	ghost_accs = sanitize_inlist(ghost_accs, GLOB.ghost_accs_options, GHOST_ACCS_DEFAULT_OPTION)
	ghost_others = sanitize_inlist(ghost_others, GLOB.ghost_others_options, GHOST_OTHERS_DEFAULT_OPTION)
	menuoptions = SANITIZE_LIST(menuoptions)
	be_special = SANITIZE_LIST(be_special)
	pda_style = sanitize_inlist(pda_style, GLOB.pda_styles, initial(pda_style))
	pda_color = sanitize_hexcolor(pda_color, 6, 1, initial(pda_color))
	key_bindings  = sanitize_keybindings(key_bindings)

	if(needs_update >= 0) //save the updated version
		var/old_default_slot = default_slot
		var/old_max_save_slots = max_save_slots

		for (var/slot in S.dir) //but first, update all current character slots.
			if (copytext(slot, 1, 10) != "character")
				continue
			var/slotnum = text2num(copytext(slot, 10))
			if (!slotnum)
				continue
			max_save_slots = max(max_save_slots, slotnum) //so we can still update byond member slots after they lose memeber status
			default_slot = slotnum
			if (load_character())
				save_character()
		default_slot = old_default_slot
		max_save_slots = old_max_save_slots
		save_preferences()

	return TRUE
