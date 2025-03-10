/datum/discipline_power/vtr/obfuscate/cloak_of_night
	name = "Cloak of Night"
	desc = "Move among the crowds without ever being noticed. Achieve invisibility."

	level = 3

	check_flags = DISC_CHECK_CAPABLE

	duration_override = TRUE

	grouped_powers = list(
		/datum/discipline_power/vtr/obfuscate/cloak_of_shadows,
		/datum/discipline_power/vtr/obfuscate/unseen_presence,
		/datum/discipline_power/vtr/obfuscate/familiar_stranger,
		/datum/discipline_power/vtr/obfuscate/face_in_the_crowd,
		/datum/discipline_power/vtr/obfuscate/cloak_the_gathering
	)

/datum/discipline_power/vtr/obfuscate/unseen_presence/activate()
	. = ..()
	RegisterSignal(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(handle_move))

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	owner.alpha = 10

/datum/discipline_power/vtr/obfuscate/unseen_presence/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.alpha = 255

/datum/discipline_power/vtr/obfuscate/unseen_presence/proc/handle_move(datum/source, atom/moving_thing, dir)
	SIGNAL_HANDLER

	if (owner.m_intent != MOVE_INTENT_WALK)
		try_deactivate(direct = TRUE)