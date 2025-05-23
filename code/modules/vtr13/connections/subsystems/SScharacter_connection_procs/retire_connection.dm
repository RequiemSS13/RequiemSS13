//Retire an existing connection with a prompt to ensure the player is certain.
/datum/controller/subsystem/character_connection/proc/retire_connection(target, ckey, character_name, deleting_group_id)
	if(!deleting_group_id || !target || !ckey || !character_name)
		return FALSE
	
	
	if(tgui_alert(target, "Are you sure you wish to delete this connection?", "Delete Connection", list("I'm Sure", "Cancel")) != "I'm Sure")
		return FALSE

	//sanity_check
	var/found_existing_connection = FALSE
	var/list/existing_connections = get_character_connections(ckey, character_name)
	for(var/datum/character_connection/connection in existing_connections)
		if(connection.group_id != deleting_group_id)
			continue
		found_existing_connection = TRUE
		message_admins("[ADMIN_LOOKUPFLW(target)] has ended their [connection.group_type] connection of group_id [connection.group_id]. (They were a [connection.member_type])")
		log_game("[ckey] has ended their [connection.group_type] connection of group_id [connection.group_id]. (They were a [connection.member_type])")
		SSoverwatch.record_action(usr, "[ckey] has ended their [connection.group_type] connection of group_id [connection.group_id]. (They were a [connection.member_type])")
		break
	qdel(existing_connections)

	if(!found_existing_connection)
		return FALSE

	SScharacter_connection.update_retire_character_connection_by_group_id(deleting_group_id)

	
	if(isliving(target))
		var/mob/living/living_target = target
		if(living_target.mind)
			living_target.mind.character_connections = SScharacter_connection.get_character_connections(ckey, character_name)
	
	if(istype(target, /client))
		var/client/target_client = target
		if(target_client?.prefs)
			target_client.prefs.character_connections = SScharacter_connection.get_character_connections(ckey, character_name)
	
	return TRUE