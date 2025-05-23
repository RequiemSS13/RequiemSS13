
/*
	Datum that groups areas together for determining pathing
	Grouped areas all share the same area_id
	A areas in a group should be:
		- on the same z level
		- all accessible to each other, without the use of stairs or xfer points
*/
/datum/area_group
	var/list/areas

	var/id

	//teleporter locations
	var/list/transfer_points

	//stair structures
	var/list/stairs_up

	//turfs above a stairwell
	var/list/stairs_down

	//places that can be accessed by this datum. Structure is egress_areas[area_group] = list(turfs)
	var/list/egress_areas = list()

	var/list/ingress_areas = list()

/datum/area_group/New(id)
	src.id = id

/datum/area_group/proc/add_area(area/vtm/vtr/new_area)
	LAZYADD(areas, new_area)
	
	//add any transfer points in the area
	for(var/obj/transfer_point_vamp/tracked_transfer_point in new_area)
		LAZYADD(transfer_points, tracked_transfer_point)

	//add any stairs up in the area, if they actually lead somewhere
	for(var/obj/structure/stairs/tracked_stairs in new_area)
		if(!get_step_multiz(get_turf(tracked_stairs), UP))
			continue
		LAZYADD(stairs_up, tracked_stairs)

	//Add any open space above a stairwell in the area
	for(var/turf/open/openspace/tracked_void in new_area)
		var/turf/turf_below = get_step_multiz(tracked_void, DOWN)
		if(!turf_below)
			continue
		var/obj/structure/stairs/new_stairs_down = locate(/obj/structure/stairs) in turf_below
		if(!new_stairs_down)
			continue
		LAZYADD(stairs_down, tracked_void)

/datum/area_group/proc/check_validity()
	if(!stairs_up && !stairs_down && !transfer_points)
		CRASH("Area group [id] has nothing linking to it! The contained areas should be set to inaccessible.")

/datum/area_group/proc/check_validity_post_link()
	if(!egress_areas)
		CRASH("Area group [id] has no points of egress! We shouldn't have reached here!")

/datum/area_group/proc/link_areas()
	for(var/obj/transfer_point_vamp/tracked_transfer_point in transfer_points)
		var/area/vtm/vtr/destination_area = get_area(tracked_transfer_point.exit)

		if(!destination_area)
			CRASH("Somehow we have a transfer point that doesn't link to a sibling. We should have crashed about this already!")

		if(!destination_area.area_group)
			CRASH("area [destination_area] has a transfer point but isn't part of an area group! That's bad! [destination_area.inaccessible ? "This is probably because the area is marked as inaccessible." : ""]")

		if(!egress_areas[destination_area.area_group])
			egress_areas[destination_area.area_group] = list()
		
		if(!ingress_areas[destination_area.area_group])
			ingress_areas[destination_area.area_group] = list()
		
		egress_areas[destination_area.area_group] += get_turf(tracked_transfer_point)
		ingress_areas[destination_area.area_group] += get_turf(tracked_transfer_point.exit)
		
	for(var/obj/structure/stairs/tracked_stairs in stairs_up)
		var/turf/end_of_stairs = get_step_multiz(get_turf(tracked_stairs), UP)
		var/area/vtm/vtr/destination_area = end_of_stairs.loc

		if(!destination_area)
			CRASH("Somehow we have a tracked stairwell up that doesn't actually lead anywhere.")

		if(!destination_area.area_group)
			CRASH("area [destination_area] has a stairwell up but isn't part of an area group! That's bad! [destination_area.inaccessible ? "This is probably because the area is marked as inaccessible." : ""]")
	
		if(!egress_areas[destination_area.area_group])
			egress_areas[destination_area.area_group] = list()
		
		if(!ingress_areas[destination_area.area_group])
			ingress_areas[destination_area.area_group] = list()
		
		egress_areas[destination_area.area_group] += get_turf(tracked_stairs)
		ingress_areas[destination_area.area_group] += get_turf(end_of_stairs)

	for(var/turf/tracked_void in stairs_down)
		var/area/vtm/vtr/destination_area = get_area(get_step_multiz(tracked_void, DOWN))

		if(!destination_area)
			CRASH("Somehow we have a tracked stairwell down that doesn't actually have something beneath.")

		if(!destination_area.area_group)
			CRASH("area [destination_area] has a stairwell down but isn't part of an area group! That's bad! [destination_area.inaccessible ? "This is probably because the area is marked as inaccessible." : ""]")
		
		if(!egress_areas[destination_area.area_group])
			egress_areas[destination_area.area_group] = list()
		
		if(!ingress_areas[destination_area.area_group])
			ingress_areas[destination_area.area_group] = list()

		egress_areas[destination_area.area_group] += tracked_void
		var/turf/ingress_turf = get_step_multiz(tracked_void, DOWN)
		ingress_areas[destination_area.area_group] += ingress_turf
