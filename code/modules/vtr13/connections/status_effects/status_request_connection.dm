// this status effect is used to negotiate the g
/datum/status_effect/request_connection
	id = "request_connection"
	duration = -1
	tick_interval = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null

	var/is_offering = FALSE //swaps the parties involved in the connection request.

	/// The people who were offered this item at the start
	var/list/possible_takers

	var/datum/character_connection_type/connection_type

/datum/status_effect/request_connection/on_creation(mob/living/new_owner, connection_type_name, is_offering = FALSE, mob/living/carbon/offered)
	. = ..()
	if(!.)
		return
	
	if(!connection_type_name)
		qdel(src)
		return

	connection_type = SScharacter_connection.get_character_connection_type(connection_type_name)

	if(!connection_type?.alert_type)
		qdel(src)
		return

	if(offered && is_taker_elligible(offered))
		register_candidate(offered)
	else
		for(var/mob/living/carbon/possible_taker in view(2, owner) - owner)
			if(!is_taker_elligible(possible_taker))
				continue
			register_candidate(possible_taker)

	if(is_offering)
		new_owner.visible_message(span_notice("[new_owner] is offering \a [connection_type_name]!"), span_notice("You offer \a [connection_type_name]."))
	else
		new_owner.visible_message(span_notice("[new_owner] is requesting \a [connection_type_name]!"), span_notice("You request \a [connection_type_name]."))


	src.is_offering = is_offering

	if(!possible_takers) // no one around
		qdel(src)
		return

	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, PROC_REF(cancel_offer))
	

/datum/status_effect/request_connection/Destroy()
	for(var/mob/living/carbon/removed_taker as anything in possible_takers)
		remove_candidate(removed_taker)
	LAZYCLEARLIST(possible_takers)
	connection_type = null
	return ..()

/// Hook up the specified carbon mob to be offered the connection in question, give them the alert and signals and all
/datum/status_effect/request_connection/proc/register_candidate(mob/living/carbon/possible_candidate)
	var/atom/movable/screen/alert/connection/connection_alert = possible_candidate.throw_alert("[owner]_[connection_type.name]", connection_type.alert_type)
	if(!connection_alert)
		return
	LAZYADD(possible_takers, possible_candidate)
	RegisterSignal(possible_candidate, COMSIG_MOVABLE_MOVED, PROC_REF(check_taker_in_range))
	connection_alert.setup(src, possible_candidate, connection_type)

/// Remove the alert and signals for the specified carbon mob. Automatically removes the status effect when we lost the last taker
/datum/status_effect/request_connection/proc/remove_candidate(mob/living/carbon/removed_candidate)
	removed_candidate.clear_alert("[owner]_[connection_type.name]")
	LAZYREMOVE(possible_takers, removed_candidate)
	UnregisterSignal(removed_candidate, COMSIG_MOVABLE_MOVED)
	if(!possible_takers && !QDELING(src))
		qdel(src)

/// One of our possible takers moved, see if they left us hanging
/datum/status_effect/request_connection/proc/check_taker_in_range(mob/living/carbon/taker)
	SIGNAL_HANDLER
	if(get_dist(get_turf(owner), get_turf(taker)) <= 2 && !IS_DEAD_OR_INCAP(taker))
		return

	to_chat(taker, span_warning("You moved out of range of [owner]!"))
	remove_candidate(taker)

/// The offerer moved, the deal is off
/datum/status_effect/request_connection/proc/cancel_offer(mob/living/carbon/source)
	SIGNAL_HANDLER
	to_chat(source, span_notice("You are no longer [is_offering?"offering":"requesting"] \a [connection_type.name]"))
	qdel(src)

/**
 * Is our taker valid as a target for the offering? Meant to be used when registering
 * takers in `on_creation()`.
 *
 * Returns `TRUE` if the taker is valid as a target for the offering.
 */
/datum/status_effect/request_connection/proc/is_taker_elligible(mob/living/carbon/taker)
	return owner.CanReach(taker) && !IS_DEAD_OR_INCAP(taker)

//run an attempt to forge a connection. If successful, return true. 
/datum/status_effect/request_connection/proc/trigger_establish_connection(mob/living/responder)
	if(!is_offering)
		if(SScharacter_connection.add_connection(connection_type.name, owner, responder))
			qdel(src)
		else
			remove_candidate(responder)
	else
		if(SScharacter_connection.add_connection(connection_type.name, responder, owner))
			qdel(src)
		else
			remove_candidate(responder)
