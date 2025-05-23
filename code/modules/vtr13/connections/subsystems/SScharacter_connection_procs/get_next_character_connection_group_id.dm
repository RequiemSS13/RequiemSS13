//Gets the next increment in the character connection group id list, as it doesn't follow auto-increment rules
/datum/controller/subsystem/character_connection/proc/get_next_character_connection_group_id()
	var/datum/db_query/query = SSdbcore.NewQuery(
		"SELECT MAX(group_id) FROM [format_table_name("character_connection")]")
	if(!query.Execute(async = TRUE))
		qdel(query)
		return null
	var/group_id = 1
	if(query.NextRow())
		group_id = query.item[1] + 1
	qdel(query)
	return group_id
