/datum/discipline/vtr/vigor
	name = "Vigor"
	desc = "Boosts melee and unarmed damage."
	icon_state = "potence"
	power_type = /datum/discipline_power/vtr/vigor

/datum/discipline_power/vtr/vigor
	name = "Vigor power name"
	desc = "Vigor power description"

	activate_sound = 'code/modules/wod13/sounds/potence_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/potence_deactivate.ogg'

/datum/discipline_power/vtr/vigor/activate()
	. = ..()
	RegisterSignal(owner, COMSIG_MOB_LIVING_JUMP, PROC_REF(handle_jump))
	RegisterSignal(owner, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, PROC_REF(handle_attack_hand))


/datum/discipline_power/vtr/vigor/deactivate()
	. = ..()
	UnregisterSignal(owner, COMSIG_MOB_LIVING_JUMP)
	UnregisterSignal(owner, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, PROC_REF(handle_attack_hand))

/datum/discipline_power/vtr/vigor/proc/handle_jump(mob/living/carbon/human/jumper, turf/target, distance)
	SIGNAL_HANDLER
	if(get_dist(jumper.loc, target) <= 2 && level > 3)
		addtimer(CALLBACK(src, PROC_REF(vigor_boom), jumper),(distance * 0.5))

/datum/discipline_power/vtr/vigor/proc/vigor_boom(mob/living/carbon/human/jumper)
	playsound(get_turf(jumper), 'code/modules/wod13/sounds/werewolf_fall.ogg', 100, FALSE)
	new /obj/effect/temp_visual/dir_setting/crack_effect(get_turf(jumper))
	new /obj/effect/temp_visual/dir_setting/fall_effect(get_turf(jumper))
	for(var/mob/living/carbon/C in range(5, jumper))
		C.Stun(20)
		shake_camera(C, (6-get_dist(C, jumper))+1, (6-get_dist(C, jumper)))
	jumper.Stun(10)
	shake_camera(jumper, 5, 4)
	violate_masquerade(jumper, jumper)

/datum/discipline_power/vtr/vigor/proc/handle_attack_hand(mob/living/carbon/human/attacker, atom/attacked_thing, proximity)
	SIGNAL_HANDLER
	if(!proximity)
		return
	if(attacker.a_intent != "harm")
		return
	//punching person
	if(istype(attacked_thing, /mob/living/carbon/human))
		var/mob/living/living_thing = attacked_thing
		if(level > 1)
			violate_masquerade(owner, living_thing)
		if(level >= 5)
			var/atom/throw_target = get_edge_target_turf(attacked_thing, attacker.dir)
			living_thing.throw_at(throw_target, rand(5, 7), 4, attacker, gentle = TRUE) //No stun nor impact damage from throwing people around
		return
	
	//punching car
	if(istype(attacked_thing, /obj/vampire_car))
		if(level >= 4)
			var/obj/vampire_car/car_thing = attacked_thing
			var/atom/throw_target = get_edge_target_turf(car_thing, attacker.dir)
			playsound(get_turf(attacker), 'code/modules/wod13/sounds/bump.ogg', 100, FALSE)
			car_thing.get_damage(10)
			car_thing.throw_at(throw_target, rand(4, 6), 4, attacker)
			violate_masquerade(owner, owner)
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(istype(attacked_thing, /obj/structure/table))
		if(level >= 3)
			playsound(get_turf(attacked_thing), 'code/modules/wod13/sounds/get_bent.ogg', 100, FALSE)
			qdel(attacked_thing)
			violate_masquerade(attacker, attacker)
		return COMPONENT_CANCEL_ATTACK_CHAIN


	//punching door
	if(istype(attacked_thing, /obj/structure/vampdoor))
		var/obj/structure/vampdoor/door_thing = attacked_thing
		if((level * 2) >= door_thing.lockpick_difficulty)
			playsound(get_turf(door_thing), 'code/modules/wod13/sounds/get_bent.ogg', 100, FALSE)
			var/obj/item/shield/door/broke_door = new(get_turf(door_thing))
			broke_door.icon_state = door_thing.baseicon
			var/atom/throw_target = get_edge_target_turf(door_thing, attacker.dir)
			broke_door.throw_at(throw_target, rand(2, 4), 4, attacker)
			qdel(door_thing)
			violate_masquerade(attacker, attacker)
		else
			door_thing.pixel_z = door_thing.pixel_z+rand(-1, 1)
			door_thing.pixel_w = door_thing.pixel_w+rand(-1, 1)
			playsound(get_turf(door_thing), 'code/modules/wod13/sounds/get_bent.ogg', 50, TRUE)
			to_chat(attacker, span_warning("[door_thing] is locked, and you aren't strong enough to break it down!"))
			door_thing.door_reset_callback()
		return COMPONENT_CANCEL_ATTACK_CHAIN

	if(istype(attacked_thing, /turf/closed/wall/vampwall))
		if(level >= 5)
			blast_through_wall_windup(attacker, attacked_thing)
		return COMPONENT_CANCEL_ATTACK_CHAIN
	
	if(istype(attacked_thing, /obj/effect/decal/wallpaper))
		var/turf/closed/wall/vampwall_north = get_step(attacked_thing, NORTH)
		if(vampwall_north && get_dist(get_turf(attacked_thing), vampwall_north) <= 1)
			blast_through_wall_windup(attacker, vampwall_north)
		return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/discipline_power/vtr/vigor/proc/blast_through_wall_windup(mob/living/carbon/human/attacker, turf/closed/wall/vampwall/wall)
	set waitfor = FALSE
	attacker.visible_message(span_danger("[attacker] prepares to charge at [wall]!"))
	var/dir = get_dir(attacker, wall)
	var/windup_pixel_x = 0
	var/windup_pixel_y = 0
	switch(dir)
		if(NORTH)
			windup_pixel_y = -32
		if(SOUTH)
			windup_pixel_y = 32
		if(EAST)
			windup_pixel_x = -32
		if(WEST)
			windup_pixel_x = 32
		if(NORTHEAST)
			windup_pixel_y = -32
			windup_pixel_x = -32
		if(NORTHWEST)
			windup_pixel_y = -32
			windup_pixel_x = 32
		if(SOUTHEAST)
			windup_pixel_y = 32
			windup_pixel_x = -32
		if(SOUTHWEST)
			windup_pixel_y = 32
			windup_pixel_x = 32


	animate(attacker, pixel_x = windup_pixel_x, pixel_y = windup_pixel_y, time = 30)

	
	if(!do_mob(attacker, attacker, 3 SECONDS))
		animate(attacker, pixel_x = 0, pixel_y = 0, time = 0)
		return
	
	var/charge_pixel_x = 0
	var/charge_pixel_y = 0
	switch(dir)
		if(NORTH)
			charge_pixel_y = 48
		if(SOUTH)
			charge_pixel_y = -48
		if(EAST)
			charge_pixel_x = 48
		if(WEST)
			charge_pixel_x = -48
		if(NORTHEAST)
			charge_pixel_y = 48
			charge_pixel_x = 48
		if(NORTHWEST)
			charge_pixel_y = 48
			charge_pixel_x = -48
		if(SOUTHEAST)
			charge_pixel_y = -48
			charge_pixel_x = 48
		if(SOUTHWEST)
			charge_pixel_y = -48
			charge_pixel_x = -48

	animate(attacker, pixel_x = charge_pixel_x, pixel_y = charge_pixel_y, time = 5)
	attacker.Stun(30, TRUE)
	addtimer(CALLBACK(src, PROC_REF(blast_through_wall), attacker, wall, dir), 5)

/datum/discipline_power/vtr/vigor/proc/blast_through_wall(mob/living/carbon/human/attacker, turf/closed/wall/vampwall/wall, dir)
	attacker.visible_message(span_alert("[attacker] blows straight through the [wall], spraying debris everywhere!"))
	
	//delete a wallpaper if it exists
	var/obj/effect/decal/wallpaper/wallpaper_destroyed = locate(/obj/effect/decal/wallpaper) in get_step(wall, SOUTH)
	if(wallpaper_destroyed)
		qdel(wallpaper_destroyed)
	wall.ScrapeAway(amount=1)

	playsound(get_turf(attacker), 'code/modules/wod13/sounds/werewolf_fall.ogg', 100, FALSE)
	attacker.forceMove(get_step(attacker, dir))
	animate(attacker, pixel_x = 0, pixel_y = 0, time = 0)
	
	//init locations for debris
	var/list/debris_locations = list()
	debris_locations += get_adjacent_open_turfs(attacker)
	var/current_turf = get_turf(attacker)
	if(current_turf)
		debris_locations += current_turf
	
	//spread the debris
	if(debris_locations.len)
		var/location_1 = pick(debris_locations)
		debris_locations -= location_1
		new /obj/effect/decal/bricks(location_1)
		if(debris_locations.len && prob(50))
			var/location_2 = pick(debris_locations)
			debris_locations -= location_2
			new /obj/effect/decal/bricks(location_2)
		if(debris_locations.len && prob(10))
			new /obj/effect/decal/bricks(pick(debris_locations))

	qdel(debris_locations)
	violate_masquerade(attacker, attacker)
	attacker.adjustBruteLoss(20)
	to_chat(attacker, span_danger("Your whole body hurts from the impact."))