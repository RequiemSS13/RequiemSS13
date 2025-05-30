/obj/structure/vampdoor
	name = "\improper door"
	desc = "It opens and closes."
	icon = 'code/modules/wod13/doors.dmi'
	icon_state = "door-1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -16
	anchored = TRUE
	density = TRUE
	opacity = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

	var/baseicon = "door"

	var/closed = TRUE
	var/locked = FALSE
	var/door_broken = FALSE
	var/door_layer = ABOVE_ALL_MOB_LAYER
	var/lock_id = null
	var/glass = FALSE
	var/hacking = FALSE
	var/lockpick_timer = 17 //[Lucifernix] - Never have the lockpick timer lower than 7. At 7 it will unlock instantly!!
	var/lockpick_difficulty = LOCKDIFFICULTY_1

	var/open_sound = 'code/modules/wod13/sounds/door_open.ogg'
	var/close_sound = 'code/modules/wod13/sounds/door_close.ogg'
	var/lock_sound = 'code/modules/wod13/sounds/door_locked.ogg'
	var/burnable = FALSE

/obj/structure/vampdoor/New()
	..()
	switch(lockpick_difficulty) //This is fine because any overlap gets intercepted before
		if(LOCKDIFFICULTY_7 to INFINITY)
			lockpick_timer = LOCKTIMER_7
		if(LOCKDIFFICULTY_6 to LOCKDIFFICULTY_7)
			lockpick_timer = LOCKTIMER_6
		if(LOCKDIFFICULTY_5 to LOCKDIFFICULTY_6)
			lockpick_timer = LOCKTIMER_5
		if(LOCKDIFFICULTY_4 to LOCKDIFFICULTY_5)
			lockpick_timer = LOCKTIMER_4
		if(LOCKDIFFICULTY_3 to LOCKDIFFICULTY_4)
			lockpick_timer = LOCKTIMER_3
		if(LOCKDIFFICULTY_2 to LOCKDIFFICULTY_3)
			lockpick_timer = LOCKTIMER_2
		if(-INFINITY to LOCKDIFFICULTY_2) //LOCKDIFFICULTY_1 is basically the minimum so we can just do LOCKTIMER_1 from -INFINITY
			lockpick_timer = LOCKTIMER_1

/obj/structure/vampdoor/examine(mob/user)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/H = user
	if(!H.is_holding_item_of_type(/obj/item/vamp/keys/hack))
		return
	var/message //So the code isn't flooded with . +=, it's just a visual thing
	var/difference = H.get_wits() - lockpick_difficulty
	switch(difference)
		if(-INFINITY to -6)
			message = "<span class='warning'>This door looks extremely complicated. You figure you will have to be lucky to break it open."
		if(-5 to -4)
			message = "<span class='notice'>This door looks very complicated. You might need a few tries to lockpick it."
		if(-3 to 0) //Only 3 numbers here instead of 4.
			message = "<span class='notice'>This door looks mildly complicated. It shouldn't be too hard to lockpick it.</span>"
		if(1 to 4) //Impossible to break the lockpick from here on because minimum rand(1,20) will always move the value to 2.
			message = "<span class='nicegreen'>This door is somewhat simple. It should be pretty easy for you to lockpick it.</span>"
		if(5 to INFINITY) //Becomes guaranteed to lockpick at 9.
			message = "<span class='nicegreen'>This door is really simple to you. It should be very easy to lockpick it.</span>"
	. += "[message]"

/obj/structure/vampdoor/MouseDrop_T(atom/dropping, mob/user, params)
	. = ..()

	//Adds the component only once. We do it here & not in Initialize() because there are tons of windows & we don't want to add to their init times
	LoadComponent(/datum/component/leanable, dropping)

/obj/structure/vampdoor/proc/proc_unlock(method) //I am here so that dwelling doors can call me to properly process their alarms.
	return

/obj/structure/vampdoor/proc/break_door()
	name = "door frame"
	desc = "An empty door frame. Someone removed the door by force. A special door repair kit should be able to fix this."
	door_broken = 1
	density = 0
	opacity = 0
	layer = OPEN_DOOR_LAYER
	closed = FALSE
	locked = FALSE
	icon_state = "[baseicon]-b"
	update_icon()

/obj/structure/vampdoor/proc/fix_door()
	name = initial(name)
	desc = initial(desc)
	door_broken = 0
	density = 1
	if(!glass) opacity = 1
	layer = ABOVE_ALL_MOB_LAYER
	closed = TRUE
	locked = FALSE
	icon_state = "[baseicon]-1"
	update_icon()

/obj/structure/vampdoor/attack_hand(mob/user)
	. = ..()
	var/mob/living/N = user
	if(door_broken)
		to_chat(user,span_warning("There is no door to use here."))
		return
	if(locked)
		if(N.a_intent != INTENT_HARM)
			playsound(src, lock_sound, 75, TRUE)
			to_chat(user, "<span class='warning'>[src] is locked!</span>")
		else
			if(ishuman(user))
				pixel_z = pixel_z+rand(-1, 1)
				pixel_w = pixel_w+rand(-1, 1)
				playsound(src, 'code/modules/wod13/sounds/knock.ogg', 75, TRUE)
				to_chat(user, "<span class='warning'>[src] is locked!</span>")
		return

	if(closed)
		playsound(src, open_sound, 75, TRUE)
		icon_state = "[baseicon]-0"
		density = FALSE
		opacity = FALSE
		layer = OPEN_DOOR_LAYER
		to_chat(user, "<span class='notice'>You open [src].</span>")
		closed = FALSE
		SEND_SIGNAL(src, COMSIG_AIRLOCK_OPEN)
	else
		for(var/mob/living/L in src.loc)
			if(L)
				playsound(src, lock_sound, 75, TRUE)
				to_chat(user, "<span class='warning'>[L] is preventing you from closing [src].</span>")
				return
		playsound(src, close_sound, 75, TRUE)
		icon_state = "[baseicon]-1"
		density = TRUE
		if(!glass)
			opacity = TRUE
		layer = ABOVE_ALL_MOB_LAYER
		to_chat(user, "<span class='notice'>You close [src].</span>")
		closed = TRUE

/obj/structure/vampdoor/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/door_repair_kit))
		if(!door_broken)
			to_chat(user,span_warning("This door does not seem to be broken."))
			return
		var/obj/item/door_repair_kit/repair_kit = W
		if(hacking == TRUE) //This is basically an in-use indicator already
			to_chat(user,span_warning("Someone else seems to be using this door already."))
			return
		playsound(src, 'sound/items/ratchet.ogg', 50)
		hacking = 1
		if(do_after(user, 10 SECONDS,src))
			playsound(src, 'sound/items/deconstruct.ogg', 50)
			fix_door()
			qdel(repair_kit)
		hacking = 0
	if(istype(W, /obj/item/vamp/keys/hack))
		if(door_broken)
			to_chat(user,span_warning("There is no door to pick here."))
			return
		if(locked)
			hacking = TRUE
			proc_unlock(5)
			playsound(src, 'code/modules/wod13/sounds/hack.ogg', 100, TRUE)
			for(var/mob/living/carbon/human/npc/police/P in oviewers(7, src))
				if(P)
					P.Aggro(user)
			if(do_mob(user, src, max((lockpick_timer - user.get_wits() * 3), 2) SECONDS))
				switch(SSroll.storyteller_roll(user.get_wits() * 2 - lockpick_difficulty, 2, list(user), src))
					if(0)
						to_chat(user, "<span class='warning'>Your lockpick broke!</span>")
						qdel(W)
					if(1)
						to_chat(user, "<span class='warning'>You failed to pick the lock.</span>")
					else
						to_chat(user, "<span class='notice'>You pick the lock.</span>")
						locked = FALSE
				hacking = FALSE
				return
			else
				to_chat(user, "<span class='warning'>You stopped picking the lock.</span>")
				hacking = FALSE
				return
		else
			if (closed && lock_id) //yes, this is a thing you can extremely easily do in real life... FOR DOORS WITH LOCKS!
				to_chat(user, "<span class='notice'>You re-lock the door with your lockpick.</span>")
				locked = TRUE
				playsound(src, 'code/modules/wod13/sounds/hack.ogg', 100, TRUE)
				return
	else if(istype(W, /obj/item/vamp/keys))
		var/obj/item/vamp/keys/KEY = W
		if(door_broken)
			to_chat(user,span_warning("There is no door to open/close here."))
			return
		if(KEY.roundstart_fix)
			lock_id = pick(KEY.accesslocks)
			KEY.roundstart_fix = FALSE
		if(KEY.accesslocks)
			for(var/i in KEY.accesslocks)
				if(i == lock_id)
					if(!locked)
						playsound(src, lock_sound, 75, TRUE)
						to_chat(user, "[src] is now locked.")
						locked = TRUE
					else
						playsound(src, lock_sound, 75, TRUE)
						to_chat(user, "[src] is now unlocked.")
						proc_unlock("key")
						locked = FALSE

/obj/structure/vampdoor/proc/door_return_initial_state()
	pixel_z = initial(pixel_z)
	pixel_w = initial(pixel_w)

/obj/structure/vampdoor/proc/door_reset_callback()
	addtimer(CALLBACK(src, PROC_REF(door_return_initial_state)), 2)
