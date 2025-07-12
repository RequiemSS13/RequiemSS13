SUBSYSTEM_DEF(tides)
	name = "Tides"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DEFAULT

	var/list/coastline_turfs = list()

	var/list/surfers = list()


/datum/controller/subsystem/tides/Initialize()
	if(!coastline_turfs.len)
		CRASH("SStides initialized without any coastline! That's not good!")
	return ..()

/datum/controller/subsystem/tides/proc/send_to_shore(atom/movable/flotsam)
	if(surfers.Find(flotsam))
		return
	
	
	if(ismob(flotsam))
		if(!isliving(flotsam))
			return
		var/mob/living/soggy_lad = flotsam
		soggy_lad.Immobilize(130, TRUE)
		addtimer(CALLBACK(src, PROC_REF(knock_down), flotsam), 90)
		soggy_lad.extinguish_mob()
		if(soggy_lad.mind)
			to_chat(soggy_lad, span_userdanger("You are pulled beneath inky black waves! The current tosses you like a ragdoll!"))
			soggy_lad.add_client_colour(/datum/client_colour/glass_colour/darkblue)
			if(ishuman(soggy_lad))
				soggy_lad.AddElement(/datum/element/ui_button_shake_inventory_group, 16)
				soggy_lad.AddElement(/datum/element/ui_button_shake_wide_button_group, 1)
	else if(isobj(flotsam))
		var/obj/driftwood = flotsam
		driftwood.extinguish()
	else
		return
	
	surfers += flotsam
	playsound(get_turf(flotsam), 'sound/vtr13/water_splash.ogg', 100, TRUE)
	flotsam.alpha -= 255
	addtimer(CALLBACK(src, PROC_REF(wash_up), flotsam), 100)

/datum/controller/subsystem/tides/proc/knock_down(mob/living/soggy_lad)
	soggy_lad.Knockdown(50, TRUE)

/datum/controller/subsystem/tides/proc/wash_up(atom/movable/flotsam)
	flotsam.alpha += 255
	surfers -= flotsam
	if(isliving(flotsam))
		var/mob/living/soggy_lad = flotsam
		if(soggy_lad.mind)
			to_chat(soggy_lad, span_notice("You wash up on the shore, sogging wet."))
			soggy_lad.remove_client_colour(/datum/client_colour/glass_colour/darkblue)
		if(ishuman(soggy_lad))
			soggy_lad.RemoveElement(/datum/element/ui_button_shake_inventory_group, 16)
			soggy_lad.RemoveElement(/datum/element/ui_button_shake_wide_button_group, 1)
	flotsam.forceMove(pick(coastline_turfs))