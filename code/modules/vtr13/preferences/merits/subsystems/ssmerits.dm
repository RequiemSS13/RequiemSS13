//Used to process and handle roundstart quirks
// - Merit strings are used for faster checking in code
// - Merit datums are stored and hold different effects, as well as being a vector for applying trait string
PROCESSING_SUBSYSTEM_DEF(merits)
	name = "Merits"
	init_order = INIT_ORDER_QUIRKS
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	wait = 1 SECONDS

	var/list/merits = list()		//Assoc. list of all roundstart merit datum types; "name" = /path/
	var/list/merits_merits = list()
	var/list/merits_flaws = list()
	var/list/merits_banes = list()
	var/list/merits_languages = list()

	var/list/merit_points = list()	//Assoc. list of merit names and their "point cost"; positive numbers are good traits, and negative ones are bad
	var/list/merit_objects = list()	//A list of all merit objects in the game, since some may process
	var/list/merit_blacklist = list() //A list of merits that can not be used with each other. Format: list(merit1,merit2),list(merit3,merit4)

	var/list/all_merit_settings = list() //list of all custom settings for all merits, crazy n scary
	var/list/merit_setting_keys = list()

/datum/controller/subsystem/processing/merits/Initialize(timeofday)
	if(!merits.len)
		SetupMerits()
	
	if(!all_merit_settings.len)
		SetupMeritSettings()

	merit_blacklist = list(list("Lazy","Expedient"), \
							list("Hardy","Frail"), \
							list("Wealthy","Destitute"), \
							list("Indomitable","Susceptible"), \
							list("Childe of Orlok","Face of Hunger"), \
							list("Passenger Princess","Experienced Driver"), \
							list("Emersonian Mind", "Pregnable Mind"))
	return ..()

/datum/controller/subsystem/processing/merits/proc/SetupMerits()
	// Sort by Positive, Negative, Neutral; and then by name
	var/list/merit_list = sortList(subtypesof(/datum/merit), GLOBAL_PROC_REF(cmp_merit_asc))

	for(var/a_merit_type in merit_list)
		var/datum/merit/merit_type = a_merit_type
		
		//ignore the merit base types
		if(initial(merit_type.abstract_type) == a_merit_type)
			continue
		
		merits[initial(merit_type.name)] = merit_type
		switch(initial(merit_type.category))
			if(MERIT_BANE)
				merits_banes[initial(merit_type.name)] = merit_type
			if(MERIT_FLAW)
				merits_flaws[initial(merit_type.name)] = merit_type
			if(MERIT_MERIT)
				merits_merits[initial(merit_type.name)] = merit_type
			if(MERIT_LANGUAGE)
				merits_languages[initial(merit_type.name)] = merit_type
		merit_points[initial(merit_type.name)] = initial(merit_type.dots)


		var/list/setting_types = splittext(initial(merit_type.custom_setting_types), ",")
		merit_setting_keys[initial(merit_type.name)] = setting_types


/datum/controller/subsystem/processing/merits/proc/SetupMeritSettings()
	for (var/datum/merit_setting/merit_setting_type as anything in typecacheof(path = /datum/merit_setting, ignore_root_path = TRUE))
		if (initial(merit_setting_type.abstract_type) == merit_setting_type)
			continue

		if(all_merit_settings[initial(merit_setting_type.name)])
			CRASH("Multiple instances of merit setting '[initial(merit_setting_type.name)]' exist! Not allowed!")

		if(!ispath(initial(merit_setting_type.parent_merit)))
			CRASH("Merit setting [initial(merit_setting_type.name)] has no valid parent type!")

		var/datum/merit/parent_merit = initial(merit_setting_type.parent_merit)

		if(!initial(initial(parent_merit.custom_setting_types)))
			CRASH("Merit setting [initial(merit_setting_type.name)] has a parent ([initial(parent_merit.name)]) with no existing setting types!")

		var/list/parent_setting_names = splittext(initial(parent_merit.custom_setting_types), ",")

		if(!parent_setting_names || !parent_setting_names.Find(initial(merit_setting_type.name)))
			CRASH("Merit setting [initial(merit_setting_type.name)] has a parent ([initial(parent_merit.name)]) who doesn't mention it in its custom setting types!")

		all_merit_settings[initial(merit_setting_type.name)] = new merit_setting_type()


/datum/controller/subsystem/processing/merits/proc/AssignMerits(mob/living/user, client/cli, spawn_effects)
	for(var/merit_name in cli.prefs.all_merits)
		var/datum/merit/merit_type = SSmerits.merits[merit_name]
		user.add_merit(merit_type, spawn_effects)

/datum/controller/subsystem/processing/merits/proc/getMeritCategory(merit_name)
	var/datum/merit/merit = SSmerits.merits[merit_name]
	return initial(merit.category)

/datum/controller/subsystem/processing/merits/proc/CanAddMerit(datum/preferences/prefs, merit_type, with_reason = FALSE)


	if(!initialized)
		if(with_reason)
			return "Merit Subsystem not initialized!"
		else
			return FALSE
	
	var/datum/merit/merit = merit_type
	
	if(!ispath(merit, /datum/merit))
		if(with_reason)
			return "This is not a merit!"
		else
			return FALSE

	if(!merits[initial(merit.name)])
		if(with_reason)
			return "Merit does not exist."
		else
			return FALSE
	
	if(!initial(merit.category))
		if(with_reason)
			return "Merit has no category."
		else
			return FALSE

	if(!prefs)
		return TRUE


	for(var/list/blacklist_list in SSmerits.merit_blacklist) //V is a list
		if(!(initial(merit.name) in blacklist_list))
			continue
		for(var/selected_merit in (prefs.all_merits - initial(merit.name)))
			if(selected_merit in blacklist_list)
				if(with_reason)
					return "[initial(merit.name)] is incompatible with [selected_merit]."
				else
					return FALSE

	if(initial(merit.splat_flags))
		var/flags = initial(merit.splat_flags)
		switch(prefs.pref_species.id)
			if("kindred")
				if(!(flags & MERIT_SPLAT_KINDRED))
					if(with_reason)
						return "Kindred cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("ghoul")
				if(!(flags & MERIT_SPLAT_GHOUL))
					if(with_reason)
						return "Ghouls cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("human","garou")
				if(!(flags & MERIT_SPLAT_HUMAN))
					if(with_reason)
						return "Humans cannot take this [initial(merit.category)]."
					else
						return FALSE
	
	if(initial(merit.faction_flags))
		var/flags = initial(merit.faction_flags)
		if(!prefs.vamp_faction)
			if(with_reason)
				return "You are the wrong faction for this [initial(merit.category)]."
			else
				return FALSE
		
		switch(prefs.vamp_faction.name)
			if("Invictus")
				if(!(flags & MERIT_FACTION_INVICTUS))
					if(with_reason)
						return "Invictus cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Ordo Dracul")
				if(!(flags & MERIT_FACTION_ORDO))
					if(with_reason)
						return "Ordo Dracul members cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Lancea et Sanctum")
				if(!(flags & MERIT_FACTION_LANCE))
					if(with_reason)
						return "Lancea et Sanctum members cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Circle of the Crone")
				if(!(flags & MERIT_FACTION_CRONE))
					if(with_reason)
						return "Circle of the Crone members cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Carthian Movement")
				if(!(flags & MERIT_FACTION_CARTHIAN))
					if(with_reason)
						return "Carthian Movement members cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Unaligned")
				if(!(flags & MERIT_FACTION_UNALIGNED))
					if(with_reason)
						return "Unaligned members of the All-Night Society cannot take this [initial(merit.category)]."
					else
						return FALSE

	if(initial(merit.clan_flags))
		var/flags = initial(merit.clan_flags)

		var/datum/vampireclane/vtr/clan = prefs.clane ? prefs.clane : prefs.regent_clan
		if(!clan)
			if(with_reason)
				return "You must be in a clane for this [initial(merit.category)]."
			else
				return FALSE
		
		switch(clan.name)
			if("Daeva")
				if(!(flags & MERIT_CLAN_DAEVA))
					if(with_reason)
						return "Daeva cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Gangrel")
				if(!(flags & MERIT_CLAN_GANGREL))
					if(with_reason)
						return "Gangrel cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Mekhet")
				if(!(flags & MERIT_CLAN_MEKHET))
					if(with_reason)
						return "Mekhet cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Nosferatu")
				if(!(flags & MERIT_CLAN_NOSFERATU))
					if(with_reason)
						return "Nosferatu cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Ventrue")
				if(!(flags & MERIT_CLAN_VENTRUE))
					if(with_reason)
						return "Ventrue cannot take this [initial(merit.category)]."
					else
						return FALSE
			if("Revenant")
				if(!(flags & MERIT_CLAN_REVENANT))
					if(with_reason)
						return "Revenants cannot take this [initial(merit.category)]."
					else
						return FALSE
	if(!with_reason)
		return TRUE