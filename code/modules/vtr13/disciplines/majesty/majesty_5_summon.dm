/datum/discipline_power/vtr/majesty/summon
	name = "Summon"
	desc = "Call to the blood of another and compel them to come to you via the invocation of their True Name."
	level = 5
	cooldown_length = 1 MINUTES
	duration_length = 30 MINUTES
	var/power_in_use = FALSE
	var/charmed_status_debuff = 2
	var/spoken_name

/datum/discipline_power/vtr/majesty/summon/pre_activation_check_no_spend(atom/target)
	if(power_in_use)
		to_chat(owner, span_warning("You are already attempting to use this power!"))
		return FALSE

	power_in_use = TRUE
	var/spoken_name = tgui_input_text(owner, "Speak a true name (must be exact)", "Majesty 5")
	power_in_use = FALSE

	if(!spoken_name)
		to_chat(owner, span_warning("You think better of summoning someone against their will."))
		return FALSE

	return TRUE

/datum/discipline_power/vtr/majesty/summon/activate()
	. = ..()
	var/current_name = spoken_name
	spoken_name = null
	var/mob/living/victim

	for(var/mob/living/player in GLOB.player_list)
		if(player.true_real_name && player.true_real_name == spoken_name)
			victim = player
			break

	if(!victim)
		to_chat(owner, span_warning("Your leash does not find its collar; either the name is incorrect, or they are not in the area."))
	
	if(!SSroll.opposed_roll(
		owner,
		victim,
		dice_a = owner.get_total_social() + discipline.level,
		dice_b = victim.get_total_social() + victim.get_total_blood() - HAS_TRAIT_FROM(victim, TRAIT_CHARMED, owner) ? charmed_status_debuff : 0, 
		alert_atom = owner,
		show_player_a = TRUE,
		show_player_b = FALSE))
		to_chat(owner, span_warning("The tether breaks, their will overpowering you."))
		if(victim.mind)
			to_chat(victim, span_danger("An unknown force pulls at you, but you resist the temptation, for now."))
		return
	
	var/turf/destination_turf = get_turf(owner)
	var/turf/current_turf = get_turf(owner)

	victim.add_client_colour(/datum/client_colour/glass_colour/darkred)
	ADD_TRAIT(victim, TRAIT_MUTE, MAJESTY_5_TRAIT)
	to_chat(victim, span_userdanger("You are called to the [destination_turf.loc]."))

