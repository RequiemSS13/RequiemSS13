/datum/adaptation/predatory/eyes
	name = "Tiger Eyes"
	var/original_eye_color

/datum/adaptation/predatory/eyes/activate(mob/living/carbon/human/owner)
	. = ..()

	var/personal_message = span_alert("Your body changes, and your perception increases dramatically!")

	if(!owner.is_eyes_covered())
		owner.visible_message(span_alert("[owner]'s pupils split, and their irises turn bright yellow!"), personal_message,null,3)
	else
		to_chat(owner, personal_message)
	if(!original_eye_color)
		original_eye_color = owner.eye_color
	owner.eye_color = "#ffd900"
	ADD_TRAIT(owner, TRAIT_EYES_VIOLATING_MASQUERADE, PROTEAN_1_TRAIT)
	ADD_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	owner.update_sight()
	owner.update_body()
	
/datum/adaptation/predatory/eyes/deactivate(mob/living/carbon/human/owner)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_EYES_VIOLATING_MASQUERADE, PROTEAN_1_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
	owner.eye_color = original_eye_color
	owner.update_sight()
	owner.update_body()
