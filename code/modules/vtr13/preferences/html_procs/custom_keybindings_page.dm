/datum/preferences/proc/custom_keybindings_page(mob/user, list/dat)
	// Create an inverted list of keybindings -> key
	var/list/user_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)

	var/list/kb_categories = list()
	// Group keybinds by category
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		kb_categories[kb.category] += list(kb)

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

	for (var/category in kb_categories)
		dat += "<h3>[category]</h3>"
		for (var/i in kb_categories[category])
			var/datum/keybinding/kb = i
			if(!length(user_binds[kb.name]) || user_binds[kb.name][1] == "Unbound")
				dat += "<label>[kb.full_name]</label> <a href ='byond://?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
				var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
				if(LAZYLEN(default_keys))
					dat += "| Default: [default_keys.Join(", ")]"
				dat += "<br>"
			else
				var/bound_key = user_binds[kb.name][1]
				dat += "<label>[kb.full_name]</label> <a href ='byond://?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				for(var/bound_key_index in 2 to length(user_binds[kb.name]))
					bound_key = user_binds[kb.name][bound_key_index]
					dat += " | <a href ='byond://?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
					dat += "| <a href ='byond://?_src_=prefs;preference=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
				var/list/default_keys = hotkeys ? kb.classic_keys : kb.hotkey_keys
				if(LAZYLEN(default_keys))
					dat += "| Default: [default_keys.Join(", ")]"
				dat += "<br>"

	dat += "<br><br>"
	dat += "<a href ='byond://?_src_=prefs;preference=keybindings_reset'>\[Reset to default\]</a>"
	dat += "</body>"