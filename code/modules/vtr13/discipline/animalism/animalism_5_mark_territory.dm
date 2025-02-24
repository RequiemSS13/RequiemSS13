/datum/discipline_power/vtr/animalism/mark_territory
	name = "Mark Territory"
	desc = "Elgeon write a description kthx. Summon a cat or rat"
	level = 4
	vitae_cost = 0
	bypass_spending_limits = TRUE
	cooldown_length = 0
	fire_and_forget = TRUE

	var/tiles_left = 0
	var/list/marked_land_list = null
	var/list/notified_tresspassers_list = null
	var/notify_cooldown = 5 SECONDS

/datum/discipline_power/vtr/animalism/mark_territory/New(datum/discipline/discipline)
	..()
	if(!owner)
		return
	RegisterSignal(owner, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(unmark_land))

/datum/discipline_power/vtr/animalism/mark_territory/can_activate_untargeted(alert = FALSE)
	. = ..()
	var/turf/our_turf = get_turf(owner)
	if(!our_turf)
		to_chat(owner, span_warning("You are not on markable turf!"))
		return FALSE
	if(LAZYFIND(marked_land_list, our_turf))
		to_chat(owner, span_warning("You've already marked this turf!"))
		return FALSE

	if (!ishuman(owner) || tiles_left)
		return TRUE
	
	var/mob/living/carbon/human/human = owner
	var/datum/species/kindred/species = owner.dna.species
	if (!species.can_spend_blood(owner, 1))
		if (alert)
			to_chat(owner, "<span class='warning'>You cannot spend blood fast enough to cast [name] now!</span>")
		return FALSE

/datum/discipline_power/vtr/animalism/mark_territory/activate()
	..()
	if(!tiles_left)
		tiles_left = 3
	
	
	var/turf/our_turf = get_turf(owner)
	if(!our_turf)
		return
	
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
