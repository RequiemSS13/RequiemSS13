/datum/merit/acute_senses
	name = "Acute Senses"
	desc = "You see very well in the dark."
	mob_trait = TRAIT_NIGHT_VISION
	dots = 2
	splat_flags = MERIT_SPLAT_KINDRED
	gain_text = "<span class='notice'>You can see in the dark.</span>"
	lose_text = "<span class='warning'>The darkness consumes you.</span>"

/datum/merit/acute_senses/on_spawn()
	var/mob/living/carbon/human/H = merit_holder
	var/obj/item/organ/eyes/eyes = H.getorgan(/obj/item/organ/eyes)
	if(!eyes || eyes.lighting_alpha)
		return
	eyes.Insert(H) //refresh their eyesight and vision