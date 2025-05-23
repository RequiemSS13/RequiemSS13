/datum/preferences/proc/process_loadout_links(mob/user, list/href_list)

	if(href_list["preference"] != "loadout")
		CRASH("process_loadout_links called when preferences href not set to loadout!")
	
	switch(href_list["task"])
		if("clear_loadout")
			if(tgui_alert(user, "Are you sure you want to reset your loadout?", "Confirmation", list("Yes", "No")) == "Yes")
				equipped_gear.Cut()
		if("toggle_loadout")
			show_loadout = !show_loadout
		if("select_category")
			gear_tab = href_list["gear_category"]
			if(!gear_tab)
				gear_tab = "General"
			return FALSE
		if("add_gear")
			if(loadout_slots >= loadout_slots_max)
				return FALSE
			var/datum/gear/new_gear = SSloadout.gear_datums[href_list["gear"]]
			if(!new_gear)
				return FALSE
			if(new_gear.cost > loadout_dots)
				return FALSE

			equipped_gear += href_list["gear"]

		if("remove_gear")
			equipped_gear -= href_list["gear"]
	return TRUE