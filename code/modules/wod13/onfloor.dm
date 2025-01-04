/obj/item
	var/onflooricon
	var/onflooricon_state
	var/body_worn = FALSE

/obj/item/proc/update_bodyfied(var/mob/living/carbon/human/human)
	if(body_worn)
		worn_icon = initial(worn_icon)

/obj/item/equipped(mob/M, slot)
	if(onflooricon)
		icon = initial(icon)
		pixel_w = initial(pixel_w)
	if(body_worn && ishuman(M))
		worn_icon = initial(worn_icon)
	update_icon()
	..()

/obj/item/dropped(mob/M)
	if(onflooricon && isturf(loc))
		icon = onflooricon
		worn_icon = initial(worn_icon)
		pixel_w = 0
		cut_overlays()
		if(onflooricon_state)
			icon_state = onflooricon_state
	update_icon()
	..()

/obj/item/Initialize()
	..()
	if(isturf(loc) && onflooricon)
		icon = onflooricon
		update_icon()
	if(onflooricon_state)
		icon_state = onflooricon_state
		update_icon()
