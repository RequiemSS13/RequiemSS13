
/datum/preferences/proc/ShowChoices(mob/user)
	if(!SSatoms.initialized)
		to_chat(user, span_warning("Please wait for the game to do a little more setup first...!"))
		return
	if(!user?.client) // Without a client in control, you can't do anything.
		return
	if(slot_randomized)
		load_character(default_slot) // Reloads the character slot. Prevents random features from overwriting the slot if saved.
		slot_randomized = FALSE
	
	show_loadout = (current_tab == PREFS_LOADOUT_TAB) ? show_loadout : FALSE
	update_preview_icon(show_loadout)
	var/list/dat = list()

	if(path)
		var/savefile/S = new /savefile(path)
		if(S)
			dat += "<center>"
			var/name
			var/unspaced_slots = 0
			for(var/i=1, i<=max_save_slots, i++)
				unspaced_slots++
				if(unspaced_slots > 10)
					dat += "<br>"
					unspaced_slots = 0
				S.cd = "/character[i]"
				S["real_name"] >> name
				if(!name)
					name = "Character[i]"
				if(istype(user, /mob/dead/new_player))
					dat += "<a style='white-space:nowrap;' href='byond://?_src_=prefs;preference=changeslot;num=[i];' [i == default_slot ? "class='linkOn'" : ""]>[name]</a> "
			dat += "</center><hr>"
	else
		dat += "<div class='notice'>Please create an account to save your preferences</div>"

	dat += "<center>"
	if(istype(user, /mob/dead/new_player))
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_CHARACTER_SETTINGS_TAB]' [current_tab == PREFS_CHARACTER_SETTINGS_TAB ? "class='linkOn'" : ""]>[make_font_cool("CHARACTER SETTINGS")]</a> "
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_MERITS_TAB]' [current_tab == PREFS_MERITS_TAB ? "class='linkOn'" : ""]>[make_font_cool("MERITS & FLAWS")]</a> "
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_ATTRIBUTES_TAB]' [current_tab ==PREFS_ATTRIBUTES_TAB  ? "class='linkOn'" : ""]>[make_font_cool("ATTRIBUTES")]</a> "
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_LOADOUT_TAB]' [current_tab == PREFS_LOADOUT_TAB ? "class='linkOn'" : ""]>[make_font_cool("LOADOUT")]</a> "
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_CONNECTIONS_TAB]' [current_tab == PREFS_CONNECTIONS_TAB ? "class='linkOn'" : ""]>[make_font_cool("CONNECTIONS")]</a> "
		dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_OCCUPATION_TAB]' [current_tab == PREFS_OCCUPATION_TAB ? "class='linkOn'" : ""]>[make_font_cool("OCCUPATION")]</a>"
		dat += "<br>"
	else if(current_tab < PREFS_GAME_PREFERENCES_TAB)
		current_tab = PREFS_GAME_PREFERENCES_TAB
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_GAME_PREFERENCES_TAB]' [current_tab == PREFS_GAME_PREFERENCES_TAB ? "class='linkOn'" : ""]>[make_font_cool("GAME PREFERENCES")]</a> "
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_OOC_PREFERENCES_TAB]' [current_tab == PREFS_OOC_PREFERENCES_TAB ? "class='linkOn'" : ""]>[make_font_cool("OOC PREFERENCES")]</a> "
	dat += "<a href='byond://?_src_=prefs;preference=tab;tab=[PREFS_KEYBINDINGS_TAB]' [current_tab == PREFS_KEYBINDINGS_TAB ? "class='linkOn'" : ""]>[make_font_cool("CUSTOM KEYBINDINGS")]</a>"
	dat += "</center>"

	dat += "<HR>"

	switch(current_tab)
		if (1)
			character_settings_page(user, dat)
		if (2)
			merit_page(user, dat)
		if (3)
			attributes_page(user, dat)
		if (4)
			loadout_page(user, dat)
		if (5)
			connections_page(user, dat)
		if (6)
			occupation_page(user, dat)
		if (7)
			game_preferences_page(user, dat)
		if(8)
			ooc_preferences_page(user, dat)
		if(9)
			custom_keybindings_page(user, dat)
	dat += "<hr><center>"

	if(!IsGuestKey(user.key))
		dat += "<a href='byond://?_src_=prefs;preference=load'>Undo</a> "
		dat += "<a href='byond://?_src_=prefs;preference=save'>Save Character</a> "

	if(istype(user, /mob/dead/new_player))
		dat += "<a href='byond://?_src_=prefs;preference=reset_all'>Reset Setup</a>"
	dat += "</center>"

	winshow(user, "preferences_window", TRUE)
	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>[make_font_cool("CHARACTER")]</div>", 640, 770)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	onclose(user, "preferences_window", src)