/datum/discipline_power/vtr/resilience/one
	name = "Resilience 1"
	desc = "Harden your muscles. Become sturdier than the bodybuilders."

	level = 1

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resilience/two,
		/datum/discipline_power/vtr/resilience/three,
		/datum/discipline_power/vtr/resilience/four,
		/datum/discipline_power/vtr/resilience/five
	)

/datum/discipline_power/vtr/resilience/one/activate()
	. = ..()
	owner.physiology.damage_resistance += 15

/datum/discipline_power/vtr/resilience/one/deactivate()
	. = ..()
	owner.physiology.damage_resistance -= 15