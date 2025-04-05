/datum/discipline_power/vtr/resiliance/one
	name = "Resiliance 1"
	desc = "Harden your muscles. Become sturdier than the bodybuilders."

	level = 1

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resiliance/two,
		/datum/discipline_power/vtr/resiliance/three,
		/datum/discipline_power/vtr/resiliance/four,
		/datum/discipline_power/vtr/resiliance/five
	)

/datum/discipline_power/vtr/resiliance/one/activate()
	. = ..()
	owner.physiology.armor.melee += 15
	owner.physiology.armor.bullet += 15
	owner.physiology.armor.fire += 10

/datum/discipline_power/vtr/resiliance/one/deactivate()
	. = ..()
	owner.physiology.armor.melee -= 15
	owner.physiology.armor.bullet -= 15
	owner.physiology.armor.fire -= 10