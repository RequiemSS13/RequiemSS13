/mob/living/carbon/human/doUnEquip(obj/item/I, force, newloc, no_move, invdrop = TRUE, silent = FALSE)
	if(get_held_index_of_item(I) && HAS_TRAIT(src, TRAIT_GECKO_GRIP) && gloves)
		to_chat(src, span_notice("The [I] is stuck to your hands!"))
		return FALSE
	. = ..()
