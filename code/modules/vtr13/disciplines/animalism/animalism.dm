/datum/discipline/vtr/animalism
	name = "Animalism but VTR tho"
	desc = "Elgeon should write a description for this. Violates Masquerade (?)."
	icon_state = "animalism"
	power_type = /datum/discipline_power/vtr/animalism


/datum/discipline_power/vtr/animalism
	name = "Animalism power name"
	desc = "Animalism power description"

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

	effect_sound = 'code/modules/wod13/sounds/wolves.ogg'
	violates_masquerade = TRUE

	cooldown_length = 8 SECONDS


