//HEIGHTENED SENSES
/datum/discipline_power/vtr/auspex/beasts_hackles
	name = "Beast's Hackles"
	desc = "Enhances your senses far past human limitations."

	check_flags = DISC_CHECK_CONSCIOUS|DISC_CHECK_SEE

	level = 1

	toggled = TRUE
	duration_length = 15 SECONDS

/datum/discipline_power/vtr/auspex/beasts_hackles/activate()
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.add_hud_to(owner)

	ADD_TRAIT(owner, list(TRAIT_THERMAL_VISION, TRAIT_NIGHT_VISION, TRAIT_USING_AUSPEX), AUSPEX_1_TRAIT)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.add_hud_to(owner)
	owner.see_invisible = get_auspex_level()

	owner.update_sight()


/datum/discipline_power/vtr/auspex/beasts_hackles/deactivate()
	. = ..()
	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.remove_hud_from(owner)

	REMOVE_TRAIT(owner, list(TRAIT_THERMAL_VISION, TRAIT_NIGHT_VISION, TRAIT_USING_AUSPEX), AUSPEX_1_TRAIT)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.remove_hud_from(owner)
	owner.see_invisible = 0

	owner.update_sight()