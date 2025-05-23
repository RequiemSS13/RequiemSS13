/datum/discipline_power/vtr/resilience/four
	name = "Resilience 4"
	desc = "Be like steel. Walk into fire and come out only singed."

	level = 4

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resilience/one,
		/datum/discipline_power/vtr/resilience/two,
		/datum/discipline_power/vtr/resilience/three,
		/datum/discipline_power/vtr/resilience/five
	)

/datum/discipline_power/vtr/resilience/four/activate()
	. = ..()
	owner.physiology.damage_resistance += 55

/datum/discipline_power/vtr/resilience/four/deactivate()
	. = ..()
	owner.physiology.damage_resistance -= 55
