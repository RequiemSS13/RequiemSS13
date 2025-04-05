/datum/discipline_power/vtr/resiliance/five
	name = "Resiliance 5"
	desc = "Reach the pinnacle of toughness. Never fear anything again."

	level = 5

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resiliance/one,
		/datum/discipline_power/vtr/resiliance/two,
		/datum/discipline_power/vtr/resiliance/three,
		/datum/discipline_power/vtr/resiliance/four
	)

/datum/discipline_power/vtr/resiliance/five/activate()
	. = ..()
	owner.physiology.armor.melee += 75
	owner.physiology.armor.bullet += 75
	owner.physiology.armor.fire += 50

/datum/discipline_power/vtr/resiliance/five/deactivate()
	. = ..()
	owner.physiology.armor.melee -= 75
	owner.physiology.armor.bullet -= 75
	owner.physiology.armor.fire -= 50