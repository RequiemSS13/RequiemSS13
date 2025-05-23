/datum/movespeed_modifier/vtr/celerity4
	multiplicative_slowdown = -1.25

/datum/discipline_power/vtr/celerity/four
	name = "Celerity 4"
	desc = "Breach the limits of what is humanly possible. Move like a lightning bolt."

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/celerity/one,
		/datum/discipline_power/vtr/celerity/two,
		/datum/discipline_power/vtr/celerity/three,
		/datum/discipline_power/vtr/celerity/five
	)

/datum/discipline_power/vtr/celerity/four/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(celerity_visual))

	ADD_TRAIT(owner, TRAIT_NONMASQUERADE, CELERITY_TRAIT)
	ADD_TRAIT(owner, TRAIT_QUICK_JUMP, CELERITY_TRAIT)
	ADD_TRAIT(owner, TRAIT_SUPERNATURAL_DEXTERITY, CELERITY_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity4)

/datum/discipline_power/vtr/celerity/four/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)

	REMOVE_TRAIT(owner, TRAIT_NONMASQUERADE, CELERITY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_QUICK_JUMP, CELERITY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_SUPERNATURAL_DEXTERITY, CELERITY_TRAIT)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity4)