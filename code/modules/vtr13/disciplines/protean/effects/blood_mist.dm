/datum/effect_system/smoke_spread/blood_mist
	effect_type = /obj/effect/particle_effect/smoke/blood_mist

/obj/effect/particle_effect/smoke/blood_mist
	color = "#9C3636"

/obj/effect/particle_effect/smoke/blood_mist/smoke_mob(mob/living/carbon/inhaling_mob)
	if(istype(inhaling_mob, /mob/living/simple_animal/hostile/blood_mist))
		return
	if(ishuman(inhaling_mob))
		var/mob/living/carbon/human/human_inhaler = inhaling_mob
		if(human_inhaler.bloodpool && (isghoul(human_inhaler) || iskindred(human_inhaler)) && prob(25))
			human_inhaler.adjustBloodPool(-1)
			to_chat(inhaling_mob, "The mist drinks the life from your breath!")
		if(!iskindred(inhaling_mob) && prob(25))
			human_inhaler.blood_volume = max(0, human_inhaler.blood_volume-50)
			to_chat(human_inhaler, "The mist drinks your blood through your skin!")

	inhaling_mob.adjustBruteLoss(5)
	inhaling_mob.emote("cough")

/obj/effect/particle_effect/smoke/blood_mist/Crossed(atom/movable/AM, oldloc)
	. = ..()
	if(istype(AM, /obj/projectile/beam))
		var/obj/projectile/beam/B = AM
		B.damage = (B.damage/2)
