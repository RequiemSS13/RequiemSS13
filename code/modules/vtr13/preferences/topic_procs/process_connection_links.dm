/datum/preferences/proc/process_connection_links(mob/user, list/href_list)

	if(href_list["preference"] != "connection")
		CRASH("process_connection_links called when preferences href not set to connection!")

	switch(href_list["task"])
		if("delete_connection")
			SScharacter_connection.retire_connection(user, parent.ckey, src.real_name, text2num(href_list["connection_id"]))
			character_connections = SScharacter_connection.get_character_connections(parent.ckey, src.real_name)

	return TRUE