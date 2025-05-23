/obj/item/grave_soil
	name = "urn"
	desc = "An empty, ornate jar."
	var/full_desc = "An ornate jar of dirt..."
	icon_state = "urn_empty"
	var/icon_state_full = "urn"
	
	icon = 'icons/vtr13/obj/items.dmi'
	onflooricon = 'icons/vtr13/obj/items_onfloor.dmi'
	onflooricon_state = "urn"
	var/fragile = TRUE
	var/filled = FALSE
	w_class = WEIGHT_CLASS_SMALL

/obj/item/grave_soil/New(loc, mob/living/owner)
	. = ..()
	if(owner)
		AddComponent(/datum/component/heirloom_soil, owner)
		filled = TRUE
		icon_state = icon_state_full
		desc = full_desc

/obj/item/grave_soil/attack_self(mob/user)
	. = ..()
	if(user.stat != CONSCIOUS || !isliving(user) || !filled)
		return

	user.visible_message(span_warning("[user] is pouring out \the [src]!"))
	if(!do_mob(user, user, 10 SECONDS))
		user.visible_message(span_warning("[user]'s stops pouring out \the [src]."))
		return
	
	new /obj/effect/decal/grave_soil(get_turf(user), src)
	filled = FALSE
	desc = initial(desc)
	icon_state = initial(icon_state)

/obj/item/grave_soil/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!fragile)
		return
	var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
	if(!caught)
		shatter(get_turf(hit_atom))

/obj/item/grave_soil/proc/shatter(turf/hit_turf)
	playsound(src, "shatter", 50, TRUE)
	src.visible_message(span_warning("[src] shatters!"))
	if(filled)
		new /obj/effect/decal/grave_soil(hit_turf, src)
	qdel(src)

/obj/item/grave_soil/Destroy()
	return ..()

/obj/item/grave_soil/attackby(obj/item/used_item, mob/living/user)
	. = ..()
	if(user.stat)
		return
	if(filled || !istype(used_item, /obj/item/grave_soil))
		return

	var/obj/item/grave_soil/used_soil_holder
	if(!used_soil_holder.filled)
		return
	user.visible_message(span_warning("[user]'s begins pouring dirt from \the [used_item] into \the [src]."))
	if(do_mob(user, user, 5 SECONDS))
		used_soil_holder.transfer_soil(src, user)

/obj/item/grave_soil/proc/transfer_soil(obj/item/grave_soil/filled_item, mob/living/user)
	user.visible_message(span_warning("[user] empties the contents of \the [src] into \the [filled_item]."))
	filled = FALSE
	desc = initial(desc)
	icon_state = initial(icon_state)
	filled_item.fill(src)

/obj/item/grave_soil/proc/fill(obj/item/source_item)
	desc = full_desc
	filled = TRUE
	icon_state = icon_state_full
	source_item.TransferComponents(src)

/obj/item/grave_soil/bag
	name = "burlap sack"
	desc = "An empty bag."
	full_desc = "An unseemly bag of dirt..."
	icon_state = "sack_empty"
	icon_state_full = "sack"
	onflooricon_state = "sack"
	empty_icon
	fragile = FALSE
