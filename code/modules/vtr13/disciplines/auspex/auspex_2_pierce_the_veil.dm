//AURA PERCEPTION
/datum/discipline_power/vtr/auspex/pierce_the_veil
	name = "Aura Perception"
	desc = "Allows you to perceive the auras of those near you."

	check_flags = DISC_CHECK_CONSCIOUS|DISC_CHECK_SEE

	level = 2
	
	toggled = TRUE
	duration_length = 20 SECONDS

/datum/discipline_power/vtr/auspex/pierce_the_veil/activate()
	. = ..()

	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.add_hud_to(owner)

	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.add_hud_to(owner)
	owner.using_auspex = TRUE
	owner.see_invisible = get_auspex_level()

	owner.update_sight()

/datum/discipline_power/vtr/auspex/pierce_the_veil/deactivate()
	. = ..()

	var/datum/atom_hud/abductor_hud = GLOB.huds[DATA_HUD_ABDUCTOR]
	abductor_hud.remove_hud_from(owner)

	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)

	var/datum/atom_hud/health_hud = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	health_hud.remove_hud_from(owner)
	owner.using_auspex = FALSE
	owner.see_invisible = 0

	owner.update_sight()