/datum/movespeed_modifier/vtr/celerity5
	multiplicative_slowdown = -1.5

/datum/discipline_power/vtr/celerity/five
	name = "Celerity 5"
	desc = "You are like light. Blaze your way through the world."

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/celerity/one,
		/datum/discipline_power/vtr/celerity/two,
		/datum/discipline_power/vtr/celerity/three,
		/datum/discipline_power/vtr/celerity/four
	)

/datum/discipline_power/vtr/celerity/five/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE, PROC_REF(celerity_visual))

	ADD_TRAIT(owner, TRAIT_NONMASQUERADE, CELERITY_TRAIT)
	ADD_TRAIT(owner, TRAIT_QUICK_JUMP, CELERITY_TRAIT)
	ADD_TRAIT(owner, TRAIT_SUPERNATURAL_DEXTERITY, CELERITY_TRAIT)
	owner.celerity_visual = TRUE
	owner.add_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity5)

/datum/discipline_power/vtr/celerity/five/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOVABLE_PRE_MOVE)

	REMOVE_TRAIT(owner, TRAIT_NONMASQUERADE, CELERITY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_QUICK_JUMP, CELERITY_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_SUPERNATURAL_DEXTERITY, CELERITY_TRAIT)
	owner.celerity_visual = FALSE
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity5)
