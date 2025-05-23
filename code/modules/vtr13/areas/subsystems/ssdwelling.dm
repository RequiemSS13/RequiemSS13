SUBSYSTEM_DEF(dwelling)
	name = "Dwelling Loot Handler"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DEFAULT
	var/dwelling_number_major = 4
	var/dwelling_number_moderate = 10

	var/list/dwelling_list = list()
	var/list/dwelling_area_list = list()

/datum/controller/subsystem/dwelling/Initialize()
	for(var/area/vtm/vtr/dwelling_area in dwelling_area_list)
		if(!dwelling_area.is_loot_dwelling)
			continue
		dwelling_area.setup_loot()

