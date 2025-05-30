/obj/effect/landmark/npcbeacon
	name = "NPC beacon"
	var/directionwalk
/obj/effect/landmark/npc_spawn_point
/obj/effect/landmark/npc_spawn_point/Initialize()
	. = ..()
	GLOB.npc_spawn_points |= src
/obj/effect/landmark/npcbeacon/directed
	name = "NPC traffic"
	icon_state = "npc"

/obj/effect/landmark/npcbeacon/directed/Initialize()
	..()
	directionwalk = dir

/obj/effect/landmark/npcwall
	name = "NPC Wall"
	icon_state = "x"

/obj/effect/landmark/npcactivity
	name = "NPC Activity"
	icon_state = "bullets"

/obj/effect/landmark/npcability
	name = "NPC Ability"
	icon_state = "ability"

/obj/effect/landmark/npcactivity/Initialize()
	. = ..()
	GLOB.npc_activities += src

/mob/living/carbon/human/npc/Initialize()
	.=..()
	GLOB.npc_list += src
	GLOB.alive_npc_list += src
	if(!istype(src, /mob/living/carbon/human/npc/police) && !istype(src, /mob/living/carbon/human/npc/guard) && !istype(src, /mob/living/carbon/human/npc/bacotell) && !istype(src, /mob/living/carbon/human/npc/bubway) && !istype(src, /mob/living/carbon/human/npc/bouncer))
		GLOB.boring_npc_list += src
	add_movespeed_modifier(/datum/movespeed_modifier/npc)
	return INITIALIZE_HINT_LATELOAD


/mob/living/carbon/human/npc/Destroy()
	..()
	GLOB.npc_list -= src
	GLOB.alive_npc_list -= src
	GLOB.boring_npc_list -= src
	SShumannpcpool.npclost()

/mob/living/carbon/human/npc/Life()
	if(stat == DEAD)
		return
	..()
	if(pulledby)
		if(prob(25))
			Aggro(pulledby, TRUE)
		if(fights_anyway)
			Aggro(pulledby, TRUE)
	if(!CheckMove())
		nutrition = 400
		if(get_dist(danger_source, src) < 7)
			last_danger_meet = world.time
		if(fire_stacks >= 1)
			resist()
		if(!staying)
			if(!walktarget)
				walktarget = ChoosePath()
			if(loc == tupik_loc)
				tupik_steps += 1
			if(loc != tupik_loc)
				tupik_loc = loc
				tupik_steps = 0
			if(tupik_steps > 3)
				var/turf/T = get_step(src, pick(NORTH, SOUTH, WEST, EAST))
				face_atom(T)
				step_to(src,T,0)
				if(walktarget && !old_movement)
					if(route_optimisation())
						forceMove(get_turf(walktarget))

/mob/living/carbon/human/npc/proc/CreateWay(var/direction)
	var/turf/location = get_turf(src)
	for(var/distance = 1 to 50)
		location = get_step(location, direction)
		if(iswallturf(location))
			return location
		for(var/atom/A in location)
			if(A.density && !istype(A, /obj/structure/lamppost))
				return location
			if(istype(A, /obj/effect/landmark/npcwall))
				return get_step_towards(location, get_turf(src))
			if(isnpcbeacon(A) && prob(50))
				stopturf = 1
				return get_step(location, direction)

/mob/living/carbon/human/npc/proc/ChoosePath()
	if(!old_movement)
		var/list/possible_list = list()
		for(var/obj/effect/landmark/npcactivity/N in GLOB.npc_activities)
			if(get_dist(src, N) < 64)
				var/turf/T = get_step(N, turn(get_dir(src, N), 180))
				var/obj/effect/landmark/npcability/A = locate() in T
				if(A)
					if(N.x > x-3 && N.x < x+3 && N != last_waypoint)
						possible_list += N
					if(N.y > y-3 && N.y < y+3 && N != last_waypoint)
						possible_list += N

		if(!length(possible_list)) //if we can't find any valid waypoints then repeat the above process but allow last_waypoint
			possible_list = list()
			for(var/obj/effect/landmark/npcactivity/N in GLOB.npc_activities)
				if(get_dist(src, N) < 64)
					var/turf/T = get_step(N, turn(get_dir(src, N), 180))
					var/obj/effect/landmark/npcability/A = locate() in T
					if(A)
						if(N.x > x-3 && N.x < x+3)
							possible_list += N
						if(N.y > y-3 && N.y < y+3)
							possible_list += N

		if(!length(possible_list)) //if we still can't find any valid waypoints then we do 'panic mode' (find the closest waypoint of any kind) but exclude last_waypoint
			var/atom/panic_waypoint
			for(var/obj/effect/landmark/npcactivity/N in GLOB.npc_activities)
				if(N && N != last_waypoint)
					if(!panic_waypoint)
						panic_waypoint = N
					if(get_dist(src, N) > 1 && get_dist(src, N) < get_dist(src, panic_waypoint))
						panic_waypoint = N
			if(panic_waypoint)
				last_waypoint = cur_waypoint
				cur_waypoint = panic_waypoint
				return panic_waypoint

			//if we STILL can't find a waypoint then we do panic mode again, allowing last_waypoint
			panic_waypoint = null
			for(var/obj/effect/landmark/npcactivity/N in GLOB.npc_activities)
				if(N)
					if(!panic_waypoint)
						panic_waypoint = N
					if(get_dist(src, N) > 1 && get_dist(src, N) < get_dist(src, panic_waypoint))
						panic_waypoint = N
			if(panic_waypoint)
				last_waypoint = cur_waypoint
				cur_waypoint = panic_waypoint
				return panic_waypoint

			else //finally, if we can't find any landmark/npcactivity waypoints period, then we just randomly pick from npc_activities in general
				last_waypoint = cur_waypoint
				cur_waypoint = panic_waypoint
				return pick(GLOB.npc_activities)

		last_waypoint = cur_waypoint
		cur_waypoint = pick(possible_list)
		return cur_waypoint
	else
		var/turf/north_steps = CreateWay(NORTH)
		var/turf/south_steps = CreateWay(SOUTH)
		var/turf/west_steps = CreateWay(WEST)
		var/turf/east_steps = CreateWay(EAST)

		if(dir == NORTH || dir == SOUTH)
			if(get_dist(src, west_steps) >= 7 && get_dist(src, east_steps) >= 7)
				return(pick(west_steps, east_steps))
			if(get_dist(src, west_steps) > get_dist(src, east_steps))
				if(prob(75))
					return west_steps
			else if(get_dist(src, east_steps) > get_dist(src, west_steps))
				if(prob(75))
					return east_steps
			else
				if(dir == NORTH)
					return pick(west_steps, east_steps, south_steps)
				else
					return pick(west_steps, east_steps, north_steps)

		if(dir == WEST || dir == EAST)
			if(get_dist(src, north_steps) >= 7 && get_dist(src, south_steps) >= 7)
				return pick(north_steps, south_steps)
			if(get_dist(src, north_steps) > get_dist(src, south_steps))
				if(prob(75))
					return north_steps
			else if(get_dist(src, south_steps) > get_dist(src, north_steps))
				if(prob(75))
					return south_steps
			else
				if(dir == WEST)
					return pick(north_steps, south_steps, east_steps)
				else
					return pick(north_steps, south_steps, west_steps)
/mob/living/carbon/human/npc/proc/CheckMove()
	if(stat >= HARD_CRIT)
		return TRUE
	if(last_grab+15 > world.time)
		return TRUE
	if(ghoulificated)
		return TRUE
	if(key)
		return TRUE
	if(IsSleeping())
		return TRUE
	if(IsUnconscious())
		return TRUE
	if(IsParalyzed())
		return TRUE
	if(IsKnockdown())
		return TRUE
	if(IsStun())
		return TRUE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE
	if(is_talking)
		return TRUE
	if(pulledby)
		if(HAS_TRAIT(pulledby, TRAIT_CHARMER))
			return TRUE
		if(prob(30))
			resist()
			return TRUE
		else
			return TRUE
	return FALSE


/mob/living/carbon/human/npc/proc/route_optimisation()
	for(var/mob/M in viewers(7, src))
		if(M.client)
			return FALSE
	return TRUE

/mob/living/carbon/human/npc/proc/handle_automated_movement()
	if(CheckMove())
		return
	var/fire_danger = FALSE
	for(var/obj/effect/fire/F in range(7, src))
		if(F)
			less_danger = F
			fire_danger = TRUE
	if(!fire_danger)
		less_danger = null
	if(!staying)
		lifespan = lifespan+1
	if(!walktarget && !staying)
		stopturf = rand(1, 2)
		walktarget = ChoosePath()
		face_atom(walktarget)
	if(isturf(loc))
		if(danger_source)
			a_intent = INTENT_HARM
			if(m_intent == MOVE_INTENT_WALK)
				toggle_move_intent(src)
			if(!has_weapon && !fights_anyway)
				var/reqsteps = round((SShumannpcpool.next_fire-world.time)/total_multiplicative_slowdown())
				set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
				walk_away(src, danger_source, reqsteps, total_multiplicative_slowdown())
			if(has_weapon || fights_anyway)
				var/obj/item/card/id/id_card = danger_source.get_idcard(FALSE)
				if(!istype(id_card, /obj/item/card/id/police) || is_criminal)
					if(!spawned_weapon && has_weapon)
						npc_draw_weapon()
					if(spawned_weapon && get_active_held_item() != my_weapon)
						has_weapon = FALSE
					if(danger_source)
						if(danger_source == src)
							danger_source = null
						else
							ClickOn(danger_source)
							face_atom(danger_source)
							var/reqsteps = round((SShumannpcpool.next_fire-world.time)/total_multiplicative_slowdown())
							set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
							walk_to(src, danger_source, reqsteps, total_multiplicative_slowdown())

			if(isliving(danger_source))
				var/mob/living/L = danger_source
				if(L.stat > 2)
					danger_source = null
					if(has_weapon)
						if(get_active_held_item() == my_weapon)
							npc_stow_weapon()
						else
							has_weapon = FALSE
					walktarget = ChoosePath()
					a_intent = INTENT_HELP

			if(last_danger_meet+300 <= world.time)
				danger_source = null
				if(has_weapon)
					if(get_active_held_item() == my_weapon)
						npc_stow_weapon()
					else
						has_weapon = FALSE
				walktarget = ChoosePath()
				a_intent = INTENT_HELP
		else if(less_danger)
			var/reqsteps = round((SShumannpcpool.next_fire-world.time)/total_multiplicative_slowdown())
			set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
			walk_away(src, less_danger, reqsteps, total_multiplicative_slowdown())
			if(prob(25))
				emote("scream")
		else if(walktarget && !staying)
			if(prob(25))
				toggle_move_intent(src)
			var/reqsteps = round((SShumannpcpool.next_fire-world.time)/total_multiplicative_slowdown())
			set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
			walk_to(src, walktarget, reqsteps, total_multiplicative_slowdown())

		if(has_weapon && !danger_source)
			if(spawned_weapon)
				if(get_active_held_item() == my_weapon)
					npc_stow_weapon()
				else
					has_weapon = FALSE
