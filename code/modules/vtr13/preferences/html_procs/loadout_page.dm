/datum/preferences/proc/loadout_page(mob/user, list/dat)
	dat += "<center><h2>[make_font_cool("LOADOUT")]</h2></center>"

	calculate_loadout_dots()
	dat += "<table align='center' width='100%'>"
	dat += "<tr><td colspan=5><b><center>Slots Used: [loadout_slots]/[loadout_slots_max].<br>"
	dat += "Remaining Dots: [loadout_dots]/[loadout_dots_max].<br>"
	dat += "<a href='?_src_=prefs;preference=gear;task=clear_loadout;'>Clear Loadout</a> | <a href='?_src_=prefs;preference=gear;task=toggle_loadout;'>Toggle Loadout</a></center></b></td></tr>"
	dat += "<tr><td colspan=5><center><b>"

	var/firstcat = 1
	for(var/category in SSloadout.loadout_categories)
		if(firstcat)
			firstcat = 0
		else
			dat += " |"
		if(category == gear_tab)
			dat += " <span class='linkOff'>[category]</span> "
		else
			dat += " <a href='?_src_=prefs;preference=loadout;task=select_category;gear_category=[category]'>[category]</a> "
	dat += "</b></center></td></tr>"

	var/datum/loadout_category/loadout_category = SSloadout.loadout_categories[gear_tab]
	dat += "<tr><td colspan=5><hr></td></tr>"
	dat += "<tr><td colspan=5><b><center>[loadout_category.category]</center></b></td></tr>"
	dat += "<tr><td colspan=5><hr></td></tr>"
	dat += "<tr>"
	dat += "<td></td>"
	dat += "<td><b><center>Count</b><center></td>"
	dat += "<td><b><center>Name</b><center></td>"
	dat += "<td></td>"
	dat += "<td><b><center>Description</b><center></td></tr>"
	dat += "<tr><td colspan=5><hr></td></tr>"
	var/i = 1
	for(var/gear_name in loadout_category.gear)
		var/datum/gear/category_gear = loadout_category.gear[gear_name]
		var/equipped = src.equipped_gear.Find(category_gear.display_name)
		var/equipped_count = 0
		if(equipped)
			for(var/equipped_gear_name in src.equipped_gear)
				if(category_gear.display_name == equipped_gear_name)
					equipped_count += 1
			dat += "<tr style='vertical-align:top; background-color:rgba(0, 125, 0, 0.2);'>"
		else if( (i % 2) == 0)
			dat += "<tr style='vertical-align:top; background-color:rgba(128, 128, 128, 0.2);'>"
		else
			dat += "<tr style='vertical-align:top; background-color:rgba(64, 64, 64, 0.2);'>"
		i++
		dat += "<td width=5%><p style='vertical-align: middle;'><center>"
		if(!category_gear.cost)
			dat += "<font size=5>○</font>"
		else
			for (var/y in 1 to category_gear.cost)
				dat += "<font size=5>●</font>"
		dat += "</center></p></td>"
		dat += "<td width=5%><p style='vertical-align: middle;'><center><b>(</b> [equipped_count] <b>)</b></center><p></td>"
		dat += "<td width=25%><p style='vertical-align: middle;'><center>[category_gear.display_name]</p></center></td>"
		dat += "<td width=15%><p style='vertical-align: middle;'><center>"
		if((loadout_slots < loadout_slots_max) && (category_gear.cost <= loadout_dots))
			dat += "<a style='white-space:normal;' href='?_src_=prefs;preference=loadout;task=add_gear;gear=[category_gear.display_name]'>Add</a>"
			if(equipped)
				dat += " - "
		if(equipped)
			dat += "<a style='white-space:normal;' href='?_src_=prefs;preference=loadout;task=remove_gear;gear=[category_gear.display_name]'>Remove</a>"
		dat += "</center></p></td>"
		dat += "<td><p style='vertical-align: middle;'><font size=2><i>[category_gear.description]"
		if(category_gear.allowed_roles && length(category_gear.allowed_roles))
			dat += " - [english_list(category_gear.allowed_roles, null, ", ")]"
		dat += "</i></font></p></td></tr>"
	dat += "</table>"