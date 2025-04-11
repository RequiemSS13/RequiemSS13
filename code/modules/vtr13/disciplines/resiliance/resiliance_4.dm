/datum/discipline_power/vtr/resiliance/four
	name = "Resiliance 4"
	desc = "Be like steel. Walk into fire and come out only singed."

	level = 4

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resiliance/one,
		/datum/discipline_power/vtr/resiliance/two,
		/datum/discipline_power/vtr/resiliance/three,
		/datum/discipline_power/vtr/resiliance/five
	)

/datum/discipline_power/vtr/resiliance/four/activate()
	. = ..()
	owner.physiology.armor.melee += 60
	owner.physiology.armor.bullet += 60
	owner.physiology.armor.fire += 40

/datum/discipline_power/vtr/resiliance/four/deactivate()
	. = ..()
	owner.physiology.armor.melee -= 60
	owner.physiology.armor.bullet -= 60
	owner.physiology.armor.fire -= 40
