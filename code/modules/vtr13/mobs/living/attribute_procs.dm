/mob/living/proc/get_total_wits()
	return wits + additional_wits + (HAS_TRAIT(src, TRAIT_EXPERTISE_WITS)?1:0)

/mob/living/proc/get_total_resolve()
	return resolve + additional_resolve + (HAS_TRAIT(src, TRAIT_EXPERTISE_RESOLVE)?1:0)

/mob/living/proc/get_total_physique()
	return physique + additional_physique + (HAS_TRAIT(src, TRAIT_EXPERTISE_PHYSIQUE)?1:0)

/mob/living/proc/get_total_stamina()
	return stamina + additional_stamina + (HAS_TRAIT(src, TRAIT_EXPERTISE_STAMINA)?1:0)

/mob/living/proc/get_total_charisma()
	return charisma + additional_charisma + (HAS_TRAIT(src, TRAIT_EXPERTISE_CHARISMA)?1:0)

/mob/living/proc/get_total_composure()
	return composure + additional_composure + (HAS_TRAIT(src, TRAIT_EXPERTISE_COMPOSURE)?1:0)