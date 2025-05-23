/datum/discipline_power/vtr/animalism/cause_frenzy
	name = "Awaken the Beast"
	desc = "Force the Beast of all nearby Kindred into frenzy."
	level = 4
	violates_masquerade = FALSE
	cooldown_length = 30 SECONDS

/datum/discipline_power/vtr/animalism/cause_frenzy/activate()
	. = ..()
	for(var/mob/living/carbon/human/target in view(7, get_turf(owner)))
		if(!iskindred(target) || target == owner || !target.mind)
			continue
		to_chat(target, span_danger("An unnatural force brings your Beast to the surface, slavering for blood and dominance!"))
		target.mind.try_frenzy()
