/datum/discipline_power/vtr/majesty/summon
	name = "Summon"
	desc = "Call to the blood of another and compel them to come to you via the invocation of their True Name."
	level = 5
	cooldown_length = 1 MINUTES
	var/majesty_duration = 15 MINUTES
	var/power_in_use = FALSE
	var/charmed_status_debuff = 2
	var/spoken_name

/datum/discipline_power/vtr/majesty/summon/pre_activation_check_no_spend(atom/target)
	if(power_in_use)
		to_chat(owner, span_warning("You are already attempting to use this power!"))
		return FALSE

	power_in_use = TRUE
	spoken_name = tgui_input_text(owner, "Speak a true name (must be exact)", "Majesty 5")
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
		if(player.true_real_name && lowertext(player.true_real_name) == lowertext(current_name))
			victim = player
			break

	if(!victim)
		to_chat(owner, span_warning("Your leash does not find its collar; either the name is incorrect, or they are not in the area."))
		return
	var/trait_bonus = (HAS_TRAIT(victim, TRAIT_INDOMITABLE) ? TRAIT_INDOMITABLE_MOD : 0) + (HAS_TRAIT(victim, TRAIT_SUSCEPTIBLE) ? TRAIT_SUSCEPTIBLE_MOD : 0) - (HAS_TRAIT_FROM(victim, TRAIT_CHARMED, owner) ? charmed_status_debuff : 0)
	if(!SSroll.opposed_roll(
		owner,
		victim,
		dice_a = owner.get_charisma() + discipline.level,
		dice_b = victim.get_composure() + victim.get_potency() + trait_bonus, 
		alert_atom = owner,
		show_player_a = TRUE,
		show_player_b = FALSE))
		to_chat(owner, span_warning("The tether breaks, their will overpowering you."))
		if(victim.mind)
			to_chat(victim, span_danger("An unknown force pulls at you, but you resist the temptation, for now."))
		return

	var/turf/destination_turf = get_turf(owner)

	victim.AddComponent(/datum/component/summon_dial, destination_turf, owner, src)

	addtimer(CALLBACK(src, PROC_REF(trigger_summon_end), victim), majesty_duration)

/datum/discipline_power/vtr/majesty/summon/proc/trigger_summon_end(mob/living/victim)
	SEND_SIGNAL(src, COMSIG_MAJESTY_5_END, victim)
