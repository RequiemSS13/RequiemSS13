/datum/status_effect/kissed
	id = "kissed"
	duration = -1
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/kissed

/atom/movable/screen/alert/status_effect/kissed
	name = "Kissed"
	desc = "Your body is flooded with pleasure!"
	icon_state = "in_love" //would be good to give this it's own icon eventually

/datum/status_effect/kissed/on_apply()
	. = ..()
	to_chat(owner, "<span class='userlove'>Sharp fangs pierce your skin, but the pain quickly fades as a numbing warmth sets in...</span>") //feel free to change these
	owner.add_client_colour(/datum/client_colour/brightened)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.blur_eyes(15)
		H.Dizzy(10)

/datum/status_effect/kissed/on_remove()
	to_chat(owner, "<span class='userdanger'>As you wake, you find it hard to recall the last minute or so. All that remains are emotions, a fuzzy image or two, and a pleasant, warm feeling. </span>") //feel free to change these
	owner.remove_client_colour(/datum/client_colour/brightened)
	owner.SetSleeping(50)
	if(ishuman(owner))
		var/mob/living/carbon/human/H = owner
		H.add_confusion(10)
	return ..()
