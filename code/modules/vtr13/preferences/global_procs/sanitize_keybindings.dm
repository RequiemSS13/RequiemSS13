/proc/sanitize_keybindings(value)
	var/list/base_bindings = sanitize_islist(value,list())
	for(var/key in base_bindings)
		base_bindings[key] = base_bindings[key] & GLOB.keybindings_by_name
		if(!length(base_bindings[key]))
			base_bindings -= key
	return base_bindings