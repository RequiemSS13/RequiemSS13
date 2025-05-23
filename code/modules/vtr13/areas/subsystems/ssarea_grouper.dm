#define MAX_AREA_GROUPER_PATHFINDING_RECURSION 30
//This subsystem groups together areas for easier pathing and implementing directional indicators
SUBSYSTEM_DEF(area_grouper)
	name = "Area Grouper Multi-Z pathfinder"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DEFAULT

	///List of vip barriers
	var/list/area_groups = list()
	
	#ifdef  AREA_GROUPER_DEBUGGING
	var/turf/start_preset
	var/turf/end_preset
	#endif


/datum/controller/subsystem/area_grouper/Initialize()
	for(var/area/vtm/vtr/groupable_area in world)
		//add the area to a group
		if(groupable_area.inaccessible)
			continue

		if(!groupable_area.id)
			groupable_area.id = "[groupable_area.type]"

		if(!area_groups[groupable_area.id])
			area_groups[groupable_area.id] = new /datum/area_group(groupable_area.id)

		var/datum/area_group/area_group = area_groups[groupable_area.id]
		area_group.add_area(groupable_area)
		
		groupable_area.area_group = area_group
	
	for(var/id in area_groups)
		var/datum/area_group/area_group = area_groups[id]
		area_group.check_validity()
		area_group.link_areas()
		area_group.check_validity_post_link()
	
	return ..()

#ifdef  AREA_GROUPER_DEBUGGING
/datum/controller/subsystem/area_grouper/proc/get_path_debug()
	return get_directions_to_point(src.start_preset, src.end_preset)
#endif

//returns a list of turfs that, if followed, will take you to your destination
/datum/controller/subsystem/area_grouper/proc/get_directions_to_point(turf/start, turf/end)
	return get_directions_from_grouper(start, end)

//Do not call this function! Use get_path_to_point instead.
/datum/controller/subsystem/area_grouper/proc/get_directions_from_grouper(turf/start, turf/end, list/search_branch = list(), list/direction_list = list(), var/recursion_level = 1)

	if(!start || !end)
		#ifdef  AREA_GROUPER_DEBUGGING
		to_chat(usr, "The start or end turf is not set!")
		#endif
		return

	if(recursion_level >= MAX_AREA_GROUPER_PATHFINDING_RECURSION)
		CRASH("UH OH! Runaway recursion detected in the area_grouper/proc/get_path_list! That shouldn't happen!")

	if(!start.loc || !end.loc)
		#ifdef  AREA_GROUPER_DEBUGGING
		to_chat(usr, "The start or end area is not set!")
		#endif
		return
	
	if(!istype(start.loc, /area/vtm/vtr) || !istype(end.loc, /area/vtm/vtr) )
		#ifdef  AREA_GROUPER_DEBUGGING
		to_chat(usr, "The turfs are not located in good areas!")
		#endif
		return

	var/area/vtm/vtr/start_area = start.loc
	var/area/vtm/vtr/end_area = end.loc

	if(!search_branch.len == 0)
		search_branch += start_area.area_group
	
	if(start_area.inaccessible)
		#ifdef  AREA_GROUPER_DEBUGGING
		to_chat(usr, "Start area is marked inaccessible!")
		#endif
		return
	
	if(end_area.inaccessible)
		#ifdef  AREA_GROUPER_DEBUGGING
		to_chat(usr, "Start area is marked inaccessible!")
		#endif
		return
	
	
	if(start_area.area_group == end_area.area_group)
		#ifdef  AREA_GROUPER_DEBUGGING
		if(recursion_level == 1)
			to_chat(usr, "Start area and end area are in the same group! No further pathing needed!")
		#endif
		var/list/new_direction_list = direction_list.Copy()
		new_direction_list.Add(end)
		return new_direction_list

	var/list/egress_areas  = start_area.area_group.egress_areas
	var/list/ingress_areas = start_area.area_group.ingress_areas

	var/list/search_branch_for_next_search = search_branch.Copy()
	for(var/datum/area_group/group in start_area.area_group.egress_areas)
		search_branch_for_next_search += group
	
	
	for(var/datum/area_group/area_group in egress_areas)
		if(search_branch.Find(area_group))
			continue

		var/list/egress_points = egress_areas[area_group]
		var/best_egress_index
		var/best_distance
		for(var/i in 1 to length(egress_points))
			var/distance = get_dist(start, egress_points[i])
			if(!best_distance || distance < best_distance)
				best_egress_index = i
				distance = best_distance
		
		var/list/new_direction_list = list()
		if(length(direction_list))
			new_direction_list.Add(direction_list)
		new_direction_list.Add(egress_points[best_egress_index])
		
		var/next_path_list = get_directions_from_grouper(ingress_areas[area_group][best_egress_index], end, search_branch_for_next_search, new_direction_list, (recursion_level + 1))
		if(next_path_list)
			return next_path_list

	#ifdef  AREA_GROUPER_DEBUGGING
	if(recursion_level == 1)
		to_chat(usr, "We couldn't find any way to get from [start]([start.x], [start.y], [start.z]) to [end]([end.x], [end.y], [end.z]).")
	#endif
