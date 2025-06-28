/obj/machinery/computer/cargo/express_vtr
	name = "Cargo Computer"
	desc = "A computer used by the cargo staff to order supplies via a delivery truck."
	icon_screen = "supply_express"
	circuit = /obj/item/circuitboard/computer/cargo/express_vtr
	blockade_warning = "Bluespace instability detected. Delivery impossible."
	req_access = list(ACCESS_QM)
	is_express = TRUE

	var/list/order_queue = list()
	var/message
	var/printed_beacons = 0 //number of beacons printed. Used to determine beacon names.
	var/list/meme_pack_data
	var/list/supply_packs = list()
	var/obj/item/supplypod_beacon_vtr/beacon //the linked supplypod beacon
	var/area/landingzone = /area/quartermaster/storage //where we droppin boys
	var/podType = /obj/structure/closet/supplypod/centcompod
	var/cooldown = 0 //cooldown to prevent printing supplypod beacon spam
	var/locked = FALSE //is the console locked? unlock with ID
	var/usingBeacon = TRUE //is the console in beacon mode? exists to let beacon know when a pod may come in
	var/account_balance = 100
	var/max_orders = 10
	var/processing_order = FALSE

/obj/machinery/computer/cargo/express_vtr/Initialize()
	. = ..()
	packin_up()
	for(var/obj/item/supplypod_beacon_vtr/sb in range(20, src))
		if(sb && sb.express_console != src)
			sb.altlink_console(src)
			sb.anchored = TRUE

/obj/machinery/computer/cargo/express_vtr/on_construction()
	. = ..()
	packin_up()

/obj/machinery/computer/cargo/express_vtr/Destroy()
	if(beacon)
		beacon.unlink_console()
	return ..()

/obj/machinery/computer/cargo/express_vtr/take_damage(damage_amount, damage_type = BRUTE, damage_flag =0, sound_effect =1)
	return
/obj/machinery/computer/cargo/express_vtr/deconstruct(disassembled = TRUE)
	return

/obj/machinery/computer/cargo/express_vtr/attackby(obj/item/W, mob/living/user, params)
	if(W.GetID() && allowed(user))
		locked = !locked
		to_chat(user, "<span class='notice'>You [locked ? "lock" : "unlock"] the interface.</span>")
		return
	else if(istype(W, /obj/item/stack/dollar))
		var/obj/item/stack/dollar/D = W
		if(D.amount)
			to_chat(user, "<span class='notice'>You insert [W] in [src].</span>")
			account_balance += D.amount
			qdel(W)
			to_chat(user, "[src]'s balance now contains [account_balance] credits.")
	else if(istype(W, /obj/item/disk/cargo/bluespace_pod))
		podType = /obj/structure/closet/supplypod/bluespacepod//doesnt effect circuit board, making reversal possible
		to_chat(user, "<span class='notice'>You insert the disk into [src], allowing for advanced supply delivery vehicles.</span>")
		qdel(W)
		return TRUE
	else if(istype(W, /obj/item/supplypod_beacon_vtr))
		var/obj/item/supplypod_beacon_vtr/sb = W
		if (sb.express_console != src)
			sb.link_console(src, user)
			return TRUE
		else
			to_chat(user, "<span class='alert'>[src] is already linked to [sb].</span>")
	..()

/obj/machinery/computer/cargo/express_vtr/emag_act(mob/living/user)
	if(obj_flags & EMAGGED)
		return
	if(user)
		user.visible_message("<span class='warning'>[user] swipes a suspicious card through [src]!</span>",
		"<span class='notice'>You change the routing protocols, allowing the Supply Pod to land anywhere on the station.</span>")
	obj_flags |= EMAGGED
	contraband = TRUE
	// This also sets this on the circuit board
	var/obj/item/circuitboard/computer/cargo/board = circuit
	board.obj_flags |= EMAGGED
	board.contraband = TRUE
	packin_up()

/obj/machinery/computer/cargo/express_vtr/proc/packin_up()
	meme_pack_data = list() 
	for(var/pack in subtypesof(/datum/supply_pack/vampire))
		var/datum/supply_pack/vampire/P = new pack()
		if(!P.contains)
			continue
		supply_packs[P.type] = P
	for(var/pack in supply_packs)
		var/datum/supply_pack/vampire/P = supply_packs[pack]
		if(!meme_pack_data[P.group])
			meme_pack_data[P.group] = list(
				"name" = P.group,
				"packs" = list() 
			)
		meme_pack_data[P.group]["packs"] += list(list(
			"name" = P.name,
			"cost" = P.cost,
			"id" = pack,
			"desc" = P.desc || P.name // If there is a description, use it. Otherwise use the pack's name.
		))

/obj/machinery/computer/cargo/express_vtr/ui_interact(mob/living/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CargoExpress", name)
		ui.open()

/obj/machinery/computer/cargo/express_vtr/ui_data(mob/user)
	var/canBeacon = beacon && (isturf(beacon.loc) || ismob(beacon.loc))//is the beacon in a valid location?
	var/list/data = list()
	var/list/serialized_order_queue = list()

	for (var/datum/supply_pack/vampire/pack in order_queue)
		serialized_order_queue += list(
		"[pack.name] - [pack.cost] credits"
	)

	data["points"] = account_balance
	data["locked"] = locked//swipe an ID to unlock
	data["siliconUser"] = user.has_unlimited_silicon_privilege
	data["beaconzone"] = beacon ? get_area(beacon) : ""//where is the beacon located? outputs in the tgui
	data["usingBeacon"] = usingBeacon //is the mode set to deliver to the beacon or the cargobay?
	data["canBeacon"] = !usingBeacon || canBeacon //is the mode set to beacon delivery, and is the beacon in a valid location?
	data["canBuyBeacon"] = FALSE
	data["beaconError"] = usingBeacon && !canBeacon ? "(BEACON ERROR)" : ""//changes button text to include an error alert if necessary
	data["hasBeacon"] = beacon != null//is there a linked beacon?
	data["beaconName"] = beacon ? beacon.name : "No Beacon Found"
	data["printMsg"] = cooldown > 0 ? "Print Beacon for [BEACON_COST] credits ([cooldown])" : "Print Beacon for [BEACON_COST] credits"//buttontext for printing beacons
	data["supplies"] = list()
	data["total_order_cost"] = total_order_cost()
	data["order_queue"] = json_encode(serialized_order_queue)
	message = "Sales are near-instantaneous - please choose carefully."
	if(SSshuttle.supplyBlocked)
		message = blockade_warning
	if(usingBeacon && !beacon)
		message = "BEACON ERROR: BEACON MISSING"//beacon was destroyed
	else if (usingBeacon && !canBeacon)
		message = "BEACON ERROR: MUST BE EXPOSED"//beacon's loc/user's loc must be a turf
	if(obj_flags & EMAGGED)
		message = "(&!#@ERROR: R0UTING_#PRO7O&OL MALF(*CT#ON. $UG%ESTE@ ACT#0N: !^/PULS3-%E)ET CIR*)ITB%ARD."
	data["message"] = message
	if(!meme_pack_data)
		packin_up()
		stack_trace("There was no pack data for [src]")
	data["supplies"] = meme_pack_data
	if (cooldown > 0)//cooldown used for printing beacons
		cooldown--
	return data

/obj/machinery/computer/cargo/express_vtr/ui_act(action, params, datum/tgui/ui)
	. = ..()
	if(.)
		return

	if(processing_order)
		to_chat(usr, span_warning("An order is already being finalized. Please wait."))
		return

	switch(action)
		if("add_to_queue")
			var/id = text2path(params["id"])
			var/datum/supply_pack/vampire/pack = supply_packs[id]
			if(!istype(pack))
				return
			order_queue += list(pack)
			to_chat(usr, "Added [pack.name] to the order queue.")
			return TRUE
		if("remove_from_queue")
			var/id = text2path(params["id"])
			var/datum/supply_pack/vampire/pack = supply_packs[id]
			if(pack in order_queue)
				order_queue -= list(pack)
				to_chat(usr, "Removed [pack.name] from the order queue.")
			else
				to_chat(usr, "Could not find [pack.name] in the order queue.")
			return TRUE
		if("reset_queue")
			order_queue = list()
			to_chat(usr, "Order queue reset.")
			return TRUE
		if("finalize_order")
			if(!order_queue.len)
				to_chat(usr, "Order queue is empty.")
				return
			if(order_queue.len > max_orders)
				to_chat(usr, "You can only make 10 orders at a time!")
				return
			if(account_balance < total_order_cost())
				to_chat(usr, "Insufficient funds.")
				return

			processing_order = TRUE
			account_balance -= total_order_cost()
			if(istype(beacon) && usingBeacon)
				to_chat(usr, "The truck has been called. It won't be able to drop off in the garage if the door is not open.")

				beacon.update_status(SP_LAUNCH)
				TIMER_COOLDOWN_START(src, COOLDOWN_EXPRESSPOD_CONSOLE, 10 SECONDS)

				addtimer(CALLBACK(src, PROC_REF(deliver_cargo)), 3 MINUTES)
			else
				to_chat(usr, "The Truck cannot find the location.")
				processing_order = FALSE


/obj/machinery/computer/cargo/express_vtr/proc/deliver_cargo()
	processing_order = FALSE
	var/LZ = get_turf(beacon)
	


	var/back_up_distance = 13
	var/turf/truck_start_turf = get_ranged_target_turf(LZ, WEST, back_up_distance)
	var/obj/cargotruck/truck = new(truck_start_turf)
	playsound(truck, 'code/modules/wod13/sounds/train_arrive.ogg', 50, FALSE)
	var/turf/turf_projection = truck_start_turf
	var/turf/next_turf_projection = get_step(truck_start_turf, EAST)
	for(var/i in 1 to back_up_distance-1)
		if(next_turf_projection.is_blocked_turf(TRUE))
			var/area/vtm/vtr/area = turf_projection.loc
			if(area.upper)
				truck.visible_message(span_boldannounce("The Truck cannot see a clear way into the warehouse as it arrives, so it leaves the goods outside."))
			break
		turf_projection = next_turf_projection
		next_turf_projection = get_step(turf_projection, EAST)

	truck.glide_size = (32 / 3) * world.tick_lag
	walk_to(truck, turf_projection, 1, 3)
	
	var/trackLength = get_dist(turf_projection, truck_start_turf)*5
	spawn(trackLength)
		truck.visible_message(span_boldannounce("The Truck unloads its contents."))
		var/obj/structure/closet/crate/crate = new(get_turf(truck))
		crate.name = "Supply Crate"
		for(var/datum/supply_pack/vampire/pack in order_queue)
			for(var/item_path in pack.contains)
				var/obj/item/item_instance = new item_path
				item_instance.forceMove(crate)
		playsound(truck, 'code/modules/wod13/sounds/train_depart.ogg', 50, FALSE)
		spawn(trackLength)
			walk_to(truck, truck_start_turf, 1, 3)
			spawn(trackLength * 1.2)
				qdel(truck)
		order_queue = list()
	return


/obj/machinery/computer/cargo/express_vtr/proc/total_order_cost()
	var/total = 0
	for(var/datum/supply_pack/vampire/pack in order_queue)
		total += pack.cost
	return total
