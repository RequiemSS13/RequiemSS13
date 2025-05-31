/datum/merit/expertise
	name = "Expertise"
	desc = "You are extaordinarily capable in one stat."
	dots = 2
	custom_setting_required = TRUE
	custom_setting_types = "expertise_stat"

/datum/merit/expertise/post_add()
	var/stat = custom_settings["expertise_stat"]
	switch(stat)
		if("Wits")
			merit_holder.add_wits_mod(1, "EXPERTISE")
		if("Resolve")
			merit_holder.add_resolve_mod(1, "EXPERTISE")
		if("Physique")
			merit_holder.add_physique_mod(1, "EXPERTISE")
		if("Stamina")
			merit_holder.add_stamina_mod(1, "EXPERTISE")
		if("Charisma")
			merit_holder.add_charisma_mod(1, "EXPERTISE")
		if("Composure")
			merit_holder.add_composure_mod(1, "EXPERTISE")


/datum/merit/expertise/remove()
	var/stat = custom_settings["expertise_stat"]
	switch(stat)
		if("Wits")
			merit_holder.remove_wits_mod("EXPERTISE")
		if("Resolve")
			merit_holder.remove_resolve_mod("EXPERTISE")
		if("Physique")
			merit_holder.remove_physique_mod("EXPERTISE")
		if("Stamina")
			merit_holder.remove_stamina_mod("EXPERTISE")
		if("Charisma")
			merit_holder.remove_charisma_mod("EXPERTISE")
		if("Composure")
			merit_holder.remove_composure_mod("EXPERTISE")