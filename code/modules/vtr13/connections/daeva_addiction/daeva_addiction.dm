/datum/character_connection_type/daeva_addiction
	name = CONNECTION_DAEVA_ADDITION

/datum/character_connection_type/daeva_addiction/attempt_connection_add(mob/living/daeva, mob/living/victim)

	//this only happens with humans
	if(!ishumanbasic(victim))
		return 0

	if(!victim || !victim.mind)
		return 0

	if(!HAS_TRAIT(daeva, TRAIT_WANTON_CURSE))
		return 0

	if(!daeva || !daeva.mind)
		return 0

	if(!daeva.true_real_name || !victim.true_real_name)
		return 0

	if(!iskindred(daeva))
		to_chat(daeva, "<span class='warning'>You are not a vampire????</span>")
		return 0

	//is the Daeva already addicted?
	var/datum/character_connection/existing_addiction = SScharacter_connection.get_existing_daeva_addiction(victim, daeva)

	//you can't be even more addicted than stage 2
	if(existing_addiction?.group_type == CONNECTION_DAEVA_ADDITION_2)
		return 0

	var/group_type = CONNECTION_DAEVA_ADDITION_1
	if(existing_addiction)
		//resist addiction
		if(SSroll.storyteller_roll(
			dice = daeva.humanity,
			difficulty = 3,
			mobs_to_show_output = list(daeva),
			alert_atom = victim) >= 3)
			return 0
		to_chat(daeva, "<span class='userlove'>As you drink, the Wanton Curse has its due. You become deeply obsessed with [victim].</span>")
		SScharacter_connection.update_retire_character_connection_by_group_id(existing_addiction.group_id)
		group_type = CONNECTION_DAEVA_ADDITION_2
	
	var/daeva_connection_desc = ""
	var/victim_connection_desc = ""
	var/hidden = FALSE
	var/return_val = 1
	switch(group_type)
		if(CONNECTION_DAEVA_ADDITION_1)
			daeva_connection_desc = "You have drank from [victim.true_real_name] once."
			victim_connection_desc = "[daeva.true_real_name] has drank your blood once."
			hidden = TRUE
		if(CONNECTION_DAEVA_ADDITION_2)
			daeva_connection_desc = "You are obsessed with [victim.true_real_name]."
			victim_connection_desc = "[daeva.true_real_name] is obsessed with you."
			return_val = 2

	//insert victim connection
	var/new_group_id = SScharacter_connection.insert_character_connection(victim, group_type, MEMBER_TYPE_DAEVA_VICTIM, victim_connection_desc, null, hidden)

	//insert daeva connection
	SScharacter_connection.insert_character_connection(daeva, group_type, MEMBER_TYPE_DAEVA_VAMPIRE, daeva_connection_desc, new_group_id, hidden)

	return return_val

