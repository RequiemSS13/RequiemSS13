/datum/element/ui_button_shake_wide_button_group
	element_flags = ELEMENT_DETACH

/datum/element/ui_button_shake_wide_button_group/Attach(datum/target, intensity)
	. = ..()
	
	if(!istype(target, /mob/living/carbon/human))
		return ELEMENT_INCOMPATIBLE
	
	var/mob/living/carbon/human/p_human = target
	if(!p_human.hud_used || !istype(p_human.hud_used, /datum/hud/human))
		return ELEMENT_INCOMPATIBLE

	for(var/atom/movable/screen/screen in p_human.hud_used.static_inventory)
		if(istype(screen, /atom/movable/screen/drinkblood))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/pull))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/jump))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/block))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/rest))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/language_menu))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/drop))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/resist))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/craft))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)

	for(var/atom/movable/screen/screen in p_human.hud_used.hotkeybuttons)
		if(istype(screen, /atom/movable/screen/throw_catch))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)
		else if(istype(screen, /atom/movable/screen/resist))
			screen.AddComponent(/datum/component/ui_button_shake, p_human, intensity)

