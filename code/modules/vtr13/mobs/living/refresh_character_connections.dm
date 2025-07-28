/mob/living/proc/refresh_character_connections()
	if(mind)
		src.mind.character_connections = SScharacter_connection.get_character_connections(ckey, real_name)