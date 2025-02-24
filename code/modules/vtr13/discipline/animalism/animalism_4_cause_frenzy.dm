/datum/discipline_power/vtr/animalism/cause_frenzy
	name = "Awaken the Beast"
	desc = "Elgeon write a description kthx. Summon a cat or rat"
	level = 4
	violates_masquerade = FALSE
	fire_and_forget = TRUE

/datum/discipline_power/vtr/animalism/cause_frenzy/activate()
	. = ..()
	for(var/mob/living/carbon/human/target in range(7, get_turf(owner)))
		if(!iskindred(target))
			continue
		to_chat(target, span_danger("You look at [owner] you think to yourself 'IT'S MORBIN TIME' and are compelled to morb all over the place. Elge write this better or delete this line."))
		target.rollfrenzy()