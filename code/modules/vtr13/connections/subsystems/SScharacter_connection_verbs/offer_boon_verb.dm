/datum/controller/subsystem/character_connection/verb/offer_boon()
	set name = "Offer Boon"
	set category = "Connections"

	if(!istype(src, /mob/living/carbon/human))
		CRASH("Offer boon called from a non living mob.")

	var/mob/living/carbon/human/human_src = src

	if(human_src.has_status_effect(STATUS_EFFECT_REQUEST_CONNECTION))
		return

	var/choice = tgui_input_list(human_src, "Select a boon to offer:", "Boon Selection", SScharacter_connection.boon_connection_list)
	if(!choice)
		return
	
	human_src.apply_status_effect(STATUS_EFFECT_REQUEST_CONNECTION, choice, TRUE)