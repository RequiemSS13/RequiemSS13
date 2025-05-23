/mob/living/carbon/human/npc/bouncer/boris
	our_role = /datum/socialrole/bouncer/boris
	protected_zone_id = "kiss_front"

/mob/living/carbon/human/npc/bouncer/boris/RealisticSay(var/message)
	walk(src,0)
	if(!message)
		return
	if(is_talking)
		return
	if(stat >= HARD_CRIT)
		return
	is_talking = TRUE
	var/delay = round(length_char(message)/2)
	spawn(5)
		remove_overlay(SAY_LAYER)
		var/mutable_appearance/say_overlay = mutable_appearance('icons/mob/talk.dmi', "default0", -SAY_LAYER)
		overlays_standing[SAY_LAYER] = say_overlay
		apply_overlay(SAY_LAYER)
		spawn(max(1, delay))
			if(stat != DEAD)
				remove_overlay(SAY_LAYER)
				emote("me", 1, message, 1)
				is_talking = FALSE