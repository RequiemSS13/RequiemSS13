/datum/discipline_power/vtr/protean/predatory_aspect
	name = "Predatory Aspect"
	desc = "Alter your form to adapt to the situation. You may pick one aspect per round."

	level = 1

	check_flags = DISC_CHECK_CAPABLE
	
	violates_masquerade = TRUE

	toggled = TRUE
	duration_length = 15 SECONDS
	cooldown_length = 15 SECONDS
	var/datum/adaptation/predatory/adaptation

/datum/discipline_power/vtr/protean/predatory_aspect/pre_activation_check_no_spend()
	if(adaptation)
		return TRUE

	var/selection = tgui_input_list(
		owner, 
		"Select a predatory adaptation - choosing will lock you into this choice for the round!", 
		"Select an Adaptation:", 
		SSprotean_adaptation.adaptations_predatory, 
		null)
	if(selection)
		var/adaptation_type = SSprotean_adaptation.adaptations_predatory[selection]
		adaptation = new adaptation_type(owner)
	return FALSE

/datum/discipline_power/vtr/protean/predatory_aspect/activate()
	. = ..()
	adaptation.activate(owner)

/datum/discipline_power/vtr/protean/predatory_aspect/deactivate()
	. = ..()
	adaptation.deactivate(owner)