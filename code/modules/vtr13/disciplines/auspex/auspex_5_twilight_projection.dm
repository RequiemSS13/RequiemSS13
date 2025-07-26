//PSYCHIC PROJECTION
/datum/discipline_power/vtr/auspex/twilight_projection
	name = "Twilight Projection"
	desc = "Leave your body behind and fly across the land."

	check_flags = DISC_CHECK_CONSCIOUS

	level = 5

/datum/discipline_power/vtr/auspex/twilight_projection/activate()
	. = ..()
	owner.enter_avatar()
	owner.soul_state = SOUL_PROJECTING