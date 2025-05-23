/mob/living/carbon/human/proc/examine_mood(mob/user, temp_gender = null)
	var/t_He = p_they(TRUE, temp_gender)
	var/t_his = p_their(FALSE, temp_gender)
	var/t_him = p_them(FALSE, temp_gender)
	var/t_has = p_have(FALSE, temp_gender)
	var/t_is = p_are(FALSE, temp_gender)
	var/t_es = p_es(FALSE, temp_gender)
	. = list()
	if(HAS_TRAIT(user, TRAIT_EMPATH))
		if (a_intent != INTENT_HELP)
			. += "[t_He] seem[p_s()] to be on guard."
		if (getOxyLoss() >= 10)
			. += "[t_He] seem[p_s()] winded."
		if (getToxLoss() >= 10)
			. += "[t_He] seem[p_s()] sickly."
		var/datum/component/mood/mood = src.GetComponent(/datum/component/mood)
		if(mood.sanity <= SANITY_DISTURBED)
			. += "[t_He] seem[p_s()] distressed."
		if (is_blind())
			. += "[t_He] appear[p_s()] to be staring off into space."
		if (HAS_TRAIT(src, TRAIT_DEAF))
			. += "[t_He] appear[p_s()] to not be responding to noises."
		if (bodytemperature > dna.species.bodytemp_heat_damage_limit)
			. += "[t_He] [t_is] flushed and wheezing."
		if (bodytemperature < dna.species.bodytemp_cold_damage_limit)
			. += "[t_He] [t_is] shivering."

	if(HAS_TRAIT(user, TRAIT_SPIRITUAL) && mind?.holy_role)
		. += "[t_He] [t_has] a holy aura about [t_him].\n"
		SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "religious_comfort", /datum/mood_event/religiously_comforted)

	switch(stat)
		if(UNCONSCIOUS, HARD_CRIT)
			. += "[t_He] [t_is]n't responding to anything around [t_him] and seem[p_s()] to be asleep.\n"
		if(SOFT_CRIT)
			. += "[t_He] [t_is] barely conscious.\n"
		if(CONSCIOUS)
			if(HAS_TRAIT(src, TRAIT_DUMB))
				. += "[t_He] [t_has] a stupid expression on [t_his] face.\n"
	
	if(getorgan(/obj/item/organ/brain))
		if(ai_controller?.ai_status == AI_STATUS_ON)
			. += "<span class='deadsay'>[t_He] do[t_es]n't appear to be [t_him]self.</span>\n"
		if(!key && !istype(src, /mob/living/carbon/human/npc) && (src.soul_state != SOUL_PROJECTING))
			. += "<span class='deadsay'>[t_He] [t_is] totally catatonic. The stresses of life must have been too much for [t_him]. Any recovery is unlikely.</span>\n"
		else if(!client && !istype(src, /mob/living/carbon/human/npc) && (src.soul_state != SOUL_PROJECTING))
			. += "[t_He] [t_has] a blank, absent-minded stare and appears completely unresponsive to anything. [t_He] may snap out of it soon.\n"
		if(src.soul_state == SOUL_PROJECTING)
			. += "<span class='deadsay'>[t_He] [t_is] staring blanky into space, [t_his] eyes are slightly grayed out.</span>\n"
	return length(.) ? . : null