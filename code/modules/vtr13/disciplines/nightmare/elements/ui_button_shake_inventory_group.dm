/datum/element/ui_button_shake_inventory_group
	element_flags = ELEMENT_DETACH

/datum/element/ui_button_shake_inventory_group/Attach(datum/target, intensity)
	. = ..()
	
	if(!istype(target, /mob/living/carbon/human))
		return ELEMENT_INCOMPATIBLE
	
	var/mob/living/carbon/human/p_human = target
	if(!p_human.hud_used || !istype(p_human.hud_used, /datum/hud/human))
		return ELEMENT_INCOMPATIBLE

	for( var/atom/movable/screen/inventory/inv_screen in p_human.hud_used.toggleable_inventory)
		inv_screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
	
	for( var/atom/movable/screen/inventory/inv_screen in p_human.hud_used.static_inventory)
		inv_screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)

