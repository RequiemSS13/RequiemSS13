/datum/action/select_compel_button
	name = "Compel Compulsion Selection"
	desc = "Pick a compulsion to say with Dominate 2."
	background_icon_state = "discipline"
	button_icon_state = "malk_speech"
	var/datum/discipline_power/vtr/dominate/compel/compel_discipline

/datum/action/select_compel_button/New(Target, datum/discipline_power/vtr/dominate/compel/compel_datum)
	..(Target)
	compel_discipline = compel_datum

/datum/action/select_compel_button/Trigger()
	var/selection = tgui_input_list(owner, "Select a compulsion for Compel:", "Compel Selection", SSdominate_compulsion.compel_list, compel_discipline.selected_command)
	if(selection)
		compel_discipline.selected_command = SSdominate_compulsion.compel_list[selection]