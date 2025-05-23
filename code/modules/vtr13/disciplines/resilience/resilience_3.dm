/datum/discipline_power/vtr/resilience/three
	name = "Resilience 3"
	desc = "Look down upon those who would try to kill you. Shrug off grievous attacks."

	level = 3

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resilience/one,
		/datum/discipline_power/vtr/resilience/two,
		/datum/discipline_power/vtr/resilience/four,
		/datum/discipline_power/vtr/resilience/five
	)

/datum/discipline_power/vtr/resilience/three/activate()
	. = ..()
	owner.physiology.damage_resistance += 45

/datum/discipline_power/vtr/resilience/three/deactivate()
	. = ..()
	owner.physiology.damage_resistance -= 45
