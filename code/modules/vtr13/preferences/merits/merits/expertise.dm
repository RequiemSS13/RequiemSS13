/datum/merit/expertise
	name = "Expertise"
	desc = "You are extaordinarily capable in one stat."
	dots = 2
	custom_setting_required = TRUE
	custom_setting_types = "expertise_stat"

/datum/merit/expertise/post_add()
	var/stat = custom_settings["expertise_stat"]
	switch(stat)
		if("wits")
			ADD_TRAIT(merit_holder, TRAIT_EXPERTISE_WITS, ROUNDSTART_TRAIT)
		if("resolve")
			ADD_TRAIT(merit_holder, TRAIT_EXPERTISE_RESOLVE, ROUNDSTART_TRAIT)
		if("physique")
			ADD_TRAIT(merit_holder, TRAIT_EXPERTISE_PHYSIQUE, ROUNDSTART_TRAIT)
		if("stamina")
			ADD_TRAIT(merit_holder, TRAIT_EXPERTISE_STAMINA, ROUNDSTART_TRAIT)
		if("charisma")
			ADD_TRAIT(merit_holder, TRAIT_EXPERTISE_CHARISMA, ROUNDSTART_TRAIT)
		if("composure")
			ADD_TRAIT(merit_holder, TRAIT_EXPERTISE_COMPOSURE, ROUNDSTART_TRAIT)


/datum/merit/expertise/remove()
	var/stat = custom_settings["expertise_stat"]
	switch(stat)
		if("wits")
			REMOVE_TRAIT(merit_holder, TRAIT_EXPERTISE_WITS, ROUNDSTART_TRAIT)
		if("resolve")
			REMOVE_TRAIT(merit_holder, TRAIT_EXPERTISE_RESOLVE, ROUNDSTART_TRAIT)
		if("physique")
			REMOVE_TRAIT(merit_holder, TRAIT_EXPERTISE_PHYSIQUE, ROUNDSTART_TRAIT)
		if("stamina")
			REMOVE_TRAIT(merit_holder, TRAIT_EXPERTISE_STAMINA, ROUNDSTART_TRAIT)
		if("charisma")
			REMOVE_TRAIT(merit_holder, TRAIT_EXPERTISE_CHARISMA, ROUNDSTART_TRAIT)
		if("composure")
			REMOVE_TRAIT(merit_holder, TRAIT_EXPERTISE_COMPOSURE, ROUNDSTART_TRAIT)