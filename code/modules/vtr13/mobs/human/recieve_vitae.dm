/mob/living/carbon/human/recieve_vitae(mob/living/carbon/human/giver)
	if(!giver)
		return

	if(!client)
		to_chat(giver, "<span class='warning'>You need [src]'s attention to do that!</span>")
		return

	if(stat == DEAD && (!iskindred(src) || HAS_TRAIT(src, TRAIT_HALF_DAMNED_CURSE)))
		handle_embrace(giver)
		return

	if(HAS_TRAIT(giver, TRAIT_HALF_DAMNED_CURSE))
		to_chat(giver, span_notice("[src] does not respond to your vitae.</span>"))
		return

	to_chat(giver, span_notice("You successfuly fed [giver] with vitae."))
	if(iskindred(src))
		to_chat(src, "<span class='userlove'>As you fill yourself with second-hand life, your Beast sings out a sickly, cannibalistic note.</span>")
	else
		to_chat(src, "<span class='userlove'>Your eyes dialate and your heart races as you drink. For a moment, you feel twice as alive.")

	if(giver.reagents && length(giver.reagents.reagent_list))
		giver.reagents.trans_to(src, min(10, giver.reagents.total_volume), transfered_by = giver, methods = VAMPIRE)

	adjustBruteLoss(-10, TRUE)
	adjustFireLoss(-5, TRUE)
	blood_volume = min(BLOOD_VOLUME_NORMAL, blood_volume+50)
	adjustBloodPool(1)

	if (iskindred(src) && HAS_TRAIT(src, TRAIT_TORPOR))
		var/datum/species/kindred/species = dna.species
		if (COOLDOWN_FINISHED(species, torpor_timer))
			untorpor()

	var/blood_bond_result = 0

	//apply the blood bond to the database
	if(mind)
		blood_bond_result = SScharacter_connection.add_connection(CONNECTION_BLOOD_BOND, src, giver)
		if(blood_bond_result == 3 && mind.enslaved_to != giver)
			mind.enslave_mind_to_creator(giver)
		if(blood_bond_result >= 2 && has_status_effect(STATUS_EFFECT_INLOVE))
			remove_status_effect(STATUS_EFFECT_INLOVE)
			apply_status_effect(STATUS_EFFECT_INLOVE, giver)

	//handle ghouling
	if(!isghoul(src) && !iskindred(src) && tgui_alert(giver, "Do you wish to turn [src] into a ghoul?.", "Confirmation", list("Yes", "No")) == "Yes")
		handle_ghouling(giver)

	if(isghoul(src) && blood_bond_result > 1)
		var/datum/species/ghoul/G = dna.species
		G.last_vitae = world.time

	update_auspex_hud_vtr()
