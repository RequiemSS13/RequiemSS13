/datum/discipline_power/vtr/resilience/two
	name = "Resilience 2"
	desc = "Become as stone. Let nothing breach your protections."

	level = 2

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resilience/one,
		/datum/discipline_power/vtr/resilience/three,
		/datum/discipline_power/vtr/resilience/four,
		/datum/discipline_power/vtr/resilience/five
	)

/datum/discipline_power/vtr/resilience/two/activate()
	. = ..()
	owner.physiology.damage_resistance += 30

/datum/discipline_power/vtr/resilience/two/deactivate()
	. = ..()
	owner.physiology.damage_resistance -= 30