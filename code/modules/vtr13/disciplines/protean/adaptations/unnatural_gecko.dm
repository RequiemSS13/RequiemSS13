/datum/adaptation/unnatural/gecko
	name = "Gecko Grip"


/datum/adaptation/unnatural/gecko/activate(mob/living/carbon/human/owner)
	. = ..()
	to_chat(owner, span_alert("Your hands gain a strange texture!"))
	ADD_TRAIT(owner, TRAIT_GECKO_GRIP, PROTEAN_3_ADAPTATION_TRAIT)
	
/datum/adaptation/unnatural/gecko/deactivate(mob/living/carbon/human/owner)
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_GECKO_GRIP, PROTEAN_3_ADAPTATION_TRAIT)
