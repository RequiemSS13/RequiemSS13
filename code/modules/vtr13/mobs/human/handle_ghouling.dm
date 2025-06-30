/mob/living/carbon/human/proc/handle_ghouling(mob/living/carbon/human/domitor)
	if(!src || !domitor)
		return FALSE
	
	if(!ishumanbasic(src) || !iskindred(domitor))
		return FALSE
	
	if(istype(src, /mob/living/carbon/human/npc))
		var/mob/living/carbon/human/npc/NPC = src
		NPC.ghoulificate(src)
		return TRUE

	src.set_species(/datum/species/ghoul)
	src.regent_clan = domitor.clane
	src.roundstart_vampire = FALSE
	var/datum/species/ghoul/g_species = src.dna.species
	g_species.master = domitor
	g_species.last_vitae = world.time

	var/response_ghoul = tgui_alert(src, "You have been ghouled! Do you wish to keep being a ghoul on your save slot?", "Confirmation", list("Yes", "No")) == "Yes"
	if(!response_ghoul)
		return FALSE

	var/datum/preferences/BLOODBONDED_prefs_g = src.client.prefs
	if(BLOODBONDED_prefs_g.discipline_types.len == 3)
		for (var/i in 1 to 3)
			var/removing_discipline = BLOODBONDED_prefs_g.discipline_types[1]
			if (removing_discipline)
				var/index = BLOODBONDED_prefs_g.discipline_types.Find(removing_discipline)
				BLOODBONDED_prefs_g.discipline_types.Cut(index, index + 1)
				BLOODBONDED_prefs_g.discipline_levels.Cut(index, index + 1)
	BLOODBONDED_prefs_g.pref_species.name = "Ghoul"
	BLOODBONDED_prefs_g.pref_species.id = "ghoul"
	BLOODBONDED_prefs_g.vamp_rank = VAMP_RANK_GHOUL
	BLOODBONDED_prefs_g.save_character()

	return TRUE