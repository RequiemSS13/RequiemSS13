/datum/discipline_power/vtr/obfuscate/familiar_stranger
	name = "Familiar Stranger"
	desc = "Adopt the face of some nameless passerby, becoming one of them for a time."

	level = 1

	check_flags = DISC_CHECK_CAPABLE

	cancelable = TRUE
	duration_override = TRUE
	target_type = TARGET_HUMAN

	range = 7

	grouped_powers = list(
		/datum/discipline_power/vtr/obfuscate/cloak_of_night,
		/datum/discipline_power/vtr/obfuscate/unseen_presence,
		/datum/discipline_power/vtr/obfuscate/familiar_stranger,
		/datum/discipline_power/vtr/obfuscate/face_in_the_crowd,
		/datum/discipline_power/vtr/obfuscate/cloak_the_gathering
	)


	activate_sound = null
	deactivate_sound = null

	cooldown_length = 20 SECONDS

	bothers_with_duration_timers = FALSE


/datum/discipline_power/vtr/obfuscate/familiar_stranger/can_deactivate(atom/target)
	.=..()
	return TRUE

/datum/discipline_power/vtr/obfuscate/familiar_stranger/activate(mob/living/carbon/human/victim)
	. = ..()

	if (!victim)
		return
	playsound(get_turf(owner), 'code/modules/wod13/sounds/obfuscate_activate.ogg', 100, TRUE, -6)
	owner.AddComponent(/datum/component/disguise, victim, src)

/datum/discipline_power/vtr/obfuscate/familiar_stranger/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)