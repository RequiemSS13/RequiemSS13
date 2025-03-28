/datum/adaptation/unnatural/wings
	name = "Angelic Wings"
	var/wings_icon = "Angel"
/datum/adaptation/unnatural/wings/activate(mob/living/carbon/owner)
	. = ..()
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	owner.visible_message(span_alert("[owner] hunches over, and immense wings burst forth from their back!"))
	ADD_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_3_TRAIT)
	owner.Stun(1.5 SECONDS)
	owner.do_jitter_animation(30)
	owner.dna.species.wings_icon = wings_icon
	owner.dna.species.GiveSpeciesFlight(owner)
	



/datum/adaptation/unnatural/wings/deactivate(mob/living/carbon/owner)
	. = ..()
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	REMOVE_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_3_TRAIT)
	owner.dna.species.RemoveSpeciesFlight(owner)
	owner.dna.species.wings_icon = null


/datum/adaptation/unnatural/wings/gargoyle
	name = "Insectoid Wings"
	wings_icon = "Megamoth"

/datum/adaptation/unnatural/wings/dragon
	name = "Leathery Wings"
	wings_icon = "Dragon"