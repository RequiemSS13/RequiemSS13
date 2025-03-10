/datum/movespeed_modifier/vtr/celerity4
	multiplicative_slowdown = -1.25

/datum/discipline_power/vtr/celerity/four
	name = "Celerity 4"
	desc = "Breach the limits of what is humanly possible. Move like a lightning bolt."

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = DURATION_TURN

	grouped_powers = list(
		/datum/discipline_power/vtr/celerity/one,
		/datum/discipline_power/vtr/celerity/two,
		/datum/discipline_power/vtr/celerity/three,
		/datum/discipline_power/vtr/celerity/five
	)

/datum/discipline_power/vtr/celerity/four/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity4)

/datum/discipline_power/vtr/celerity/four/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity4)