/mob/living/carbon/human/proc/check_police_raid()
	if(!warrant)
		if(last_nonraid+1800 < world.time)
			last_nonraid = world.time
			killed_count = max(0, killed_count-1)
	else if (!key || stat == DEAD)
		last_nonraid = world.time
		warrant = FALSE
	else
		INVOKE_ASYNC(src, PROC_REF(handle_police_raid))

/mob/living/carbon/human/proc/handle_police_raid()
	if(istype(get_area(src), /area/vtm))
		var/area/vtm/V = get_area(src)
		if(V.upper && !current_police_raid && last_raid+next_raid < world.time)
			current_police_raid = TRUE
			sleep(10)
			var/warning_msg = pick("You see them searching above...", "The rumble of helicopter blades draws closer...")
			V = get_area(src) //recheck the area player is in
			if(istype(get_area(src), /area/vtm) && V.upper)
				to_chat(src, "<span class='warning'>[warning_msg]</span>")
				playsound(loc, 'code/modules/wod13/sounds/helicopter_far.ogg', 50, FALSE)
			sleep(40)
			V = get_area(src) //recheck the area player is in again
			if(istype(get_area(src), /area/vtm) && V.upper)
				warning_msg = pick("You really need to get out of sight now.", "You can't afford to hang around any longer.")
				to_chat(src, "<span class='warning'>[warning_msg]</span>")
			sleep(30)

			V = get_area(src) //recheck one last time
			if(!istype(get_area(src), /area/vtm) || !V.upper) //did the player hide in time?
				to_chat(src, "<span class='warning'>You slip back into the shadows before they notice.</span>")
				playsound(loc, 'code/modules/wod13/sounds/helicopter_leaving.ogg', 45, FALSE)
				last_nonraid = world.time
			else if(stat != DEAD)
				last_showed = world.time
				var/loclist = view(3,src) - view(2, src) //spawn enemies in a ring with dist = 3 from player in visible tile
				var/turfcount = 0
				for(var/turf/open/O in loclist) //count up the number of valid turfs
					turfcount += 1
				if(turfcount == 0) //are there no valid turfs? if so increase the spawn zone size
					loclist = view(3,src) - view(1, src)
					for(var/turf/open/O in loclist)
						turfcount += 1
				if(turfcount == 0) //if there are STILL no valid spawn points then abort
					current_police_raid = FALSE
					to_chat(src, "<span class='warning'><b>The helicopter above hovers in place.</b></span>")
					return

				sleep(10)
				playsound(loc, 'code/modules/wod13/sounds/helicopter_close.ogg', 50, TRUE)
				warning_msg = pick("They've seen you!", "You've been spotted!")
				to_chat(src, "<span class='warning'><b>[warning_msg]</b></span>")
				sleep(20)
				to_chat(src, "<span class='userdanger'><b>POLICE ASSAULT IN PROGRESS</b></span>")

				last_raid = world.time
				next_raid = (roll("6d20")) * 10 //set the minimum time before the next raid can spawn, median ~90 seconds

				var/spawnprob = 200/(turfcount) //cumulative spawn probability of 200%, e.g. spawn 2 cops on average

				var/cop_spawned = FALSE
				while(!cop_spawned) //make sure at least 1 cop spawns
					for(var/turf/open/O in loclist)
						if(prob(spawnprob))
							cop_spawned = TRUE
							new /obj/effect/temp_visual/desant(O)
			current_police_raid = FALSE
		else
			last_nonraid = world.time
	if(last_showed+9000 < world.time) //15 minute search time
		to_chat(src, "<b>POLICE STOPPED SEARCHING</b>")
		SEND_SOUND(src, sound('code/modules/wod13/sounds/humanity_gain.ogg', 0, 0, 75))
		killed_count = 0
		warrant = FALSE
		last_nonraid = world.time
