/mob/living/carbon/human/examine(mob/user)
	var/list/return_list = list()
	if(SEND_SIGNAL(src, COMSIG_HUMAN_EXAMINE_OVERRIDE, user, return_list) & COMPONENT_EXAMINE_CHANGE_RESPONSE)
		return return_list

	return_list.Add("<span class='info'>*---------*")

	var/examine_result = examine_title(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_beast(user)
	examine_result ? return_list.Add(examine_result) : null
	
	examine_result = examine_humanity(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_reputation(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_outfit(user)
	examine_result ? return_list.Add(examine_result) : null
	
	examine_result = examine_status(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_death(user)
	examine_result ? return_list.Add(examine_result) : null
	
	examine_result = examine_health(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_health_no_disguise(user)
	examine_result ? return_list.Add(examine_result) : null

	if(!(stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH))))
		examine_result = examine_drunkenness(user)
		examine_result ? return_list.Add(examine_result) : null

		examine_result = examine_mood(user)
		examine_result ? return_list.Add(examine_result) : null
	
	examine_result = examine_scars(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_spot_masquerade_violation(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_flavortext_window(user)
	examine_result ? return_list.Add(examine_result) : null

	examine_result = examine_hud_info(user)
	examine_result ? return_list.Add(examine_result) : null
	
	return_list.Add("*---------*</span>")

	SEND_SIGNAL(src, COMSIG_PARENT_EXAMINE, user, return_list)
	return return_list
