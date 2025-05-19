/datum/merit/clear_eyes
	name = "Clear Eyes"
	desc = "You see the world as it is. You are immune to obfuscate invisibility."
	dots = 3
	splat_flags = MERIT_SPLAT_HUMAN

/datum/merit/clear_eyes/post_add()
	merit_holder.see_invisible += AUSPEX_LEVEL_5

/datum/merit/clear_eyes/remove()
	merit_holder.see_invisible -= AUSPEX_LEVEL_5