//HEIGHTENED SENSES
/datum/discipline_power/vtr/auspex/heightened_senses
	name = "Heightened Senses"
	desc = "Enhances your senses far past human limitations."

	check_flags = DISC_CHECK_CONSCIOUS|DISC_CHECK_SEE

	level = 1

	toggled = TRUE
	duration_length = 15 SECONDS

/datum/discipline_power/vtr/auspex/heightened_senses/activate()
	. = ..()
	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)

	owner.update_sight()
	owner.using_auspex = TRUE

/datum/discipline_power/vtr/auspex/heightened_senses/deactivate()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	owner.using_auspex = FALSE

	owner.update_sight()