/datum/discipline_power/vtr/resiliance/three
	name = "Resiliance 3"
	desc = "Look down upon those who would try to kill you. Shrug off grievous attacks."

	level = 3

	check_flags = DISC_CHECK_CONSCIOUS

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/vtr/resiliance/one,
		/datum/discipline_power/vtr/resiliance/two,
		/datum/discipline_power/vtr/resiliance/four,
		/datum/discipline_power/vtr/resiliance/five
	)

/datum/discipline_power/vtr/resiliance/three/activate()
	. = ..()
	owner.physiology.armor.melee += 45
	owner.physiology.armor.bullet += 45
	owner.physiology.armor.fire += 30

/datum/discipline_power/vtr/resiliance/three/deactivate()
	. = ..()
	owner.physiology.armor.melee -= 45
	owner.physiology.armor.bullet -= 45
	owner.physiology.armor.fire -= 30
