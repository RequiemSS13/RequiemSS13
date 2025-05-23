/datum/component/ui_button_shake
	var/mob/living/carbon/human/owner
	var/list/obj/item/affected_items
	var/original_value
	var/intensity = 16

	var/x_sub_32_increment = 0
	var/x_start_offset = "CENTER+0"
	var/y_sub_32_increment = 0
	var/y_start_offset = "CENTER+0"

/datum/component/ui_button_shake/Initialize(mob/living/carbon/human/owner, intensity = 16)
	src.intensity = intensity
	src.owner = owner
	if(!istype(parent, /atom/movable/screen) || !owner)
		return COMPONENT_INCOMPATIBLE

	var/atom/movable/screen/parent_screen  = parent
	original_value = parent_screen.screen_loc

	var/list/screen_loc_params = splittext(parent_screen.screen_loc, ",")

	var/list/screen_loc_X = splittext(screen_loc_params[1],":")
	if(screen_loc_X.len >= 2)
		x_start_offset = screen_loc_X[1]
		x_sub_32_increment = text2num(screen_loc_X[2])
	else
		x_start_offset = screen_loc_params[1]

	var/list/screen_loc_Y = splittext(screen_loc_params[2],":")
	if(screen_loc_Y.len >= 2)
		y_start_offset = screen_loc_Y[1]
		y_sub_32_increment = text2num(screen_loc_Y[2])
	else
		y_start_offset = screen_loc_params[1]

	RegisterSignal(owner, COMSIG_ELEMENT_DETACH, PROC_REF(remove_shake))

	START_PROCESSING(SSfastprocess, src)

/datum/component/ui_button_shake/proc/remove_shake(datum/source)
	Destroy()

/datum/component/ui_button_shake/process(delta_time)
	var/atom/movable/screen/parent_screen  = parent
	if(!parent_screen)
		return PROCESS_KILL

	var/shake_offset_x = rand(-intensity,intensity)
	var/shake_offset_y = rand(-intensity,intensity)
	var/screen_loc = "[x_start_offset]:[x_sub_32_increment + shake_offset_x],[y_start_offset]:[y_sub_32_increment + shake_offset_y]"
	
	parent_screen.screen_loc = screen_loc

	if(istype(parent, /atom/movable/screen/inventory))
		var/atom/movable/screen/inventory/parent_screen_inv = parent
		var/obj/item/linked_item = owner.get_item_by_slot(parent_screen_inv.slot_id)
		if(linked_item)
			linked_item.screen_loc = screen_loc

/datum/component/ui_button_shake/CheckDupeComponent()
	return TRUE

/datum/component/ui_button_shake/UnregisterFromParent()
	STOP_PROCESSING(SSfastprocess, src)
	var/atom/movable/screen/inventory/parent_screen  = parent
	parent_screen.screen_loc = original_value
	if(istype(parent, /atom/movable/screen/inventory))
		var/atom/movable/screen/inventory/parent_screen_inv = parent
		var/obj/item/linked_item = owner.get_item_by_slot(parent_screen_inv.slot_id)
		if(linked_item)
			linked_item.screen_loc = original_value
	