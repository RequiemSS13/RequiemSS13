/datum/effect_system/smoke_spread/blood_mist
	effect_type = /obj/effect/particle_effect/smoke/blood_mist

/obj/effect/particle_effect/smoke/blood_mist
	color = "#9C3636"

/obj/effect/particle_effect/smoke/blood_mist/smoke_mob(mob/living/carbon/inhaling_mob)
	if(ishuman(inhaling_mob))
		var/mob/living/carbon/human/human_inhaler = inhaling_mob
		if(human_inhaler.bloodpool && prob(50))
			human_inhaler.bloodpool = max(0, human_inhaler.bloodpool-1)
			to_chat(inhaling_mob, "You feel blood leave your body!")
	inhaling_mob.adjustBruteLoss(5)
	inhaling_mob.emote("cough")

/obj/effect/particle_effect/smoke/blood_mist/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /obj/projectile/beam))
		var/obj/projectile/beam/B = AM
		B.damage = (B.damage/2)
