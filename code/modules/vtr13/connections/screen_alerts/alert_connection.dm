/atom/movable/screen/alert/connection
	icon = 'icons/vtr13/hud/screen_alert.dmi'
	
	/// The offer we're linked to, yes this is suspiciously like a status effect alert
	var/datum/status_effect/request_connection/request

	/// Additional text displayed in the description of the alert.
	desc = "Click this alert to placeholder your placeholder in their placeholder."


/atom/movable/screen/alert/connection/Destroy()
	return ..()

/**
 * Handles assigning most of the variables for the alert that pops up when an item is offered
 *
 * Handles setting the name, description and icon of the alert and tracking the person giving
 * and the item being offered, also registers a signal that removes the alert from anyone who moves away from the offerer
 * Arguments:
 * * taker - The person receiving the alert
 * * offerer - The person giving the alert and item
 * * receiving - The item being given by the offerer
 */
/atom/movable/screen/alert/connection/proc/setup(datum/status_effect/request_connection/request, mob/living/carbon/taker, datum/character_connection_type/connection_type, custom_offer_name = null, custom_offer_description = null)
	src.request = request

	var/mob/living/offerer = request.owner
	if(!request.is_offering)
		if(connection_type.get_custom_alert_name(offerer, request.is_offering))
			name = connection_type.get_custom_alert_name(offerer, request.is_offering)
		else
			name = "[offerer] is requesting \a [connection_type.name]"
	else
		if(connection_type.get_custom_alert_name(offerer, request.is_offering))
			connection_type.get_custom_alert_name(offerer, request.is_offering)
		else
			name = "[offerer] is offering \a [connection_type.name]"
	

/atom/movable/screen/alert/connection/Click(location, control, params)
	. = ..()
	if(!.)
		return
	if(!iscarbon(usr))
		CRASH("User for [src] is of type \[[usr.type]\]. This should never happen.")

	handle_transfer()

/atom/movable/screen/alert/connection/proc/handle_transfer()
	request.trigger_establish_connection(usr)