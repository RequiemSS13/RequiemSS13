/datum/discipline_power/vtr/obfuscate/familiar_stranger
	name = "Face in the Crowd"
	desc = "Adopt the face of some nameless passerby, becoming one of them for a time."

	level = 1

	check_flags = DISC_CHECK_CAPABLE

	cooldown_length = 10 SECONDS

	duration_override = TRUE

	grouped_powers = list(
		/datum/discipline_power/vtr/obfuscate/cloak_of_shadows,
		/datum/discipline_power/vtr/obfuscate/unseen_presence,
		/datum/discipline_power/vtr/obfuscate/familiar_stranger,
		/datum/discipline_power/vtr/obfuscate/face_in_the_crowd,
		/datum/discipline_power/vtr/obfuscate/cloak_the_gathering
	)

	activate_sound = null
	deactivate_sound = null

	aggressive_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ATTACKED_HAND,
		COMSIG_MOB_MELEE_SWING,
		COMSIG_MOB_FIRED_GUN,
		COMSIG_MOB_THREW_MOVABLE,
		COMSIG_MOB_ATTACKING_MELEE,
		COMSIG_MOB_ATTACKED_BY_MELEE
	)


	//why is this necessary why isn't transfer_identity working please fix this
	var/datum/dna/original_dna
	var/original_name
	var/original_skintone
	var/original_hairstyle
	var/original_facialhair
	var/original_haircolor
	var/original_facialhaircolor
	var/original_eyecolor
	var/original_body_mod
	var/original_alt_sprite
	var/original_alt_sprite_greyscale

	var/datum/dna/impersonating_dna
	var/impersonating_name
	var/impersonating_skintone
	var/impersonating_hairstyle
	var/impersonating_facialhair
	var/impersonating_haircolor
	var/impersonating_facialhaircolor
	var/impersonating_eyecolor
	var/impersonating_body_mod
	var/impersonating_alt_sprite
	var/impersonating_alt_sprite_greyscale

	var/is_shapeshifted = FALSE



/datum/discipline_power/vtr/obfuscate/familiar_stranger/activate()
	. = ..()
	RegisterSignal(owner, aggressive_signals, PROC_REF(on_combat_signal), override = TRUE)

	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if (NPC.danger_source == owner)
			NPC.danger_source = null
	
	choose_impersonating()

/datum/discipline_power/vtr/obfuscate/familiar_stranger/deactivate()
	. = ..()
	UnregisterSignal(owner, aggressive_signals)
	shapeshift(to_original = TRUE)

/datum/discipline_power/vtr/obfuscate/familiar_stranger/proc/choose_impersonating()
	initialize_original()

	var/list/mob/living/carbon/human/potential_victims = list()
	for (var/mob/living/carbon/human/adding_victim in oviewers(7, owner))
		potential_victims += adding_victim
	if (!length(potential_victims))
		to_chat(owner, span_warning("No one is close enough for you to examine..."))
		return
	var/mob/living/carbon/human/victim = tgui_input_list(owner, "Who do you wish to impersonate?", "Targets:", potential_victims)

	if (!victim)
		return

	impersonating_dna = new
	victim.dna.copy_dna(impersonating_dna)
	impersonating_name = victim.real_name
	impersonating_skintone = victim.skin_tone
	impersonating_hairstyle = victim.hairstyle
	impersonating_facialhair = victim.facial_hairstyle
	impersonating_haircolor = victim.hair_color
	impersonating_facialhaircolor = victim.facial_hair_color
	impersonating_eyecolor = victim.eye_color
	impersonating_body_mod = victim.base_body_mod
	if (victim.clane)
		impersonating_alt_sprite = victim.clane.alt_sprite
		impersonating_alt_sprite_greyscale = victim.clane.alt_sprite_greyscale

/datum/discipline_power/vtr/obfuscate/familiar_stranger/proc/initialize_original()
	if (is_shapeshifted)
		return
	if (original_dna && original_body_mod)
		return

	original_dna = new
	owner.dna.copy_dna(original_dna)
	original_name = owner.real_name
	original_skintone = owner.skin_tone
	original_hairstyle = owner.hairstyle
	original_facialhair = owner.facial_hairstyle
	original_haircolor = owner.hair_color
	original_facialhaircolor = owner.facial_hair_color
	original_eyecolor = owner.eye_color
	original_body_mod = owner.base_body_mod
	original_alt_sprite = owner.clane?.alt_sprite
	original_alt_sprite_greyscale = owner.clane?.alt_sprite_greyscale

/datum/discipline_power/vtr/obfuscate/familiar_stranger/proc/shapeshift(to_original = FALSE)
	if (!impersonating_dna)
		return

	if (to_original)
		playsound(get_turf(owner), 'code/modules/wod13/sounds/obfuscate_deactivate.ogg', 100, TRUE, -6)
		original_dna.transfer_identity(destination = owner, transfer_SE = TRUE, superficial = TRUE)
		owner.real_name = original_name
		owner.skin_tone = original_skintone
		owner.hairstyle = original_hairstyle
		owner.facial_hairstyle = original_facialhair
		owner.hair_color = original_haircolor
		owner.facial_hair_color = original_facialhaircolor
		owner.eye_color = original_eyecolor
		owner.base_body_mod = original_body_mod
		owner.clane?.alt_sprite = original_alt_sprite
		owner.clane?.alt_sprite_greyscale = original_alt_sprite_greyscale
		is_shapeshifted = FALSE
		QDEL_NULL(impersonating_dna)
	else
		playsound(get_turf(owner), 'code/modules/wod13/sounds/obfuscate_activate.ogg', 100, TRUE, -6)
		impersonating_dna.transfer_identity(destination = owner, superficial = TRUE)
		owner.real_name = impersonating_name
		owner.skin_tone = impersonating_skintone
		owner.hairstyle = impersonating_hairstyle
		owner.facial_hairstyle = impersonating_facialhair
		owner.hair_color = impersonating_haircolor
		owner.facial_hair_color = impersonating_facialhaircolor
		owner.eye_color = impersonating_eyecolor
		owner.base_body_mod = impersonating_body_mod
		owner.clane?.alt_sprite = null
		owner.clane?.alt_sprite_greyscale = null
		is_shapeshifted = TRUE
	owner.update_body()