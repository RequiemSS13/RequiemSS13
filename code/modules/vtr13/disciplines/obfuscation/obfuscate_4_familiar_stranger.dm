/datum/discipline_power/vtr/obfuscate/familiar_stranger
	name = "Familiar Stranger"
	desc = "Adopt the face of some nameless passerby, becoming one of them for a time."

	level = 1

	check_flags = DISC_CHECK_CAPABLE

	cancelable = TRUE
	duration_override = TRUE
	target_type = TARGET_LIVING

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

	aggressive_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ATTACKED_HAND,
		COMSIG_MOB_MELEE_SWING,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_THREW_MOVABLE,
		COMSIG_MOB_ATTACKING_MELEE,
		COMSIG_MOB_ATTACKED_BY_MELEE
	)

	var/original_name

	var/impersonating_name 
	var/impersonating_examine

	var/is_shapeshifted = FALSE

	bothers_with_duration_timers = FALSE

/datum/discipline_power/vtr/obfuscate/familiar_stranger/can_activate(mob/living/carbon/human/target, alert = FALSE)
	. = ..()
	if(!target)
		if(alert)
			to_chat(owner, span_warning("Your must target a humanoid."))
		return FALSE


/datum/discipline_power/vtr/obfuscate/familiar_stranger/can_deactivate(atom/target)
	.=..()
	return TRUE

/datum/discipline_power/vtr/obfuscate/familiar_stranger/activate(mob/living/carbon/human/victim)
	. = ..()
	RegisterSignal(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	
	initialize_original()

	if (!victim)
		return

	playsound(get_turf(owner), 'code/modules/wod13/sounds/obfuscate_activate.ogg', 100, TRUE, -6)
	owner.real_name = victim.real_name

	//feelsgoodman -u-
	var/image/obfuscate_image = image('icons/effects/effects.dmi', owner, "nothing", ABOVE_MOB_LAYER)
	obfuscate_image.appearance = new /mutable_appearance(victim)
	obfuscate_image.override = 1
	owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/everyone, "obfuscate", obfuscate_image)

	owner.disguise_description = victim.examine(owner, TRUE)
	is_shapeshifted = TRUE
	owner.update_body()

/datum/discipline_power/vtr/obfuscate/familiar_stranger/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)

	playsound(get_turf(owner), 'code/modules/wod13/sounds/obfuscate_deactivate.ogg', 100, TRUE, -6)
	owner.remove_alt_appearance("obfuscate")
	owner.real_name = original_name
	owner.disguise_description = null
	is_shapeshifted = FALSE

/datum/discipline_power/vtr/obfuscate/familiar_stranger/proc/initialize_original()
	if (is_shapeshifted)
		return
	if (original_name)
		return
	original_name = owner.real_name	