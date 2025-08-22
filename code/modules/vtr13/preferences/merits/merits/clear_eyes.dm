/datum/merit/clear_eyes
	name = "Clear Eyes"
	desc = "You see the world as it is. You are immune to obfuscate invisibility."
	dots = 3
	splat_flags = MERIT_SPLAT_HUMAN

/datum/merit/clear_eyes/post_add()
	var/obj/item/organ/eyes/E = merit_holder.getorganslot(ORGAN_SLOT_EYES)
	E.see_invisible = AUSPEX_LEVEL_5
	merit_holder.see_invisible = AUSPEX_LEVEL_5

/datum/merit/clear_eyes/remove()
	var/obj/item/organ/eyes/E = merit_holder.getorganslot(ORGAN_SLOT_EYES)
	E.see_invisible = initial(E.see_invisible)
	merit_holder.see_invisible = E.see_invisible