/datum/preferences/proc/random_species()
	var/random_species_type = GLOB.species_list[pick(get_roundstart_species())]
	pref_species = new random_species_type

	if(randomise[RANDOM_NAME])
		real_name = pref_species.random_name(gender,1)

	if(pref_species.id == "ghoul")
		qdel(regent_clan)
		regent_clan = new /datum/vampireclane/vtr/daeva()
		discipline_types = list()
		discipline_levels = list()
		if(!regent_clan.clane_disciplines || regent_clan.clane_disciplines.len < 3)
			CRASH("WHAT THE FUCK [regent_clan.clane_disciplines.len]")
		for (var/disc_type in regent_clan.clane_disciplines)
			discipline_types.Add(disc_type)
			discipline_levels.Add(0)
		vamp_rank = VAMP_RANK_GHOUL
		vamp_faction = new /datum/vtr_faction/vamp_faction/unaligned()

	if(pref_species.id == "kindred")
		qdel(clane)
		clane = new /datum/vampireclane/vtr/daeva()

		discipline_types = list()
		discipline_levels = list()
		for (var/disc_type in clane.clane_disciplines)
			discipline_types.Add(disc_type)
			discipline_levels.Add(0)
		vamp_rank = VAMP_RANK_NEONATE
		vamp_faction = new /datum/vtr_faction/vamp_faction/unaligned()
	