/datum/discipline_power/vtr/obfuscate/unseen_presence
	name = "Unseen Presence"
	desc = "Meld into the shadows and stay unnoticed so long as you stay still and draw no attention."

	level = 2

	check_flags = DISC_CHECK_CAPABLE
	cooldown_length = 20 SECONDS
	duration_override = TRUE

	cancelable = TRUE

	grouped_powers = list(
		/datum/discipline_power/vtr/obfuscate/cloak_of_night,
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
	owner.invisibility = get_obfuscate_level()

/datum/discipline_power/vtr/obfuscate/unseen_presence/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
	owner.invisibility = 0

/datum/discipline_power/vtr/obfuscate/unseen_presence/proc/handle_move(mob/living/mover, atom/OldLoc, dir, Forced = FALSE)
	SIGNAL_HANDLER
	to_chat(owner, span_danger("Your Obfuscate falls away as you move!"))
	try_deactivate(direct = TRUE)
