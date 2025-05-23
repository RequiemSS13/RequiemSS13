/datum/controller/subsystem/character_connection/proc/insert_character_connection(mob/living/target, group_type, member_type, connection_desc, group_id = null)
	var/our_group_id = group_id
	if(!our_group_id)
		our_group_id = get_next_character_connection_group_id()


	if(!group_type || !member_type || !connection_desc || !our_group_id)
		log_admin("Can't add connection because something is missing")
		return

	var/datum/db_query/query = SSdbcore.NewQuery({"
			INSERT INTO [format_table_name("character_connection")] (`group_id`, `group_type`, `member_type`, `player_ckey`, `character_name`, `connection_desc`, `round_id_established`, `date_established`)
			VALUES (:group_id, :group_type, :member_type, :ckey, :char_name, :connection_desc, :round_id, Now())
		"}, list(
			"group_id" = our_group_id, 
			"group_type" = group_type, 
			"member_type" = member_type, 
			"ckey" = target.ckey, 
			"char_name" = target.true_real_name, 
			"connection_desc" = connection_desc, 
			"round_id" = GLOB.round_id)
	)
	if(!query.Execute())
		qdel(query)
		return null

	qdel(query)
	return our_group_id
