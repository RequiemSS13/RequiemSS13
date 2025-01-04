SUBSYSTEM_DEF(zombiepool)
	name = "Zombie Pool"
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_VERYLOW
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	wait = 20

	var/list/currentrun = list()

/datum/controller/subsystem/zombiepool/stat_entry(msg)
	var/list/activelist = GLOB.zombie_list
	msg = "ZOMBIES:[length(activelist)]"
	return ..()

/datum/controller/subsystem/zombiepool/fire(resumed = FALSE)

	if (!resumed)
		var/list/activelist = GLOB.zombie_list
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/simple_animal/hostile/zombie/Z = currentrun[currentrun.len]
		--currentrun.len

		if (QDELETED(Z)) // Some issue causes nulls to get into this list some times. This keeps it running, but the bug is still there.
			GLOB.zombie_list -= Z
			log_world("Found a null in npc list!")
			continue

		//!NPC.route_optimisation()
		if(MC_TICK_CHECK)
			return
		Z.handle_automated_patriotification()
