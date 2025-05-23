/datum/discipline_power/vtr/resilience/five
	name = "Resilience 5"
	desc = "Reach the pinnacle of toughness. Never fear anything again."

	level = 5

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resilience/one,
		/datum/discipline_power/vtr/resilience/two,
		/datum/discipline_power/vtr/resilience/three,
		/datum/discipline_power/vtr/resilience/four
	)

/datum/discipline_power/vtr/resilience/five/activate()
	. = ..()
	owner.physiology.damage_resistance += 65

/datum/discipline_power/vtr/resilience/five/deactivate()
	. = ..()
	owner.physiology.damage_resistance -= 65