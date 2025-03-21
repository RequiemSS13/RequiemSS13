//PSYCHIC PROJECTION
/datum/discipline_power/vtr/auspex/psychic_projection
	name = "Psychic Projection"
	desc = "Leave your body behind and fly across the land."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 5

/datum/discipline_power/vtr/auspex/psychic_projection/activate()
	. = ..()
	owner.ghostize(can_reenter_corpse = TRUE, aghosted = FALSE, auspex_ghosted = TRUE)
	owner.soul_state = SOUL_PROJECTING