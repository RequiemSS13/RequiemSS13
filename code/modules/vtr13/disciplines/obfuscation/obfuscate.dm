
/datum/discipline/vtr/obfuscate
	name = "Obfuscate"
	desc = "Makes you less noticable for living and un-living beings."
	icon_state = "obfuscate"
	power_type = /datum/discipline_power/vtr/obfuscate

/datum/discipline_power/vtr/obfuscate
	name = "Obfuscate power name"
	desc = "Obfuscate power description"

	activate_sound = 'code/modules/wod13/sounds/obfuscate_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/obfuscate_deactivate.ogg'
	cooldown_length = 8 SECONDS
	var/list/aggressive_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ATTACKED_HAND,
		COMSIG_MOB_MELEE_SWING,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_THREW_MOVABLE,
		COMSIG_MOB_ATTACKING_MELEE,
		COMSIG_MOB_ATTACKED_BY_MELEE,
		COMSIG_MOB_LIVING_POINTED,
		COMSIG_MOB_SAY,
		COMSIG_PROJECTILE_PREHIT
	)

/datum/discipline_power/vtr/obfuscate/proc/get_obfuscate_level()
	switch(discipline.level)
		if(2)
			return OBFUSCATE_LEVEL_2
		if(3)
			return OBFUSCATE_LEVEL_3
		if(4)
			return OBFUSCATE_LEVEL_4
		if(5)
			return OBFUSCATE_LEVEL_5
	return 0

/datum/discipline_power/vtr/obfuscate/proc/on_combat_signal(datum/source)
	SIGNAL_HANDLER

	to_chat(owner, span_danger("Your Obfuscate falls away as you reveal yourself!"))
	try_deactivate()
