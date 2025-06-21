SUBSYSTEM_DEF(loadout)
	name = "Loadout Loader"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_LOADOUT

	var/list/gear_datums = list()
	var/list/loadout_categories = list()

/datum/controller/subsystem/loadout/Initialize()
	for(var/geartype in subtypesof(/datum/gear))
		var/datum/gear/gear = geartype

		var/use_name = initial(gear.display_name)
		var/use_category = initial(gear.sort_category)

		if(gear.type == initial(gear.subtype_path))
			continue

		if(!use_name && initial(gear.path))
			CRASH("Loadout gear [gear] is missing display name")
		if(!initial(gear.path))
			CRASH("Loadout gear [gear] is missing path definition")

		if(!loadout_categories[use_category])
			loadout_categories[use_category] = new /datum/loadout_category(use_category)
		var/datum/loadout_category/loadout_category = loadout_categories[use_category]

		gear_datums[use_name] = new geartype
		gear_datums = sortAssoc(gear_datums)

		loadout_category.gear[use_name] = gear_datums[use_name]
		loadout_category.gear = sortAssoc(loadout_category.gear)

	loadout_categories = sortAssoc(loadout_categories)
	for(var/datum/loadout_category/loadout_category in loadout_categories)
		loadout_category.gear = sortAssoc(loadout_category.gear)