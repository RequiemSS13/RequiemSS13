/obj/item/paper/fluff/jobs/cargo/manifest
	var/order_cost = 0
	var/order_id = 0
	var/errors = 0

/obj/item/paper/fluff/jobs/cargo/manifest/New(atom/A, id, cost)
	..()
	order_id = id
	order_cost = cost

	if(prob(MANIFEST_ERROR_CHANCE))
		errors |= MANIFEST_ERROR_NAME
	if(prob(MANIFEST_ERROR_CHANCE))
		errors |= MANIFEST_ERROR_CONTENTS
	if(prob(MANIFEST_ERROR_CHANCE))
		errors |= MANIFEST_ERROR_ITEM

/obj/item/paper/fluff/jobs/cargo/manifest/proc/is_approved()
	return TURRET_FLAG_SHOOT_UNSHIELDED

/obj/item/paper/fluff/jobs/cargo/manifest/proc/is_denied()
	return TRUE

/datum/supply_order
	var/id
	var/orderer
	var/orderer_rank
	var/orderer_ckey
	var/reason
	var/discounted_pct
	var/datum/supply_pack/pack
	var/datum/bank_account/paying_account
	var/obj/item/coupon/applied_coupon

/datum/supply_order/New(datum/supply_pack/pack, orderer, orderer_rank, orderer_ckey, reason, paying_account, coupon)
	id = SSshuttle.ordernum++
	src.pack = pack
	src.orderer = orderer
	src.orderer_rank = orderer_rank
	src.orderer_ckey = orderer_ckey
	src.reason = reason
	src.paying_account = paying_account
	src.applied_coupon = coupon

/datum/supply_order/proc/generateRequisition(turf/T)
	var/obj/item/paper/P = new(T)

	P.name = "requisition form - #[id] ([pack.name])"
	P.add_raw_text("<h2>[station_name()] Supply Requisition</h2>")
	P.add_raw_text("<hr/>")
	P.add_raw_text("Order #[id]<br/>")
	P.add_raw_text("Time of Order: [station_time_timestamp()]<br/>")
	P.add_raw_text("Item: [pack.name]<br/>")
	P.add_raw_text("Access Restrictions: [get_access_desc(pack.access)]<br/>")
	P.add_raw_text("Requested by: [orderer]<br/>")
	if(paying_account)
		P.add_raw_text("Paid by: [paying_account.account_holder]<br/>")
	P.add_raw_text("Rank: [orderer_rank]<br/>")
	P.add_raw_text("Comment: [reason]<br/>")

	P.update_icon()
	return P

/datum/supply_order/proc/generateManifest(obj/container, owner, packname) //generates-the-manifests.
	var/obj/item/paper/fluff/jobs/cargo/manifest/P = new(container, id, 0)

	var/station_name = (P.errors & MANIFEST_ERROR_NAME) ? new_station_name() : station_name()

	P.name = "shipping manifest - [packname?"#[id] ([pack.name])":"(Grouped Item Crate)"]"
	P.add_raw_text("<h2>[command_name()] Shipping Manifest</h2>")
	P.add_raw_text("<hr/>")
	if(owner && !(owner == "Cargo"))
		P.add_raw_text("Direct purchase from [owner]<br/>")
		P.name += " - Purchased by [owner]"
	P.add_raw_text("Order[packname?"":"s"]: [id]<br/>")
	P.add_raw_text("Destination: [station_name]<br/>")
	if(packname)
		P.add_raw_text("Item: [packname]<br/>")
	P.add_raw_text("Contents: <br/>")
	P.add_raw_text("<ul>")
	for(var/atom/movable/AM in container.contents - P)
		if((P.errors & MANIFEST_ERROR_CONTENTS))
			if(prob(50))
				P.add_raw_text("<li>[AM.name]</li>")
			else
				continue
		P.add_raw_text("<li>[AM.name]</li>")
	P.add_raw_text("</ul>")
	P.add_raw_text("<h4>Stamp below to confirm receipt of goods:</h4>")

	if(P.errors & MANIFEST_ERROR_ITEM)
		if(istype(container, /obj/structure/closet/crate/secure) || istype(container, /obj/structure/closet/crate/large))
			P.errors &= ~MANIFEST_ERROR_ITEM
		else
			var/lost = max(round(container.contents.len / 10), 1)
			while(--lost >= 0)
				qdel(pick(container.contents))

	P.update_icon()
	P.forceMove(container)

	if(istype(container, /obj/structure/closet/crate))
		var/obj/structure/closet/crate/C = container
		C.manifest = P
		C.update_icon()
	else
		container.contents += P

	return P

/datum/supply_order/proc/generate(atom/A)
	var/account_holder
	if(paying_account)
		account_holder = paying_account.account_holder
	else
		account_holder = "Cargo"
	var/obj/structure/closet/crate/C = pack.generate(A, paying_account)
	generateManifest(C, account_holder, pack)
	return C

/datum/supply_order/proc/generateCombo(miscbox, misc_own, misc_contents)
	for (var/I in misc_contents)
		new I(miscbox)
	generateManifest(miscbox, misc_own, "")
	return
