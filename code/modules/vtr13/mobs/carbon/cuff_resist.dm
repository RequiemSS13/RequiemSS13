/mob/living/carbon/proc/cuff_resist(obj/item/I)
	if(I.item_flags & BEING_REMOVED)
		to_chat(src, "<span class='warning'>You're already attempting to remove [I]!</span>")
		return
	I.item_flags |= BEING_REMOVED
	

	visible_message("<span class='warning'>[src] struggles in their [I]!</span>")
	if(do_after(src, 1 SECONDS, target = src, timed_action_flags = IGNORE_HELD_ITEM))
		var/stat_rolled = get_wits()
		var/break_cuffs = FALSE
		if(get_physique() >= stat_rolled)
			break_cuffs = TRUE
			stat_rolled = get_physique()
		
		if(HAS_TRAIT(src, TRAIT_ESCAPE_ARTIST))
			stat_rolled += 2

		if(SSroll.storyteller_roll(stat_rolled*2, I.escape_difficulty, src, src) >= I.escape_difficulty)
			. = clear_cuffs(I, break_cuffs)
		else
			to_chat(src, "<span class='warning'>You fail to remove [I]!</span>")
	I.item_flags &= ~BEING_REMOVED