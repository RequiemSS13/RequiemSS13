/datum/movespeed_modifier/vtr/celerity
	multiplicative_slowdown = -0.5

/datum/discipline_power/vtr/celerity/one
	name = "Celerity 1"
	desc = "Enhances your speed to make everything a little bit easier."

	check_flags = DISC_CHECK_LYING | DISC_CHECK_IMMOBILE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/celerity/two,
		/datum/discipline_power/vtr/celerity/three,
		/datum/discipline_power/vtr/celerity/four,
		/datum/discipline_power/vtr/celerity/five
	)

/datum/discipline_power/vtr/celerity/one/activate()
	. = ..()
	//put this out of its misery
	to_chat(owner, span_notice("You feel yourself become faster."))
	owner.add_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity)

/datum/discipline_power/vtr/celerity/one/deactivate()
	. = ..()
	to_chat(owner, span_notice("Your reflexes return to normal."))
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/vtr/celerity)
