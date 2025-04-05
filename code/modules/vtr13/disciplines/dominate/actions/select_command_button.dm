/datum/action/select_command_button
	name = "Command Compulsion Selection"
	desc = "Pick a compulsion to say with Dominate 4."
	background_icon_state = "discipline"
	button_icon_state = "dominate"
	var/datum/discipline_power/vtr/dominate/command/command_discipline

/datum/action/select_command_button/New(Target, datum/discipline_power/vtr/dominate/command/command_datum)
	..(Target)
	command_discipline = command_datum

/datum/action/select_command_button/Trigger()
	var/selection = tgui_input_list(owner, "Select a compulsion for Command:", "Command Selection", SSdominate_compulsion.command_list, command_discipline.selected_command)
	if(selection)
		command_discipline.selected_command = SSdominate_compulsion.command_list[selection]