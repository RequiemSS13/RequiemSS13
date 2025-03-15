/datum/discipline_power/vtr/resiliance/two
	name = "Resiliance 2"
	desc = "Become as stone. Let nothing breach your protections."

	level = 2

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = DURATION_TURN

	grouped_powers = list(
		/datum/discipline_power/vtr/resiliance/one,
		/datum/discipline_power/vtr/resiliance/three,
		/datum/discipline_power/vtr/resiliance/four,
		/datum/discipline_power/vtr/resiliance/five
	)

/datum/discipline_power/vtr/resiliance/two/activate()
	. = ..()
	owner.physiology.armor.melee += 30
	owner.physiology.armor.bullet += 30
	owner.physiology.armor.fire += 20

/datum/discipline_power/vtr/resiliance/two/deactivate()
	. = ..()
	owner.physiology.armor.melee -= 30
	owner.physiology.armor.bullet -= 30
	owner.physiology.armor.fire -= 20