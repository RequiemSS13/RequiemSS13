/datum/movespeed_modifier/vtr/celerity3
	multiplicative_slowdown = -1

/datum/discipline_power/vtr/celerity/three
	name = "Celerity 3"
	desc = "Move faster. React in less time. Your body is under perfect control."

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/celerity/one,
		/datum/discipline_power/vtr/celerity/two,
		/datum/discipline_power/vtr/celerity/four,
		/datum/discipline_power/vtr/celerity/five
	)

/datum/discipline_power/vtr/celerity/three/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(celerity_visual))

	ADD_TRAIT(owner, TRAIT_NONMASQUERADE, CELERITY_TRAIT)
	ADD_TRAIT(owner, TRAIT_QUICK_JUMP, CELERITY_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity3)

/datum/discipline_power/vtr/celerity/three/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)
	REMOVE_TRAIT(owner, TRAIT_NONMASQUERADE, CELERITY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_QUICK_JUMP, CELERITY_TRAIT)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity3)