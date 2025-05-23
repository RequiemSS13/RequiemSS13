/datum/action/unpossess
	name = "Unpossess"
	desc = "Unpossess the current creature."
	background_icon_state = "discipline"
	button_icon_state = "hivemind"
	var/datum/discipline_power/vtr/animalism/possess/possess_datum

/datum/action/unpossess/New(Target, datum/discipline_power/vtr/animalism/possess/possess_discipline)
	..(Target)
	possess_datum = possess_discipline

/datum/action/unpossess/Trigger()
	possess_datum.deactivate()