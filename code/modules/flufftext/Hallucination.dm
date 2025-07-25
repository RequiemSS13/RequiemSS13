#define HAL_LINES_FILE "hallucination.json"

GLOBAL_LIST_INIT(hallucination_list, list(
	/datum/hallucination/chat = 30,
	/datum/hallucination/message = 30,
	/datum/hallucination/sounds = 20,
	/datum/hallucination/battle = 20,
	/datum/hallucination/dangerflash = 15,
	/datum/hallucination/weird_sounds = 8,
	/datum/hallucination/stray_bullet = 7,
	/datum/hallucination/husks = 7,
	/datum/hallucination/fire = 3,
	/datum/hallucination/self_delusion = 2,
	/datum/hallucination/delusion = 2,
	/datum/hallucination/shock = 1,
	/datum/hallucination/death = 1,
	/datum/hallucination/oh_yeah = 1
	))

//Tut nekotoroe runtime sret

/mob/living/carbon/proc/handle_hallucinations()
	if(!hallucination)
		return

	hallucination = max(hallucination - 1, 0)

	if(world.time < next_hallucination)
		return

	var/halpick = pickweight(GLOB.hallucination_list)
	new halpick(src, FALSE)

	next_hallucination = world.time + rand(1 MINUTES, 3 MINUTES)

/mob/living/carbon/proc/set_screwyhud(hud_type)
	hal_screwyhud = hud_type
	update_health_hud()

/datum/hallucination
	var/natural = TRUE
	var/mob/living/carbon/target
	var/feedback_details //extra info for investigate

/datum/hallucination/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	target = C
	natural = !forced

	// Cancel early if the target is deleted
	RegisterSignal(target, COMSIG_PARENT_QDELETING, PROC_REF(target_deleting))

/datum/hallucination/proc/target_deleting()
	SIGNAL_HANDLER

	qdel(src)

/datum/hallucination/proc/wake_and_restore()
	target.set_screwyhud(SCREWYHUD_NONE)
	target.SetSleeping(0)

/datum/hallucination/Destroy()
	target.investigate_log("was afflicted with a hallucination of type [type] by [natural?"hallucination status":"an external source"]. [feedback_details]", INVESTIGATE_HALLUCINATIONS)

	if (target)
		UnregisterSignal(target, COMSIG_PARENT_QDELETING)

	target = null
	return ..()

//Returns a random turf in a ring around the target mob, useful for sound hallucinations
/datum/hallucination/proc/random_far_turf()
	var/x_based = prob(50)
	var/first_offset = pick(-8,-7,-6,-5,5,6,7,8)
	var/second_offset = rand(-8,8)
	var/x_off
	var/y_off
	if(x_based)
		x_off = first_offset
		y_off = second_offset
	else
		y_off = first_offset
		x_off = second_offset
	var/turf/T = locate(target.x + x_off, target.y + y_off, target.z)
	return T

/obj/effect/hallucination
	invisibility = INVISIBILITY_OBSERVER
	anchored = TRUE
	var/mob/living/carbon/target = null

/obj/effect/hallucination/simple
	var/image_icon = 'icons/mob/alien.dmi'
	var/image_state = "alienh_pounce"
	var/px = 0
	var/py = 0
	var/col_mod = null
	var/image/current_image = null
	var/image_layer = MOB_LAYER
	var/active = TRUE //qdelery

/obj/effect/hallucination/singularity_pull()
	return

/obj/effect/hallucination/singularity_act()
	return

/obj/effect/hallucination/simple/Initialize(mapload, mob/living/carbon/T)
	. = ..()
	target = T
	current_image = GetImage()
	if(target.client)
		target.client.images |= current_image

/obj/effect/hallucination/simple/proc/GetImage()
	var/image/I = image(image_icon,src,image_state,image_layer,dir=src.dir)
	I.pixel_x = px
	I.pixel_y = py
	if(col_mod)
		I.color = col_mod
	return I

/obj/effect/hallucination/simple/proc/Show(update=1)
	if(active)
		if(target.client)
			target.client.images.Remove(current_image)
		if(update)
			current_image = GetImage()
		if(target.client)
			target.client.images |= current_image

/obj/effect/hallucination/simple/update_icon(new_state,new_icon,new_px=0,new_py=0)
	image_state = new_state
	if(new_icon)
		image_icon = new_icon
	else
		image_icon = initial(image_icon)
	px = new_px
	py = new_py
	Show()

/obj/effect/hallucination/simple/Moved(atom/OldLoc, Dir)
	. = ..()
	Show()

/obj/effect/hallucination/simple/Destroy()
	if(target.client)
		target.client.images.Remove(current_image)
	active = FALSE
	return ..()

#define FAKE_FLOOD_EXPAND_TIME 20
#define FAKE_FLOOD_MAX_RADIUS 10

/obj/effect/plasma_image_holder
	icon_state = "nothing"
	anchored = TRUE
	layer = FLY_LAYER
	plane = GAME_PLANE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/*
/datum/hallucination/fake_flood
	//Plasma starts flooding from the nearby vent
	var/turf/center
	var/list/flood_images = list()
	var/list/flood_image_holders = list()
	var/list/turf/flood_turfs = list()
	var/image_icon = 'icons/effects/atmospherics.dmi'
	var/image_state = "plasma"
	var/radius = 0
	var/next_expand = 0

/datum/hallucination/fake_flood/New(mob/living/carbon/C, forced = TRUE)
	..()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/U in orange(7,target))
		if(!U.welded)
			center = get_turf(U)
			break
	if(!center)
		qdel(src)
		return
	feedback_details += "Vent Coords: [center.x],[center.y],[center.z]"
	var/obj/effect/plasma_image_holder/pih = new(center)
	var/image/plasma_image = image(image_icon, pih, image_state, FLY_LAYER)
	plasma_image.alpha = 50
	plasma_image.plane = GAME_PLANE
	flood_images += plasma_image
	flood_image_holders += pih
	flood_turfs += center
	if(target.client)
		target.client.images |= flood_images
	next_expand = world.time + FAKE_FLOOD_EXPAND_TIME
	START_PROCESSING(SSobj, src)

/datum/hallucination/fake_flood/process()
	if(next_expand <= world.time)
		radius++
		if(radius > FAKE_FLOOD_MAX_RADIUS)
			qdel(src)
			return
		Expand()
		if((get_turf(target) in flood_turfs) && !target.internal)
			new /datum/hallucination/fake_alert(target, TRUE, "too_much_tox")
		next_expand = world.time + FAKE_FLOOD_EXPAND_TIME

/datum/hallucination/fake_flood/proc/Expand()
	for(var/image/I in flood_images)
		I.alpha = min(I.alpha + 50, 255)
	for(var/turf/FT in flood_turfs)
		for(var/dir in GLOB.cardinals)
			var/turf/T = get_step(FT, dir)
			if((T in flood_turfs) || !TURFS_CAN_SHARE(T, FT) || isspaceturf(T)) //If we've gottem already, or if they're not alright to spread with.
				continue
			var/obj/effect/plasma_image_holder/pih = new(T)
			var/image/new_plasma = image(image_icon, pih, image_state, FLY_LAYER)
			new_plasma.alpha = 50
			new_plasma.plane = GAME_PLANE
			flood_images += new_plasma
			flood_image_holders += pih
			flood_turfs += T
	if(target.client)
		target.client.images |= flood_images

/datum/hallucination/fake_flood/Destroy()
	STOP_PROCESSING(SSobj, src)
	qdel(flood_turfs)
	flood_turfs = list()
	if(target.client)
		target.client.images.Remove(flood_images)
	qdel(flood_images)
	flood_images = list()
	qdel(flood_image_holders)
	flood_image_holders = list()
	return ..()
*/
/obj/effect/hallucination/simple/xeno
	image_icon = 'icons/mob/alien.dmi'
	image_state = "alienh_pounce"

/obj/effect/hallucination/simple/xeno/Initialize(mapload, mob/living/carbon/T)
	. = ..()
	name = "alien hunter ([rand(1, 1000)])"

/obj/effect/hallucination/simple/xeno/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	update_icon("alienh_pounce")
	if(hit_atom == target && target.stat!=DEAD)
		target.Paralyze(100)
		target.visible_message("<span class='danger'>[target] flails around wildly.</span>","<span class='userdanger'>[name] pounces on you!</span>")

// The numbers of seconds it takes to get to each stage of the xeno attack choreography
#define XENO_ATTACK_STAGE_LEAP_AT_TARGET 1
#define XENO_ATTACK_STAGE_LEAP_AT_PUMP 2
#define XENO_ATTACK_STAGE_CLIMB 3
#define XENO_ATTACK_STAGE_FINISH 6

/// Xeno crawls from nearby vent,jumps at you, and goes back in
/datum/hallucination/xeno_attack
	var/turf/pump_location = null
	var/obj/effect/hallucination/simple/xeno/xeno = null
	var/time_processing = 0
	var/stage = XENO_ATTACK_STAGE_LEAP_AT_TARGET

/datum/hallucination/xeno_attack/New(mob/living/carbon/C, forced = TRUE)
	..()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/U in orange(7,target))
		if(!U.welded)
			pump_location = get_turf(U)
			break

	if(pump_location)
		feedback_details += "Vent Coords: [pump_location.x],[pump_location.y],[pump_location.z]"
		xeno = new(pump_location, target)
		START_PROCESSING(SSfastprocess, src)
	else
		qdel(src)

/datum/hallucination/xeno_attack/process(delta_time)
	time_processing += delta_time

	if (time_processing >= stage)
		switch (time_processing)
			if (XENO_ATTACK_STAGE_FINISH to INFINITY)
				to_chat(target, "<span class='notice'>[xeno.name] scrambles into the ventilation ducts!</span>")
				qdel(src)
			if (XENO_ATTACK_STAGE_CLIMB to XENO_ATTACK_STAGE_FINISH)
				to_chat(target, "<span class='notice'>[xeno.name] begins climbing into the ventilation system...</span>")
				stage = XENO_ATTACK_STAGE_FINISH
			if (XENO_ATTACK_STAGE_LEAP_AT_PUMP to XENO_ATTACK_STAGE_CLIMB)
				xeno.update_icon("alienh_leap",'icons/mob/alienleap.dmi', -32, -32)
				xeno.throw_at(pump_location, 7, 1, spin = FALSE, diagonals_first = TRUE)
				stage = XENO_ATTACK_STAGE_CLIMB
			if (XENO_ATTACK_STAGE_LEAP_AT_TARGET to XENO_ATTACK_STAGE_LEAP_AT_PUMP)
				xeno.update_icon("alienh_leap",'icons/mob/alienleap.dmi', -32, -32)
				xeno.throw_at(target, 7, 1, spin = FALSE, diagonals_first = TRUE)
				stage = XENO_ATTACK_STAGE_LEAP_AT_PUMP

/datum/hallucination/xeno_attack/Destroy()
	. = ..()

	STOP_PROCESSING(SSfastprocess, src)
	QDEL_NULL(xeno)
	pump_location = null

#undef XENO_ATTACK_STAGE_LEAP_AT_TARGET
#undef XENO_ATTACK_STAGE_LEAP_AT_PUMP
#undef XENO_ATTACK_STAGE_CLIMB
#undef XENO_ATTACK_STAGE_FINISH

/obj/effect/hallucination/simple/clown
	image_icon = 'icons/mob/animal.dmi'
	image_state = "clown"

/obj/effect/hallucination/simple/clown/Initialize(mapload, mob/living/carbon/T, duration)
	..(loc, T)
	name = pick(GLOB.clown_names)
	QDEL_IN(src,duration)

/obj/effect/hallucination/simple/clown/scary
	image_state = "scary_clown"

/obj/effect/hallucination/simple/bubblegum
	name = "Unknown Antediluvian"
	image_icon = 'icons/mob/32x64.dmi'
	image_state = "eva"
//	px = -32

/datum/hallucination/oh_yeah
	var/obj/effect/hallucination/simple/bubblegum/bubblegum
	var/image/fakebroken
	var/image/fakerune
	var/turf/landing
	var/charged
	var/next_action = 0

/datum/hallucination/oh_yeah/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	. = ..()
	var/turf/closed/wall/wall
	for(var/turf/closed/wall/W in range(7,target))
		wall = W
		break
	if(!wall)
		return INITIALIZE_HINT_QDEL
	feedback_details += "Source: [wall.x],[wall.y],[wall.z]"

	fakebroken = image('icons/turf/floors.dmi', wall, "plating", layer = TURF_LAYER)
	landing = get_turf(target)
	var/turf/landing_image_turf = get_step(landing, SOUTHWEST) //the icon is 3x3
	fakerune = image('icons/effects/96x96.dmi', landing_image_turf, "landing", layer = ABOVE_OPEN_TURF_LAYER)
	fakebroken.override = TRUE
	if(target.client)
		target.client.images |= fakebroken
		target.client.images |= fakerune
	target.playsound_local(wall,'sound/effects/meteorimpact.ogg', 150, 1)
	bubblegum = new(wall, target)
	addtimer(CALLBACK(src, PROC_REF(start_processing)), 10)

/datum/hallucination/oh_yeah/proc/start_processing()
	if (isnull(target))
		qdel(src)
		return
	START_PROCESSING(SSfastprocess, src)

/datum/hallucination/oh_yeah/process(delta_time)
	next_action -= delta_time

	if (next_action > 0)
		return

	if (get_turf(bubblegum) != landing && target?.stat != DEAD)
		if(!landing || (get_turf(bubblegum)).loc.z != landing.loc.z)
			qdel(src)
			return
		bubblegum.forceMove(get_step_towards(bubblegum, landing))
		bubblegum.setDir(get_dir(bubblegum, landing))
		target.playsound_local(get_turf(bubblegum), 'sound/effects/meteorimpact.ogg', 150, 1)
		shake_camera(target, 2, 1)
		if(bubblegum.Adjacent(target) && !charged)
			charged = TRUE
			target.Paralyze(80)
			target.adjustStaminaLoss(40)
			step_away(target, bubblegum)
			shake_camera(target, 4, 3)
			target.visible_message("<span class='warning'>[target] jumps backwards, falling on the ground!</span>","<span class='userdanger'>[bubblegum] slams into you!</span>")
		next_action = 0.2
	else
		STOP_PROCESSING(SSfastprocess, src)
		QDEL_IN(src, 3 SECONDS)

/datum/hallucination/oh_yeah/Destroy()
	if(target.client)
		target.client.images.Remove(fakebroken)
		target.client.images.Remove(fakerune)
	QDEL_NULL(fakebroken)
	QDEL_NULL(fakerune)
	QDEL_NULL(bubblegum)
	STOP_PROCESSING(SSfastprocess, src)
	return ..()

/datum/hallucination/battle
	var/battle_type
	var/iterations_left
	var/hits = 0
	var/next_action = 0
	var/turf/source

/datum/hallucination/battle/New(mob/living/carbon/C, forced = TRUE, new_battle_type)
	..()

	source = random_far_turf()

	battle_type = new_battle_type
	if (isnull(battle_type))
		battle_type = pick("laser", "disabler", "voidblink", "gun", "staking", "chainsaw", "bomb")
	feedback_details += "Type: [battle_type]"
	var/process = TRUE

	switch(battle_type)
		if("disabler", "laser")
			iterations_left = rand(5, 10)
		if("voidblink")
			iterations_left = rand(4, 8)
			target.playsound_local(source, 'sound/magic/voidblink.ogg',15, 1)
		if("gun")
			iterations_left = rand(3, 6)
		if("staking") //Staking + handcuff
			process = FALSE
			target.playsound_local(source, 'sound/weapons/bladeslice.ogg', 40, 1)
			target.playsound_local(source, get_sfx("bodyfall"), 25, 1)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'sound/weapons/handcuffs.ogg', 15, 1), 20)
		if("chainsaw") //zap n slap
			iterations_left = rand(5, 12)
			target.playsound_local(source, 'sound/weapons/chainsawhit.ogg', 40, 1)
			target.playsound_local(source, get_sfx("bodyfall"), 25, 1)
			next_action = 2 SECONDS
		if("bomb") // Tick Tock
			iterations_left = rand(3, 11)

	if (process)
		START_PROCESSING(SSfastprocess, src)
	else
		qdel(src)

/datum/hallucination/battle/process(delta_time)
	next_action -= (delta_time * 10)

	if (next_action > 0)
		return

	switch (battle_type)
		if ("disabler", "laser", "gun")
			var/fire_sound
			var/hit_person_sound
			var/hit_wall_sound
			var/number_of_hits
			var/chance_to_fall

			switch (battle_type)
				if ("disabler")
					fire_sound = 'code/modules/wod13/sounds/ak.ogg'
					hit_person_sound = 'sound/effects/wounds/pierce3.ogg'
					hit_wall_sound = 'sound/weapons/pierce.ogg'
					number_of_hits = 3
					chance_to_fall = 70
				if ("laser")
					fire_sound = 'code/modules/wod13/sounds/rifle.ogg'
					hit_person_sound = 'sound/effects/wounds/pierce3.ogg'
					hit_wall_sound = 'sound/weapons/pierce.ogg'
					number_of_hits = 4
					chance_to_fall = 70
				if ("gun")
					fire_sound = 'sound/weapons/gun/shotgun/shot.ogg'
					hit_person_sound = 'sound/effects/wounds/pierce2.ogg'
					hit_wall_sound = "ricochet"
					number_of_hits = 2
					chance_to_fall = 80

			target.playsound_local(source, fire_sound, 25, 1)

			if(prob(50))
				addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, hit_person_sound, 25, 1), rand(5,10))
				hits += 1
			else
				addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, hit_wall_sound, 25, 1), rand(5,10))

			next_action = rand(CLICK_CD_RANGE, CLICK_CD_RANGE + 6)

			if(hits >= number_of_hits && prob(chance_to_fall))
				addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, get_sfx("bodyfall"), 25, 1), next_action)
				qdel(src)
				return
		if ("esword")
			target.playsound_local(source, 'sound/weapons/rapierhit.ogg', 50, 1)

			if (hits == 4)
				target.playsound_local(source, get_sfx("bodyfall"), 25, 1)

			next_action = rand(CLICK_CD_MELEE, CLICK_CD_MELEE + 6)
			hits += 1

			if (iterations_left == 1)
				target.playsound_local(source, 'sound/magic/ethereal_enter.ogg', 15, 1)
		if ("chainsaw")
			target.playsound_local(source, 'sound/weapons/chainsawhit.ogg', 50, 1)
			next_action = rand(CLICK_CD_MELEE, CLICK_CD_MELEE + 4)
		if ("bomb")
			target.playsound_local(source, 'sound/items/timer.ogg', 25, 0)
			next_action = 15

	iterations_left -= 1
	if (iterations_left == 0)
		qdel(src)

/datum/hallucination/battle/Destroy()
	. = ..()
	source = null
	STOP_PROCESSING(SSfastprocess, src)

/datum/hallucination/items_other

/datum/hallucination/items_other/New(mob/living/carbon/C, forced = TRUE, item_type)
	set waitfor = FALSE
	..()
	var/item
	if(!item_type)
		item = pick(list("esword","taser","ebow","baton","dual_esword","ttv","flash","armblade"))
	else
		item = item_type
	feedback_details += "Item: [item]"
	var/side
	var/image_file
	var/image/A = null
	var/list/mob_pool = list()

	for(var/mob/living/carbon/human/M in view(7,target))
		if(M != target)
			mob_pool += M
	if(!mob_pool.len)
		return

	var/mob/living/carbon/human/H = pick(mob_pool)
	feedback_details += " Mob: [H.real_name]"

	var/free_hand = H.get_empty_held_index_for_side(LEFT_HANDS)
	if(free_hand)
		side = "left"
	else
		free_hand = H.get_empty_held_index_for_side(RIGHT_HANDS)
		if(free_hand)
			side = "right"

	if(side)
		switch(item)
			if("esword")
				if(side == "right")
					image_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
				target.playsound_local(H, 'sound/weapons/saberon.ogg',35,1)
				A = image(image_file,H,"swordred", layer=ABOVE_MOB_LAYER)
			if("dual_esword")
				if(side == "right")
					image_file = 'icons/mob/inhands/weapons/swords_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/weapons/swords_lefthand.dmi'
				target.playsound_local(H, 'sound/weapons/saberon.ogg',35,1)
				A = image(image_file,H,"dualsaberred1", layer=ABOVE_MOB_LAYER)
			if("taser")
				if(side == "right")
					image_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
				A = image(image_file,H,"advtaserstun4", layer=ABOVE_MOB_LAYER)
			if("ebow")
				if(side == "right")
					image_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
				A = image(image_file,H,"crossbow", layer=ABOVE_MOB_LAYER)
			if("baton")
				if(side == "right")
					image_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
				target.playsound_local(H, "sparks",75,1,-1)
				A = image(image_file,H,"baton", layer=ABOVE_MOB_LAYER)
			if("ttv")
				if(side == "right")
					image_file = 'icons/mob/inhands/weapons/bombs_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/weapons/bombs_lefthand.dmi'
				A = image(image_file,H,"ttv", layer=ABOVE_MOB_LAYER)
			if("flash")
				if(side == "right")
					image_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
				A = image(image_file,H,"flashtool", layer=ABOVE_MOB_LAYER)
			if("armblade")
				if(side == "right")
					image_file = 'icons/mob/inhands/antag/changeling_righthand.dmi'
				else
					image_file = 'icons/mob/inhands/antag/changeling_lefthand.dmi'
				target.playsound_local(H, 'sound/effects/blobattack.ogg',30,1)
				A = image(image_file,H,"arm_blade", layer=ABOVE_MOB_LAYER)
		if(target.client)
			target.client.images |= A
			addtimer(CALLBACK(src, PROC_REF(cleanup), item, A, H), rand(15 SECONDS, 25 SECONDS))
			return
	qdel(src)

/datum/hallucination/items_other/proc/cleanup(item, atom/image_used, has_the_item)
	if (isnull(target))
		qdel(src)
		return
	if(item == "esword" || item == "dual_esword")
		target.playsound_local(has_the_item, 'sound/weapons/saberoff.ogg',35,1)
	if(item == "armblade")
		target.playsound_local(has_the_item, 'sound/effects/blobattack.ogg',30,1)
	target.client.images.Remove(image_used)
	qdel(src)

/datum/hallucination/delusion
	var/list/image/delusions = list()

/datum/hallucination/delusion/New(mob/living/carbon/C, forced, force_kind = null , duration = 300,skip_nearby = TRUE, custom_icon = null, custom_icon_file = null, custom_name = null)
	set waitfor = FALSE
	. = ..()
	var/image/A = null
	var/kind = force_kind ? force_kind : pick("nothing","monkey","corgi","carp","skeleton","demon","zombie")
	feedback_details += "Type: [kind]"
	var/list/nearby
	if(skip_nearby)
		nearby = get_hearers_in_view(7, target)
	for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
		if(H == target)
			continue
		if(skip_nearby && (H in nearby))
			continue
		switch(kind)
			if("nothing")
				A = image('icons/effects/effects.dmi',H,"nothing")
				A.name = "..."
			if("monkey")//Monkey
				A = image('icons/wod13/32x48.dmi',H,"baali")
				A.name = "Infernalist"
			if("carp")//Carp
				A = image('icons/wod13/48x64.dmi',H,"4armstzi")
				A.name = "zulo"
			if("corgi")//Corgi
				A = image('icons/wod13/mobs.dmi',H,"dog")
				A.name = "dog"
			if("skeleton")//Skeletons
				A = image('icons/mob/human.dmi',H,"skeleton")
				A.name = "Skeleton"
			if("zombie")//Zombies
				A = image('icons/mob/human.dmi',H,"zombie")
				A.name = "Zombie"
			if("demon")//Demon
				A = image('icons/mob/mob.dmi',H,"daemon")
				A.name = "Demon"
			if("custom")
				A = image(custom_icon_file, H, custom_icon)
				A.name = custom_name
		A.override = 1
		if(target.client)
			delusions |= A
			target.client.images |= A
	if(duration)
		QDEL_IN(src, duration)

/datum/hallucination/delusion/Destroy()
	for(var/image/I in delusions)
		if(target.client)
			target.client.images.Remove(I)
	return ..()

/datum/hallucination/self_delusion
	var/image/delusion

/datum/hallucination/self_delusion/New(mob/living/carbon/C, forced, force_kind = null , duration = 300, custom_icon = null, custom_icon_file = null, wabbajack = TRUE) //set wabbajack to false if you want to use another fake source
	set waitfor = FALSE
	..()
	var/image/A = null
	var/kind = force_kind ? force_kind : pick("monkey","corgi","carp","skeleton","demon","zombie","robot")
	feedback_details += "Type: [kind]"
	switch(kind)
		if("monkey")//Monkey
			A = image('icons/wod13/32x48.dmi',target,"baali")
		if("carp")//Carp
			A = image('icons/wod13/48x64.dmi',target,"4armstzi")
		if("corgi")//Corgi
			A = image('icons/wod13/mobs.dmi',target,"dog")
		if("skeleton")//Skeletons
			A = image('icons/mob/human.dmi',target,"skeleton")
		if("zombie")//Zombies
			A = image('icons/mob/human.dmi',target,"zombie")
		if("demon")//Demon
			A = image('icons/mob/mob.dmi',target,"daemon")
		if("robot")//Cyborg
			A = image('icons/wod13/werewolf.dmi',target,"white")
		if("custom")
			A = image(custom_icon_file, target, custom_icon)
	A.override = 1
	if(target.client)
		if(wabbajack)
			to_chat(target, "<span class='hear'>...wabbajack...wabbajack...</span>")
			target.playsound_local(target,'sound/magic/staff_change.ogg', 50, 1)
		delusion = A
		target.client.images |= A
	QDEL_IN(src, duration)

/datum/hallucination/self_delusion/Destroy()
	if(target.client)
		target.client.images.Remove(delusion)
	return ..()
/*
/datum/hallucination/bolts
	var/list/airlocks_to_hit
	var/list/locks
	var/next_action = 0
	var/locking = TRUE

/datum/hallucination/bolts/New(mob/living/carbon/C, forced, door_number)
	set waitfor = FALSE
	..()
	if(!door_number)
		door_number = rand(0,4) //if 0 bolts all visible doors
	var/count = 0
	feedback_details += "Door amount: [door_number]"

	for(var/obj/machinery/door/airlock/A in range(7, target))
		if(count>door_number && door_number>0)
			break
		if(!A.density)
			continue
		count++
		LAZYADD(airlocks_to_hit, A)

	START_PROCESSING(SSfastprocess, src)

/datum/hallucination/bolts/process(delta_time)
	next_action -= (delta_time * 10)
	if (next_action > 0)
		return

	if (locking)
		var/atom/next_airlock = pop(airlocks_to_hit)
		if (next_airlock)
			var/obj/effect/hallucination/fake_door_lock/lock = new(get_turf(next_airlock))
			lock.target = target
			lock.airlock = next_airlock
			LAZYADD(locks, lock)

		if (!LAZYLEN(airlocks_to_hit))
			locking = FALSE
			next_action = 10 SECONDS
			return
	else
		var/obj/effect/hallucination/fake_door_lock/next_unlock = popleft(locks)
		if (next_unlock)
			next_unlock.unlock()
		else
			qdel(src)
			return

	next_action = rand(4, 12)

/datum/hallucination/bolts/Destroy()
	. = ..()
	QDEL_LIST(locks)
	STOP_PROCESSING(SSfastprocess, src)

/obj/effect/hallucination/fake_door_lock
	layer = CLOSED_DOOR_LAYER + 1 //for Bump priority
	var/image/bolt_light
	var/obj/machinery/door/airlock/airlock

/obj/effect/hallucination/fake_door_lock/proc/lock()
	bolt_light = image(airlock.overlays_file, get_turf(airlock), "lights_bolts",layer=airlock.layer+0.1)
	if(target.client)
		target.client.images |= bolt_light
		target.playsound_local(get_turf(airlock), 'sound/machines/boltsdown.ogg',30,0,3)

/obj/effect/hallucination/fake_door_lock/proc/unlock()
	if(target.client)
		target.client.images.Remove(bolt_light)
		target.playsound_local(get_turf(airlock), 'sound/machines/boltsup.ogg',30,0,3)
	qdel(src)

/obj/effect/hallucination/fake_door_lock/CanAllowThrough(atom/movable/mover, turf/_target)
	. = ..()
	if(mover == target && airlock.density)
		return FALSE
*/
/datum/hallucination/chat

/datum/hallucination/chat/New(mob/living/carbon/C, forced = TRUE, force_radio, specific_message)
	set waitfor = FALSE
	..()
	var/target_name = target.first_name()
	var/speak_messages = list("[pick_list_replacements(HAL_LINES_FILE, "suspicion")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "conversation")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "greetings")][target.first_name()]!",\
		"[pick_list_replacements(HAL_LINES_FILE, "getout")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "weird")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "didyouhearthat")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "doubt")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "aggressive")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "help")]!!",\
		"[pick_list_replacements(HAL_LINES_FILE, "escape")]",\
		"[pick_list_replacements(HAL_LINES_FILE, "infection_advice")]!")

	var/radio_messages = list("[pick_list_replacements(HAL_LINES_FILE, "people")] - [pick_list_replacements(HAL_LINES_FILE, "accusations")]!",\
		"Help!",\
		"[pick_list_replacements(HAL_LINES_FILE, "threat")] [pick_list_replacements(HAL_LINES_FILE, "location")][prob(50)?"!":"!!"]",\
		"[pick("Where did [target.first_name()] go?", "[target.first_name()]...")]",\
		"Bone round in melody and word layed in rain.",\
		"Cemetery runoff congealing at the door.",\
		"Maggots love you. Trust me.",\
		"Mast lay shrouded and the moon is melting.",\
		"Try the corpse in the oven with peppers and fur.",\
		"Souls draped in rotten tatters and Father dances in the dark.",\
		"Make the tallow from the fat of a hangman.",\
		"I smell a rancid grave.",\
		"You're in for it now.",\
		"Rustling robes of the Reaper.",\
		"All are blind whose eyes are closed.",\
		"Look at it, bent like a calf for the butcher.",\
		"The drove is a terrible mistress.",\
		"Whishes and words sprout from the same seed.",\
		"A dark light from your death.",\
		"Hemlock for the deceivers.",\
		"I cast a crooked shadow.",\
		"I have two mouths to lick from.",\
		"Deep in the Atlantic, the Ark, dreaming, sleeping.",\
		"Can't see, can't see! Where have my eyes gone to?",\
		"Heloise said you. Cranberry sauce. Hotel foxtrot.",\
		"Stop doing that. Mother shan't be too pleased. None too pleased.",\
		"It's a tangle of asps.",\
		"Those lips bleed a putrid poison.",\
		"Sealed with the kiss of swine.",\
		"Rat tails, cat tails, coat tails, all tales.",\
		"A trick with two tongues.",\
		"It's not fair! I wanted to.",\
		"Pennies for your eyes in its pockets.",\
		"Why is it troubled?",\
		"Ask about the free arsenic.",\
		"Blood brings the vicious beast.",\
		"I see daggers hang on his breath.",\
		"The very thought falls to the flame.",\
		)

	var/mob/living/carbon/person = null
	var/datum/language/understood_language = target.get_random_understood_language()
	for(var/mob/living/carbon/H in view(target))
		if(H == target)
			continue
		if(!person)
			person = H
		else
			if(get_dist(target,H)<get_dist(target,person))
				person = H

	// Get person to affect if radio hallucination
	var/is_radio = !person || force_radio
	if (is_radio)
		var/list/humans = list()
		for(var/mob/living/carbon/human/H in GLOB.alive_mob_list)
			humans += H
		person = pick(humans)

	// Generate message
	is_radio = FALSE //minimally disable radio hallucinations here. TODO: either make the radio hallucinations match the wod13 radio messages or remove them altogether
	var/spans = list(person.speech_span)
	var/chosen = !specific_message ? capitalize(pick(is_radio ? speak_messages : radio_messages)) : specific_message
	chosen = replacetext(chosen, "%TARGETNAME%", target_name)
	var/message = target.compose_message(person, understood_language, chosen, is_radio ? "[FREQ_COMMON]" : null, spans, face_name = TRUE)
	feedback_details += "Type: [is_radio ? "Radio" : "Talk"], Source: [person.real_name], Message: [message]"

	// Display message
	if (!is_radio && !target.client?.prefs.chat_on_map)
		var/image/speech_overlay = image('icons/mob/talk.dmi', person, "default0", layer = ABOVE_MOB_LAYER)
		INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flick_overlay), speech_overlay, list(target.client), 30)
	if (target.client?.prefs.chat_on_map)
		target.create_chat_message(person, understood_language, chosen, spans)
	to_chat(target, message)
	qdel(src)

/datum/hallucination/message

/datum/hallucination/message/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	var/list/mobpool = list()
	var/mob/living/carbon/human/other
	var/close_other = FALSE
	for(var/mob/living/carbon/human/H in oview(target, 7))
		if(get_dist(H, target) <= 1)
			other = H
			close_other = TRUE
			break
		mobpool += H
	if(!other && mobpool.len)
		other = pick(mobpool)

	var/list/message_pool = list()
	if(other)
		if(close_other) //increase the odds
			for(var/i in 1 to 5)
				message_pool.Add("<span class='warning'>You feel a tiny prick!</span>")
		var/obj/item/storage/equipped_backpack = other.get_item_by_slot(ITEM_SLOT_BACK)
		if(istype(equipped_backpack))
			for(var/i in 1 to 5) //increase the odds
				message_pool.Add("<span class='notice'>[other] puts the [pick(\
					"revolver","lockpick","Blood Hunt Announcer","unidentified occult object","cross",\
					"molotov","katana","Arcane Tome","Steyr AUG","CAR-15","Sarcophagus Key",\
					"ritual dagger","Book of Nod",\
					"Chronicle of Caine", "Chronicle of Shadows", "chronicle of secrets",\
					"crossbow","Sargon Fragment","True Vessel","Femur of Toomler","Vestment of Vileness","Spriggan's Jar","Cup of Christ"\
					)] into [equipped_backpack].</span>")

		message_pool.Add("<B>[other]</B> [pick("sneezes","coughs")].")

	message_pool.Add("<span class='notice'>You hear the ghost of Maria Asunción weep...</span>", \
		"<span class='notice'>Your [pick("arm", "leg", "back", "head")] itches.</span>",\
		"<span class='warning'>You feel [pick("hot","cold","dry","wet","woozy","faint")].</span>",
		"<span class='warning'>Your head hurts.</span>",
		"<span class='warning'>You hear a faint buzz in your head.</span>",
		"<B>[target]</B> sneezes.")
	if(prob(10))
		message_pool.Add("<span class='warning'>Behind you.</span>",\
			"<span class='warning'>You hear a faint laughter.</span>",
			"<span class='warning'>You see something move.</span>",
			"<span class='warning'>You hear skittering on the ceiling.</span>",
			"<span class='warning'>You see the silhouette of an Antediluvian moving in the distance.</span>")
	if(prob(10))
		message_pool.Add("[pick_list_replacements(HAL_LINES_FILE, "advice")]")
	var/chosen = pick(message_pool)
	feedback_details += "Message: [chosen]"
	to_chat(target, chosen)
	qdel(src)

/datum/hallucination/sounds

/datum/hallucination/sounds/New(mob/living/carbon/C, forced = TRUE, sound_type)
	set waitfor = FALSE
	..()
	var/turf/source = random_far_turf()
	if(!sound_type)
		sound_type = pick("bloodneed","awo1","behind","sus","prepare","vis","brick","frenzy","call","door stuck","door hack")
	feedback_details += "Type: [sound_type]"
	//Strange audio
	switch(sound_type)
		if("bloodneed")
			target.playsound_local(source,'code/modules/wod13/sounds/bloodneed.ogg', 50, 1)
		if("behind")
			target.playsound_local(source,'code/modules/wod13/sounds/behind.ogg', 100, 1)
			to_chat(C, "<span class='danger'><B>Behind you.</B></span>")
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'code/modules/wod13/sounds/bumps.ogg', 30, 1), 50)
		if("sus")
			target.playsound_local(source,'code/modules/wod13/sounds/sus.ogg', 75, 1)
		if("awo1")
			if(prob(50))
				target.playsound_local(source,'code/modules/wod13/sounds/awo1.ogg', 50, 1)
			else
				target.playsound_local(source, 'code/modules/wod13/sounds/awo2.ogg', 50, 1)
		if("prepare")
			target.playsound_local(source, 'code/modules/wod13/sounds/prepare-thyself.ogg', 50, 1)
		if("vis")
			target.playsound_local(source, pick('code/modules/wod13/sounds/visceratika.ogg','code/modules/wod13/sounds/vicissitude.ogg'), 50, 1)
		if("brick")
			target.playsound_local(source, 'code/modules/wod13/sounds/nokia.ogg', 100, 0)
		if("frenzy")
			target.playsound_local(source, 'code/modules/wod13/sounds/frenzy.ogg', 50, 0)
		if("call")
			target.playsound_local(source, 'code/modules/wod13/sounds/call.ogg', 50, 0)
		//VAMPIRE POLICE. OPEN UP.
		if("door stuck")
			target.playsound_local(source, 'code/modules/wod13/sounds/door_locked.ogg', 50, 1)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'code/modules/wod13/sounds/potence_activate.ogg', 50, 1), 105)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'code/modules/wod13/sounds/get_bent.ogg', 50, 1), 120)
		//Hacking a door
		if("door hack")
			target.playsound_local(source, 'code/modules/wod13/sounds/hack.ogg', 50, 1)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'sound/machines/door_open.ogg', 30, 1), rand(40, 80))
	qdel(src)

/datum/hallucination/weird_sounds

/datum/hallucination/weird_sounds/New(mob/living/carbon/C, forced = TRUE, sound_type)
	set waitfor = FALSE
	..()
	var/turf/source = random_far_turf()
	if(!sound_type)
		sound_type = pick("phone","hallelujah","canon","laughter","orthodox","spoopy","creepy","ante")
	feedback_details += "Type: [sound_type]"
	//Strange audio
	switch(sound_type)
		if("phone")
			target.playsound_local(source, 'sound/weapons/ring.ogg', 15)
			for (var/next_rings in 1 to 3)
				addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'sound/weapons/ring.ogg', 15), 25 * next_rings)
		if("orthodox")
			target.playsound_local(null, 'code/modules/wod13/sounds/orthodox_start.ogg', 75)
		if("hallelujah")
			target.playsound_local(source, 'code/modules/wod13/sounds/cross.ogg', 75)
		if("canon")
			target.playsound_local(null, 'code/modules/wod13/sounds/canon.ogg', 75)
		if("spoopy")
			target.playsound_local(source, 'code/modules/wod13/sounds/fuck.ogg', 50)
		if("laughter")
			if(prob(50))
				target.playsound_local(source, 'sound/mobs/humanoids/human/laugh/womanlaugh.ogg', 50, 1)
			else
				target.playsound_local(source, pick('sound/mobs/humanoids/human/laugh/manlaugh1.ogg', 'sound/mobs/humanoids/human/laugh/manlaugh2.ogg'), 50, 1)
		if("creepy")
		//These sounds are (mostly) taken from Hidden: Source
			target.playsound_local(source, pick(GLOB.creepy_ambience), 50, 1)
		if("ante") //Antediluvian loose!
			target.playsound_local(source, 'code/modules/wod13/sounds/mp_end.ogg', 35, 1)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'code/modules/wod13/sounds/mp_judgement.ogg', 65, 1), 30)
			addtimer(CALLBACK(target, TYPE_PROC_REF(/mob, playsound_local), source, 'code/modules/wod13/sounds/mp_die.ogg', 100, 1), 60)

	qdel(src)

/*
/datum/hallucination/stationmessage

/datum/hallucination/stationmessage/New(mob/living/carbon/C, forced = TRUE, message)
	set waitfor = FALSE
	..()
	if(!message)
		message = pick("ratvar","shuttle dock","blob alert","malf ai","meteors","supermatter")
	feedback_details += "Type: [message]"
	switch(message)
		if("blob alert")
			to_chat(target, "<h1 class='alert'>Biohazard Alert</h1>")
			to_chat(target, "<br><br><span class='alert'>Confirmed outbreak of level 5 biohazard aboard [station_name()]. All personnel must contain the outbreak.</span><br><br>")
			SEND_SOUND(target, 'sound/ai/outbreak5.ogg')
		if("ratvar")
			target.playsound_local(target, 'sound/machines/clockcult/ark_deathrattle.ogg', 50, FALSE, pressure_affected = FALSE)
			target.playsound_local(target, 'sound/effects/clockcult_gateway_disrupted.ogg', 50, FALSE, pressure_affected = FALSE)
			addtimer(CALLBACK(
				target,
				/mob/proc/playsound_local,
				target,
				'sound/effects/explosion_distant.ogg',
				50,
				FALSE,
				/* frequency = */ null,
				/* falloff_exponential = */ null,
				/* channel = */ null,
				/* pressure_affected = */ FALSE
			), 27)
		if("shuttle dock")
			to_chat(target, "<h1 class='alert'>Priority Announcement</h1>")
			to_chat(target, "<br><br><span class='alert'>The Emergency Shuttle has docked with the station. You have 3 minutes to board the Emergency Shuttle.</span><br><br>")
			SEND_SOUND(target, 'sound/ai/shuttledock.ogg')
		if("malf ai") //AI is doomsdaying!
			to_chat(target, "<h1 class='alert'>Anomaly Alert</h1>")
			to_chat(target, "<br><br><span class='alert'>Hostile runtimes detected in all station systems, please deactivate your AI to prevent possible damage to its morality core.</span><br><br>")
			SEND_SOUND(target, 'sound/ai/aimalf.ogg')
		if("meteors") //Meteors inbound!
			to_chat(target, "<h1 class='alert'>Meteor Alert</h1>")
			to_chat(target, "<br><br><span class='alert'>Meteors have been detected on collision course with the station.</span><br><br>")
			SEND_SOUND(target, 'sound/ai/meteors.ogg')
		if("supermatter")
			SEND_SOUND(target, 'sound/magic/charge.ogg')
			to_chat(target, "<span class='boldannounce'>You feel reality distort for a moment...</span>")

*/

/datum/hallucination/hudscrew

/datum/hallucination/hudscrew/New(mob/living/carbon/C, forced = TRUE, screwyhud_type)
	set waitfor = FALSE
	..()
	//Screwy HUD
	var/chosen_screwyhud = screwyhud_type
	if(!chosen_screwyhud)
		chosen_screwyhud = pick(SCREWYHUD_CRIT,SCREWYHUD_DEAD,SCREWYHUD_HEALTHY)
	target.set_screwyhud(chosen_screwyhud)
	feedback_details += "Type: [target.hal_screwyhud]"
	QDEL_IN(src, rand(100, 250))

/datum/hallucination/hudscrew/Destroy()
	target?.set_screwyhud(SCREWYHUD_NONE)
	return ..()

/*
/datum/hallucination/fake_alert
	var/alert_type

/datum/hallucination/fake_alert/New(mob/living/carbon/C, forced = TRUE, specific, duration = 150)
	set waitfor = FALSE
	..()
	alert_type = pick("not_enough_oxy","not_enough_tox","not_enough_co2","too_much_oxy","too_much_co2","too_much_tox","newlaw","nutrition","charge","gravity","fire","locked","hacked","temphot","tempcold","pressure")
	if(specific)
		alert_type = specific
	feedback_details += "Type: [alert_type]"
	switch(alert_type)
		if("not_enough_oxy")
			target.throw_alert(alert_type, /atom/movable/screen/alert/not_enough_oxy, override = TRUE)
		if("not_enough_tox")
			target.throw_alert(alert_type, /atom/movable/screen/alert/not_enough_tox, override = TRUE)
		if("not_enough_co2")
			target.throw_alert(alert_type, /atom/movable/screen/alert/not_enough_co2, override = TRUE)
		if("too_much_oxy")
			target.throw_alert(alert_type, /atom/movable/screen/alert/too_much_oxy, override = TRUE)
		if("too_much_co2")
			target.throw_alert(alert_type, /atom/movable/screen/alert/too_much_co2, override = TRUE)
		if("too_much_tox")
			target.throw_alert(alert_type, /atom/movable/screen/alert/too_much_tox, override = TRUE)
		if("nutrition")
			if(prob(50))
				target.throw_alert(alert_type, /atom/movable/screen/alert/fat, override = TRUE)
			else
				target.throw_alert(alert_type, /atom/movable/screen/alert/starving, override = TRUE)
		if("gravity")
			target.throw_alert(alert_type, /atom/movable/screen/alert/weightless, override = TRUE)
		if("fire")
			target.throw_alert(alert_type, /atom/movable/screen/alert/fire, override = TRUE)
		if("temphot")
			alert_type = "temp"
			target.throw_alert(alert_type, /atom/movable/screen/alert/hot, 3, override = TRUE)
		if("tempcold")
			alert_type = "temp"
			target.throw_alert(alert_type, /atom/movable/screen/alert/cold, 3, override = TRUE)
		if("pressure")
			if(prob(50))
				target.throw_alert(alert_type, /atom/movable/screen/alert/highpressure, 2, override = TRUE)
			else
				target.throw_alert(alert_type, /atom/movable/screen/alert/lowpressure, 2, override = TRUE)
		//BEEP BOOP I AM A ROBOT
		if("newlaw")
			target.throw_alert(alert_type, /atom/movable/screen/alert/newlaw, override = TRUE)
		if("locked")
			target.throw_alert(alert_type, /atom/movable/screen/alert/locked, override = TRUE)
		if("hacked")
			target.throw_alert(alert_type, /atom/movable/screen/alert/hacked, override = TRUE)
		if("charge")
			target.throw_alert(alert_type, /atom/movable/screen/alert/emptycell, override = TRUE)

	addtimer(CALLBACK(src, PROC_REF(cleanup)), duration)

/datum/hallucination/fake_alert/proc/cleanup()
	target.clear_alert(alert_type, clear_override = TRUE)
	qdel(src)


/datum/hallucination/items/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	//Strange items

	var/obj/halitem = new

	halitem = new
	var/obj/item/l_hand = target.get_item_for_held_index(1)
	var/obj/item/r_hand = target.get_item_for_held_index(2)
	var/l = ui_hand_position(target.get_held_index_of_item(l_hand))
	var/r = ui_hand_position(target.get_held_index_of_item(r_hand))
	var/list/slots_free = list(l,r)
	if(l_hand)
		slots_free -= l
	if(r_hand)
		slots_free -= r
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(!H.belt)
			slots_free += ui_belt
		if(!H.l_store)
			slots_free += ui_storage1
		if(!H.r_store)
			slots_free += ui_storage2
	if(slots_free.len)
		halitem.screen_loc = pick(slots_free)
		halitem.layer = ABOVE_HUD_LAYER
		halitem.plane = ABOVE_HUD_PLANE
		switch(rand(1,6))
			if(1) //revolver
				halitem.icon = 'icons/obj/guns/projectile.dmi'
				halitem.icon_state = "revolver"
				halitem.name = "Revolver"
			if(2) //c4
				halitem.icon = 'icons/obj/grenade.dmi'
				halitem.icon_state = "plastic-explosive0"
				halitem.name = "C4"
				if(prob(25))
					halitem.icon_state = "plasticx40"
			if(3) //sword
				halitem.icon = 'icons/obj/transforming_energy.dmi'
				halitem.icon_state = "sword0"
				halitem.name = "Energy Sword"
			if(4) //stun baton
				halitem.icon = 'icons/obj/items_and_weapons.dmi'
				halitem.icon_state = "stunbaton"
				halitem.name = "Stun Baton"
			if(5) //emag
				halitem.icon = 'icons/obj/card.dmi'
				halitem.icon_state = "emag"
				halitem.name = "Cryptographic Sequencer"
			if(6) //flashbang
				halitem.icon = 'icons/obj/grenade.dmi'
				halitem.icon_state = "flashbang1"
				halitem.name = "Flashbang"
		feedback_details += "Type: [halitem.name]"
		if(target.client)
			target.client.screen += halitem
		QDEL_IN(halitem, rand(150, 350))

	qdel(src)
*/
/datum/hallucination/dangerflash

/datum/hallucination/dangerflash/New(mob/living/carbon/C, forced = TRUE, danger_type)
	set waitfor = FALSE
	..()
	//Flashes of danger

	var/list/possible_points = list()
	for(var/turf/open/floor/F in view(target,world.view))
		possible_points += F
	if(possible_points.len)
		var/turf/open/floor/danger_point = pick(possible_points)
		if(!danger_type)
			danger_type = pick("lava","chasm","anomaly")
		switch(danger_type)
			if("lava")
				new /obj/effect/hallucination/danger/lava(danger_point, target)
			if("chasm")
				new /obj/effect/hallucination/danger/chasm(danger_point, target)
			if("anomaly")
				new /obj/effect/hallucination/danger/anomaly(danger_point, target)

	qdel(src)

/obj/effect/hallucination/danger
	var/image/image

/obj/effect/hallucination/danger/proc/show_icon()
	return

/obj/effect/hallucination/danger/proc/clear_icon()
	if(image && target.client)
		target.client.images -= image

/obj/effect/hallucination/danger/Initialize(mapload, _target)
	. = ..()
	target = _target
	show_icon()
	QDEL_IN(src, rand(200, 450))

/obj/effect/hallucination/danger/Destroy()
	clear_icon()
	. = ..()

/obj/effect/hallucination/danger/lava
	name = "lava"

/obj/effect/hallucination/danger/lava/show_icon()
	image = image('icons/turf/floors/lava.dmi', src, "lava-0", TURF_LAYER)
	if(target.client)
		target.client.images += image

/obj/effect/hallucination/danger/lava/Crossed(atom/movable/AM)
	. = ..()
	if(AM == target)
		target.adjustStaminaLoss(20)
		new /datum/hallucination/fire(target)

/obj/effect/hallucination/danger/chasm
	name = "chasm"

/obj/effect/hallucination/danger/chasm/show_icon()
	var/turf/target_loc = get_turf(target)
	image = image('icons/turf/floors/chasms.dmi', src, "chasms-[target_loc.smoothing_junction]", TURF_LAYER)
	if(target.client)
		target.client.images += image

/obj/effect/hallucination/danger/chasm/Crossed(atom/movable/AM)
	. = ..()
	if(AM == target)
		if(istype(target, /obj/effect/dummy/phased_mob))
			return
		to_chat(target, "<span class='userdanger'>You fall into the chasm!</span>")
		target.Paralyze(40)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), target, "<span class='notice'>It's surprisingly shallow.</span>"), 15)
		QDEL_IN(src, 30)

/obj/effect/hallucination/danger/anomaly
	name = "flux wave anomaly"

/obj/effect/hallucination/danger/anomaly/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/effect/hallucination/danger/anomaly/process(delta_time)
	if(DT_PROB(45, delta_time))
		step(src,pick(GLOB.alldirs))

/obj/effect/hallucination/danger/anomaly/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/effect/hallucination/danger/anomaly/show_icon()
	image = image('icons/effects/effects.dmi',src,"electricity2",OBJ_LAYER+0.01)
	if(target.client)
		target.client.images += image

/obj/effect/hallucination/danger/anomaly/Crossed(atom/movable/AM)
	. = ..()
	if(AM == target)
		new /datum/hallucination/shock(target)

/datum/hallucination/death

/datum/hallucination/death/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	target.set_screwyhud(SCREWYHUD_DEAD)
	target.Paralyze(300)
	target.silent += 10
	to_chat(target, "<span class='deadsay'><b>[target.real_name]</b> has died at <b>[get_area_name(target)]</b>.</span>")

	var/delay = 0

	if(prob(50))
		var/mob/fakemob
		var/list/dead_people = list()
		for(var/mob/dead/observer/G in GLOB.player_list)
			dead_people += G
		if(LAZYLEN(dead_people))
			fakemob = pick(dead_people)
		else
			fakemob = target //ever been so lonely you had to haunt yourself?
		if(fakemob)
			delay = rand(20, 50)
			addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(to_chat), target, "<span class='deadsay'><b>DEAD: [fakemob.name]</b> says, \"[pick("rip","why did i just drop dead?","hey [target.first_name()]","git gud","you too?","is the AI rogue?",\
				"i[prob(50)?" fucking":""] hate [pick("blood cult", "clock cult", "revenants", "this round","this","myself","admins","you")]")]\"</span>"), delay)

	addtimer(CALLBACK(src, PROC_REF(cleanup)), delay + rand(70, 90))

/datum/hallucination/death/proc/cleanup()
	if (target)
		target.set_screwyhud(SCREWYHUD_NONE)
		target.SetParalyzed(0)
		target.silent = FALSE
	qdel(src)

#define RAISE_FIRE_COUNT 3
#define RAISE_FIRE_TIME 3

/datum/hallucination/fire
	var/active = TRUE
	var/stage = 0
	var/image/fire_overlay
	var/fire_stack_num = 0.1

	var/next_action = 0
	var/times_to_lower_stamina
	var/fire_clearing = FALSE
	var/increasing_stages = TRUE
	var/time_spent = 0

/datum/hallucination/fire/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	target.set_fire_stacks(max(target.fire_stacks, fire_stack_num)) //Placebo flammability
	fire_overlay = image('icons/mob/OnFire.dmi', target, "Standing", ABOVE_MOB_LAYER)
	if(target.client)
		target.client.images += fire_overlay
	to_chat(target, "<span class='userdanger'>You're set on fire!</span>")
	target.throw_alert("fire", /atom/movable/screen/alert/fire, override = TRUE)
	times_to_lower_stamina = rand(5, 10)
	addtimer(CALLBACK(src, PROC_REF(start_expanding)), 20)

/datum/hallucination/fire/Destroy()
	. = ..()
	STOP_PROCESSING(SSfastprocess, src)

/datum/hallucination/fire/proc/start_expanding()
	if (isnull(target))
		qdel(src)
		return
	START_PROCESSING(SSfastprocess, src)

/datum/hallucination/fire/process(delta_time)
	if (isnull(target))
		qdel(src)
		return

	if(target.fire_stacks <= 0)
		clear_fire()

	time_spent += delta_time

	if (fire_clearing)
		next_action -= delta_time
		if (next_action < 0)
			stage -= 1
			update_temp()
			next_action += 3
	else if (increasing_stages)
		var/new_stage = min(round(time_spent / RAISE_FIRE_TIME), RAISE_FIRE_COUNT)
		if (stage != new_stage)
			stage = new_stage
			update_temp()

			if (stage == RAISE_FIRE_COUNT)
				increasing_stages = FALSE
	else if (times_to_lower_stamina)
		next_action -= delta_time
		if (next_action < 0)
			target.adjustStaminaLoss(15)
			next_action += 2
			times_to_lower_stamina -= 1
	else
		clear_fire()

/datum/hallucination/fire/proc/update_temp()
	if(stage <= 0)
		target.clear_alert("temp", clear_override = TRUE)
	else
		target.clear_alert("temp", clear_override = TRUE)
		target.throw_alert("temp", /atom/movable/screen/alert/hot, stage, override = TRUE)

/datum/hallucination/fire/proc/clear_fire()
	if(!active)
		return
	active = FALSE
	target.clear_alert("fire", clear_override = TRUE)
	if(target.client)
		target.client.images -= fire_overlay
	QDEL_NULL(fire_overlay)
	fire_clearing = TRUE
	next_action = 0
	target.fire_stacks = max(target.fire_stacks - fire_stack_num, 0)

#undef RAISE_FIRE_COUNT
#undef RAISE_FIRE_TIME

/datum/hallucination/shock
	var/image/shock_image
	var/image/electrocution_skeleton_anim

/datum/hallucination/shock/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	shock_image = image(target, target, dir = target.dir)
	shock_image.appearance_flags |= KEEP_APART
	shock_image.color = rgb(0,0,0)
	shock_image.override = TRUE
	electrocution_skeleton_anim = image('icons/mob/human.dmi', target, icon_state = "electrocuted_base", layer=ABOVE_MOB_LAYER)
	electrocution_skeleton_anim.appearance_flags |= RESET_COLOR|KEEP_APART
	to_chat(target, "<span class='userdanger'>You feel a powerful shock course through your body!</span>")
	if(target.client)
		target.client.images |= shock_image
		target.client.images |= electrocution_skeleton_anim
	addtimer(CALLBACK(src, PROC_REF(reset_shock_animation)), 40)
	target.playsound_local(get_turf(src), "sparks", 100, 1)
	target.staminaloss += 50
	target.Stun(40)
	target.jitteriness += 1000
	target.do_jitter_animation(target.jitteriness)
	addtimer(CALLBACK(src, PROC_REF(shock_drop)), 20)

/datum/hallucination/shock/proc/reset_shock_animation()
	if(target.client)
		target.client.images.Remove(shock_image)
		target.client.images.Remove(electrocution_skeleton_anim)

/datum/hallucination/shock/proc/shock_drop()
	target.jitteriness = max(target.jitteriness - 990, 10) //Still jittery, but vastly less
	target.Paralyze(60)

/datum/hallucination/husks
	var/image/halbody

/datum/hallucination/husks/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	var/list/possible_points = list()
	for(var/turf/open/floor/F in view(target,world.view))
		possible_points += F
	if(possible_points.len)
		var/turf/open/floor/husk_point = pick(possible_points)
		switch(rand(1,4))
			if(1)
				var/image/body = image('icons/mob/human.dmi',husk_point,"husk",TURF_LAYER)
				var/matrix/M = matrix()
				M.Turn(90)
				body.transform = M
				halbody = body
			if(2,3)
				halbody = image('icons/mob/human.dmi',husk_point,"husk",TURF_LAYER)
			if(4)
				halbody = image('icons/mob/alien.dmi',husk_point,"alienother",TURF_LAYER)

		if(target.client)
			target.client.images += halbody
		QDEL_IN(src, rand(30,50)) //Only seen for a brief moment.

/datum/hallucination/husks/Destroy()
	target?.client?.images -= halbody
	QDEL_NULL(halbody)
	return ..()

//hallucination projectile code in code/modules/projectiles/projectile/special.dm
/datum/hallucination/stray_bullet

/datum/hallucination/stray_bullet/New(mob/living/carbon/C, forced = TRUE)
	set waitfor = FALSE
	..()
	var/list/turf/startlocs = list()
	for(var/turf/open/T in view(world.view+1,target)-view(world.view,target))
		startlocs += T
	if(!startlocs.len)
		qdel(src)
		return
	var/turf/start = pick(startlocs)
	var/proj_type = pick(subtypesof(/obj/projectile/hallucination))
	feedback_details += "Type: [proj_type]"
	var/obj/projectile/hallucination/H = new proj_type(start)
	target.playsound_local(start, H.hal_fire_sound, 60, 1)
	H.hal_target = target
	H.preparePixelProjectile(target, start)
	H.fire()
	qdel(src)
