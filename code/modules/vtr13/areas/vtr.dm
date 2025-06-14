/area/vtm/vtr
	var/sector
	var/ambiance_message

	//what z-level the area is located on
	var/floor

	var/datum/area_group/area_group

	//An id matching area's group, for pathing
	var/id

	//marked true if an area cannot be reached via stairs
	var/inaccessible = FALSE

	//marked true if the area is sanctified
	var/holy_ground = FALSE

	//dwelling code
	var/is_loot_dwelling = FALSE
	var/area_tag = "default"
	var/area_heat = 0
	var/area_heat_max
	var/alarm_trigerred = 0
	var/alarm_disabled = 0
	var/loot_spawned = 0
	var/obj/structure/vtm/dwelling_alarm/alarm_panel
	var/list/cased_by
	var/list/dwelling_doors
	var/list/dwelling_windows
	var/list/loot_containers
	var/forced_loot
	var/list/loot_list = list("type" = "none",
		"minor" = 0,
		"moderate" = 0,
		"major" = 0,
		)

/area/vtm/vtr/New()
	. = ..()
	if(is_loot_dwelling)
		cased_by = list()
		dwelling_doors = list()
		dwelling_windows = list()
		loot_containers = list()
		SSdwelling.dwelling_area_list += src


/area/vtm/vtr/proc/add_heat(ammount = 0) //Adds heat to given area, then checks if alarm shoudl be trigerred
	if(alarm_disabled == 1) return
	if(alarm_trigerred == 1)
		INVOKE_ASYNC(alarm_panel, TYPE_PROC_REF(/obj/structure/vtm/dwelling_alarm/, contact_cops))
		return
	area_heat += ammount
	if(area_heat >= area_heat_max && alarm_panel.alarm_active == 0)
		alarm_panel.alarm_arm()
		return

/area/vtm/vtr/proc/setup_loot_table(type) //Called during setup, this proc contains the look drop values
	switch(type)
		if("major")
			loot_list["type"] = "major"
			loot_list["minor"] = rand(1,2)
			loot_list["moderate"] = rand(4,6)
			loot_list["major"] = rand(3,6)
			area_heat_max = 20
		if("moderate")
			loot_list["type"] = "moderate"
			loot_list["minor"] = rand(4,6)
			loot_list["moderate"] = rand(3,6)
			loot_list["major"] = rand(1,2)
			area_heat_max = 50
		if("minor")
			loot_list["type"] = "minor"
			loot_list["minor"] = rand(4,6)
			loot_list["moderate"] = rand(1,2)
			loot_list["major"] = rand(0,1)
			area_heat_max = 50

/area/vtm/vtr/proc/setup_loot_containers() // Called during setup
	var/loot_sum = loot_list["minor"] + loot_list["moderate"] + loot_list["major"]
	while(loot_sum > 0)
		var/obj/structure/vtm/dwelling_container/picked_container = pick(loot_containers)
		if(!picked_container)
			return "Error: No containers to pick"
		picked_container.search_tries += 2
		picked_container.search_hits_left += 1
		loot_sum -= 1
	for(var/obj/structure/vtm/dwelling_container/loot_container in loot_containers)
		if(loot_container.search_tries <= 4) loot_container.search_tries += 2
	return

/area/vtm/vtr/proc/setup_loot() //Primary setup proc
	if(!length(loot_containers))
		return
	if(forced_loot)
		setup_loot_table(forced_loot)
	if(loot_list["type"] == "none")
		if(SSdwelling.dwelling_number_major > 0)
			SSdwelling.dwelling_number_major -= 1
			setup_loot_table("major")
	if(loot_list["type"] == "none")
		if(SSdwelling.dwelling_number_moderate > 0)
			SSdwelling.dwelling_number_moderate -= 1
			setup_loot_table("moderate")
	if(loot_list["type"] == "none")
		setup_loot_table("minor")
	for (var/obj/structure/vampdoor/dwelling/dwelling_door in dwelling_doors)
		dwelling_door.set_security(loot_list["type"])
	setup_loot_containers()
	loot_spawned = 1
	SSdwelling.dwelling_list.Add(src)
	return

/area/vtm/vtr/proc/return_loot_value() //Used during seeding
	var/list/pick_list = list()
	if(loot_list["minor"] > 0)
		pick_list.Add("minor")
	if(loot_list["moderate"] > 0)
		pick_list.Add("moderate")
	if(loot_list["major"] > 0)
		pick_list.Add("major")

	switch(pick_list.len)
		if(0)
			return 0
		else
			var/list_choice = pick(pick_list)
			loot_list[list_choice] -= 1
			return list_choice

/area/vtm/vtr/Destroy()
	. = ..()
	if(is_loot_dwelling)
		SSdwelling.dwelling_area_list.Remove(src)
		if(SSdwelling.dwelling_list.Find(src) != 0) SSdwelling.dwelling_list.Remove(src)

	alarm_panel = null
	cased_by = null
	dwelling_doors = null
	loot_containers = null
	dwelling_windows = null
