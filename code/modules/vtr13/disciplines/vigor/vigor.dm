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
			violate_masquerade(owner, owner)
		else
			door_thing.pixel_z = door_thing.pixel_z+rand(-1, 1)
			door_thing.pixel_w = door_thing.pixel_w+rand(-1, 1)
			playsound(get_turf(door_thing), 'code/modules/wod13/sounds/get_bent.ogg', 50, TRUE)
			to_chat(attacker, span_warning("[door_thing] is locked, and you aren't strong enough to break it down!"))
			door_thing.door_reset_callback()
		return COMPONENT_CANCEL_ATTACK_CHAIN

