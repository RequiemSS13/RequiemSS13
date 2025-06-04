/obj/effect/decal/grave_soil
	name = "pile of dirt"
	desc = "This dirt has been returned to the earth."
	icon = 'icons/wod13/props.dmi'
	icon_state = "pit1"

/obj/effect/decal/grave_soil/New(loc, atom/movable/created_from)
	. = ..()
	if(created_from)
		created_from.TransferComponents(src)

/obj/effect/decal/attackby(obj/item/used_item, mob/living/user)
	. = ..()
	
	if(!istype(used_item, /obj/item/grave_soil))
		return
	var/obj/item/grave_soil/soil_container = used_item

	if(soil_container.filled)
		return

	user.visible_message(span_warning("[user] pathetically scoops dirt into \the [soil_container]."))
	if(!do_mob(user, user, 15 SECONDS))
		return
	
	soil_container.fill(src)
	qdel(src)
	