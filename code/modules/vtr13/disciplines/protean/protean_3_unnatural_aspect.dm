/datum/discipline_power/vtr/protean/unnatural_aspect
	name = "Unnatural Aspect"
	desc = "Take on an unnatural adaptation."
	level = 3

	check_flags = DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	toggled = TRUE
	duration_length = 15 SECONDS
	cooldown_length = 15 SECONDS

	var/datum/adaptation/unnatural/adaptation

/datum/discipline_power/vtr/protean/unnatural_aspect/pre_activation_check_no_spend()
	if(adaptation)
		return TRUE
	
	var/selection = tgui_input_list(
		owner, 
		"Select an unnatural adaptation - choosing will lock you into this choice for the round!", 
		"Select an Adaptation:", 
		SSprotean_adaptation.adaptations_unnatural, 
		null)
	if(selection)
		var/adaptation_type = SSprotean_adaptation.adaptations_unnatural[selection]
		adaptation = new adaptation_type(owner)
	return FALSE

/datum/discipline_power/vtr/protean/unnatural_aspect/activate()
	. = ..()
	adaptation.activate(owner)

/datum/discipline_power/vtr/protean/unnatural_aspect/deactivate()
	. = ..()
	adaptation.deactivate(owner)