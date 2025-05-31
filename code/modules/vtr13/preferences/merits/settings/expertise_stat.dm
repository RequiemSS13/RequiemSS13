/datum/merit_setting/expertise_stat
	name = "expertise_stat"
	parent_merit = /datum/merit/expertise
	var/stat_options = list("Wits", "Resolve", "Physique", "Stamina", "Charisma", "Composure")

/datum/merit_setting/expertise_stat/populate_new_custom_value(mob/user)
	var/response = tgui_input_list(user, "Choose an area of expertise:", "Custom Merit Settings", stat_options, "Wits")
	if(response)
		return response