
/datum/merit/dancer
	name = "Dancer"
	desc = "You can dance to increase your humanity. NOTE: This merit is NOT a permanent fixture, and will be REMOVED during the humanity rework."
	dots = 4
	mob_trait = TRAIT_DANCER
	gain_text = "<span class='notice'>You want to dance.</span>"
	lose_text = "<span class='warning'>You don't want to dance anymore.</span>"

/datum/merit/dancer/on_spawn()
	var/mob/living/carbon/H = merit_holder
	var/datum/action/dance/DA = new(H)
	DA.Grant(H)

/datum/action/dance
	name = "Dance"
	desc = "Dance from dusk till dawn!"
	button_icon_state = "dance"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/last_added_humanity = 0

/datum/action/dance/Trigger()
	if(HAS_TRAIT(owner, TRAIT_INCAPACITATED))
		to_chat(owner, "<span class='warning'>You're a little too close to being dead to get down!</span>")
		return

	if(HAS_TRAIT(owner, TRAIT_FLOORED))
		to_chat(owner, "<span class='warning'>You got to get up before you get down!</span>")
		return
//	var/mob/living/carbon/H = owner
	if(prob(50))
		dancefirst(owner)
	else
		dancesecond(owner)

	if(last_added_humanity+6000 < world.time)
		for(var/obj/machinery/jukebox/J in range(7, owner))
			if(J)
				if(J.active)
					if(ishuman(owner))
						var/mob/living/carbon/human/human = owner
						human.AdjustHumanity(1, 8)
						last_added_humanity = world.time
