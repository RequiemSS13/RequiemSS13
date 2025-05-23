/datum/preferences/proc/connections_page(mob/user, list/dat)
	dat += "<center><h2>[make_font_cool("CONNECTIONS")]</h2></center>"

	dat += "<table width=width='70%' cellpadding='5' align='center'>"
	character_connections = SScharacter_connection.get_character_connections(parent.ckey, src.real_name)
	for(var/datum/character_connection/connection in character_connections)
		dat += "<tr><td><b>[connection.connection_desc]</b></td><td><a href='byond://?_src_=prefs;preference=connection;task=delete_connection;connection_id=[connection.group_id];'>Delete</a></td></tr>"
	
	dat += "</table>"