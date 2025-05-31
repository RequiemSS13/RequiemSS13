/datum/merit_setting
	var/name = "default"
	var/abstract_type = /datum/merit_setting
	var/parent_merit

/datum/merit_setting/proc/populate(mob/user, datum/preferences/prefs, datum/merit/merit_to_populate)
	var/value = populate_preset_custom_value(user, prefs)

	if(!value || !merit_to_populate)
		return

	if(!merit_to_populate.custom_settings)
		merit_to_populate.custom_settings = list()
	
	merit_to_populate.custom_settings[src.name] = value

/datum/merit_setting/proc/populate_preset_custom_value(mob/user, datum/preferences/prefs, force_new = FALSE)
	if(!user || !prefs || !prefs.merit_custom_settings)
		return
	var/preset_value = prefs.merit_custom_settings[name]
	if(!preset_value || force_new)
		preset_value = populate_new_custom_value(user)
		if(preset_value)
			prefs.merit_custom_settings[name] = preset_value
	return preset_value

/datum/merit_setting/proc/populate_new_custom_value(mob/user)
	return FALSE


/datum/merit_setting/proc/depopulate(datum/preferences/prefs)
	if(!prefs)
		return
	prefs.merit_custom_settings -= name