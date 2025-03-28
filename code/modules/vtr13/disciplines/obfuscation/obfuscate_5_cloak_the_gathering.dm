/datum/discipline_power/vtr/obfuscate/cloak_the_gathering
	name = "Cloak the Gathering"
	desc = "Bring some friends under your umbrella of darkness."

	target_type = TARGET_LIVING|TARGET_SELF
	cooldown_length = 8 SECONDS
	var/players_left = 0
	var/players_left_refresh_amount = 3
	range = 3
	level = 5
	bothers_with_duration_timers = FALSE
	grouped_powers = list(
		/datum/discipline_power/vtr/obfuscate/cloak_of_night,
		/datum/discipline_power/vtr/obfuscate/unseen_presence,
		/datum/discipline_power/vtr/obfuscate/familiar_stranger,
		/datum/discipline_power/vtr/obfuscate/face_in_the_crowd,
		/datum/discipline_power/vtr/obfuscate/cloak_the_gathering
	)

	var/cloaked_persons = 0
	var/max_cloaked_persons = 5

	aggressive_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ATTACKED_HAND,
		COMSIG_MOB_MELEE_SWING,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_THREW_MOVABLE,
		COMSIG_MOB_ATTACKING_MELEE,
		COMSIG_MOB_ATTACKED_BY_MELEE,
		COMSIG_MOB_LIVING_POINTED
	)

/datum/discipline_power/vtr/obfuscate/cloak_the_gathering/can_activate_untargeted(alert = FALSE)
	. = ..()
	if(cloaked_persons >= max_cloaked_persons)
		if(alert)
			to_chat(owner, span_warning("You have reached the max number of things you can cloak!"))
		return FALSE


/datum/discipline_power/vtr/obfuscate/cloak_the_gathering/activate(mob/living/target)
	. = ..()
	RegisterSignal(target, aggressive_signals, PROC_REF(gathering_on_combat_signal), override = TRUE)
	RegisterSignal(target, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))
	RegisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE, PROC_REF(prevent_other_powers))

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == target)
			NPC.danger_source = null
	
	target.invisibility = OBFUSCATE_LEVEL_2

	cloaked_persons += 1

/datum/discipline_power/vtr/obfuscate/cloak_the_gathering/proc/trigger_off(mob/living/culprit)
	if(culprit.mind)
		to_chat(culprit, span_danger("Your Obfuscate falls away as you reveal yourself!"))
	
	playsound(get_turf(culprit), 'code/modules/wod13/sounds/obfuscate_deactivate.ogg', 100, TRUE, -6)

	UnregisterSignal(culprit, aggressive_signals)
	UnregisterSignal(culprit, COMSIG_MOVABLE_MOVED)
	culprit.invisibility = 0
	cloaked_persons -= 1


/datum/discipline_power/vtr/obfuscate/cloak_the_gathering/spend_resources()
	if(players_left)
		players_left--
		return TRUE
	else if (owner.bloodpool >= 1)
		players_left = players_left_refresh_amount
		owner.bloodpool = owner.bloodpool - 1
		owner.update_action_buttons()
		return TRUE
	else
		return FALSE

/datum/discipline_power/vtr/obfuscate/cloak_the_gathering/proc/gathering_on_combat_signal(mob/living/culprit)
	SIGNAL_HANDLER
	trigger_off(culprit)


/datum/discipline_power/vtr/obfuscate/cloak_the_gathering/proc/handle_move(mob/living/mover, atom/OldLoc, dir, Forced = FALSE)
	SIGNAL_HANDLER
	trigger_off(mover)
