/datum/discipline_power/vtr/animalism/mark_territory
	name = "Mark Territory"
	desc = "Mark a stretch of tiles with your blood, notifying you whenever someone crosses over them."
	level = 4
	vitae_cost = 0
	cooldown_length = 0.2 SECONDS

	//how many more tiles you can make before you have to spend another blood point
	var/tiles_left = 0
	var/tiles_refresh_amount = 3
	var/list/marked_land_list = null
	var/list/notified_tresspassers_list = null
	var/notify_cooldown = 5 SECONDS

/datum/discipline_power/vtr/animalism/mark_territory/New(datum/discipline/discipline)
	..()
	if(!owner)
		return
	RegisterSignal(owner, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(unmark_land))

/datum/discipline_power/vtr/animalism/mark_territory/spend_resources()
	if(tiles_left)
		tiles_left--
		return TRUE
	else if (owner.bloodpool >= 1)
		tiles_left = tiles_refresh_amount
		owner.bloodpool = owner.bloodpool - 1
		owner.update_action_buttons()
		return TRUE
	else
		return FALSE


/datum/discipline_power/vtr/animalism/mark_territory/can_activate_untargeted(alert = FALSE)
	. = ..()
	var/turf/our_turf = get_turf(owner)
	if(!our_turf)
		if(alert)
			to_chat(owner, span_warning("You are not on markable turf!"))
		return FALSE
	if(LAZYFIND(marked_land_list, our_turf))
		if(alert)
			to_chat(owner, span_warning("You've already marked this turf!"))
		return FALSE

/datum/discipline_power/vtr/animalism/mark_territory/activate()
	..()


	var/turf/our_turf = get_turf(owner)
	if(!our_turf)
		return

	to_chat(owner, "You mark the [our_turf] as your territory.")

	LAZYADD(marked_land_list, our_turf)
	tiles_left--
	RegisterSignal(our_turf, COMSIG_ATOM_ENTERED, PROC_REF(notify_entry))

/datum/discipline_power/vtr/animalism/mark_territory/proc/notify_entry(datum/source, mob/mover, atom/oldLoc)
	SIGNAL_HANDLER

	if(!istype(mover, /mob) || !mover.mind || LAZYFIND(notified_tresspassers_list, mover))
		return

	LAZYADD(notified_tresspassers_list, mover)
	to_chat(owner, "You sense [mover] crossing your territorial line...")
	addtimer(CALLBACK(src, PROC_REF(notify_timeout), mover), notify_cooldown)

/datum/discipline_power/vtr/animalism/mark_territory/proc/notify_timeout(mob/mover)
	LAZYREMOVE(notified_tresspassers_list, mover)

/datum/discipline_power/vtr/animalism/mark_territory/proc/unmark_land(datum/source)
	SIGNAL_HANDLER
	for(var/turf/our_turf in marked_land_list)
		UnregisterSignal(our_turf, COMSIG_ATOM_ENTERED)
	marked_land_list = null
