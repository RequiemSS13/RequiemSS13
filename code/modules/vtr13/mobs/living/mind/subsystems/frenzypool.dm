SUBSYSTEM_DEF(frenzypool)
	name = "Frenzy Pool"
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/list/frenzy_list = list()

/datum/controller/subsystem/frenzypool/stat_entry(msg)
	var/list/activelist = GLOB.frenzy_list
	msg = "Frenzy:[length(activelist)]"
	return ..()

/datum/controller/subsystem/frenzypool/fire(resumed = FALSE)
	if(length(frenzy_list))
		SEND_SIGNAL(src, COMSIG_HANDLE_AUTOMATED_FRENZY)
