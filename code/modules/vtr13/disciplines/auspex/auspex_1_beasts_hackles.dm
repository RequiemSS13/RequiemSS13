//HEIGHTENED SENSES
/datum/discipline_power/vtr/auspex/beasts_hackles
	name = "Beast's Hackles"
	desc = "Enhances your senses far past human limitations."

	check_flags = DISC_CHECK_CONSCIOUS|DISC_CHECK_SEE

	level = 1

	toggled = TRUE
	duration_length = 2 TURNS

/datum/discipline_power/vtr/auspex/beasts_hackles/activate()
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.add_hud_to(owner)

	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, AUSPEX_1_TRAIT)
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, AUSPEX_1_TRAIT)
	ADD_TRAIT(owner, TRAIT_USING_AUSPEX, AUSPEX_1_TRAIT)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.add_hud_to(owner)
	owner.update_sight()
	
	owner.see_invisible = get_auspex_level()


/datum/discipline_power/vtr/auspex/beasts_hackles/deactivate()
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.remove_hud_from(owner)

	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, AUSPEX_1_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, AUSPEX_1_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_USING_AUSPEX, AUSPEX_1_TRAIT)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.remove_hud_from(owner)
	owner.update_sight()