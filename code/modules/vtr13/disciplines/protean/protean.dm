/datum/discipline/vtr/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/vtr/protean

/datum/discipline_power/vtr/protean
	name = "Protean power name"
	desc = "Protean power description"

	activate_sound = 'code/modules/wod13/sounds/protean_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/protean_deactivate.ogg'

/datum/discipline_power/vtr/protean/proc/deactivate_trigger()
	SIGNAL_HANDLER
	deactivate()
	return


/obj/effect/proc_holder/spell/targeted/shapeshift/protean
	name = "Shape of the Beast"
	desc = "Take on the shape a thing."
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE

//Action button for deactivate
/datum/action/deactivate_protean_shape
	name = "Deactivate Protean Shape"
	desc = "Revert to your previous form."
	background_icon_state = "gift"
	button_icon_state = "bloodcrawler"
	var/datum/discipline_power/vtr/protean/discipline_power

/datum/action/deactivate_protean_shape/New(Target, datum/discipline_power/vtr/protean/power)
	..(Target)
	discipline_power = power

/datum/action/deactivate_protean_shape/Trigger()
	discipline_power.deactivate_trigger()
