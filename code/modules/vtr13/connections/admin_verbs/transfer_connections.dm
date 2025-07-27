/client/proc/transfer_connection()
	set name = "Transfer Connections"
	set category = "Admin.Game"
	set desc = "Transfers a character's connections to a new name."

	var/list/all_ckeys = SScharacter_connection.get_all_ckeys_from_players()

	if(!all_ckeys || !length(all_ckeys))
		return

	var/ckey_choice = tgui_input_list(usr, "Choose the ckey of the player whose connections you are transferring", "Ckey Select", all_ckeys)

	if(!ckey_choice)
		return

	var/character_choice = tgui_input_list(usr, "Choose the name of the player whose connections you are transferring.", "Character Select", all_ckeys[ckey_choice])

	if(!character_choice)
		return

	var/new_character_name = tgui_input_text(usr, "Enter a name to transfer these connections to.", "Connection Transfer", character_choice, MAX_NAME_LEN)

	if(!new_character_name)
		return

	SScharacter_connection.update_transfer_character_connections(ckey_choice, character_choice, new_character_name)


	log_admin("[key_name(usr)] has transferred the connections of [ckey_choice] - [character_choice] to [new_character_name]")
	message_admins("[key_name(usr)] has transferred the connections of [ckey_choice] - [character_choice] to [new_character_name]")