/datum/character_connection
	var/id
	var/group_id
	var/group_type
	var/member_type
	var/player_ckey
	var/character_name
	var/connection_desc
	var/round_id_established
	var/date_established
	var/date_ended
	var/hidden

/datum/character_connection/New(id, group_id, group_type, member_type, player_ckey, character_name, connection_desc, round_id_established, date_established, date_ended, hidden = 0)
	src.id = id
	src.group_id = group_id
	src.group_type = group_type
	src.member_type = member_type
	src.player_ckey = player_ckey
	src.character_name = character_name
	src.connection_desc = connection_desc
	src.round_id_established = round_id_established
	src.date_established = date_established
	src.date_ended = date_ended
	src.hidden = hidden