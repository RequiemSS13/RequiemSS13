
/obj/fake_lighting_plane
	screen_loc = "1,1"
	plane = FAKE_SHADOW_PLANE
	blend_mode = BLEND_MULTIPLY
	appearance_flags = PLANE_MASTER | NO_CLIENT_COLOR
	color = list(null,null,null,null,"#000c")
	mouse_opacity = 0

/datum/component/enraptured
	dupe_mode = COMPONENT_DUPE_SELECTIVE

	var/mob/living/carbon/human/vip
	var/datum/discipline_power/vtr/source_power
	var/image/spotlight_shadow

	var/obj/fake_shadow_plane
	var/image/halogen_light
	var/image/actual_light

	var/client/parent_client
	var/mob/living/living_target

	var/in_sight = TRUE


/datum/component/enraptured/Initialize(mob/living/new_vip, datum/discipline_power/vtr/new_source_power)
	source_power = new_source_power
	if(!source_power)
		return COMPONENT_INCOMPATIBLE

	var/datum/mind/parent_mind = parent
	vip = new_vip
	if(!parent_mind || !parent_mind.current || !isliving(parent_mind.current) || !vip || !isliving(vip))
		return COMPONENT_INCOMPATIBLE
	
	living_target = parent_mind.current

	if(!living_target.client)
		return COMPONENT_INCOMPATIBLE
	
	ADD_TRAIT(living_target, TRAIT_ENRAPTURED, MAJESTY_1_TRAIT)

	to_chat(living_target, "You can't take your eyes off of [new_vip]!")

	parent_client = living_target.client

	fake_shadow_plane = new /obj/fake_lighting_plane

	actual_light = image('icons/vtr13/effect/spotlight_beam.dmi', vip, "ray", BELOW_MOB_LAYER)
	actual_light.pixel_y = -32
	actual_light.pixel_x = -32

	halogen_light = image('icons/vtr13/effect/spotlight_beam.dmi', vip, "spotlight", ABOVE_MOB_LAYER)
	halogen_light.blend_mode = BLEND_ADD
	halogen_light.pixel_y = -32
	halogen_light.pixel_x = -32
	halogen_light.plane = FAKE_SHADOW_PLANE

	spotlight_shadow =  image('icons/vtr13/effect/spotlight_shadow.dmi', vip, "default", FAKE_SHADOW_PLANE)
	spotlight_shadow.plane = FAKE_SHADOW_PLANE
	spotlight_shadow.mouse_opacity = 0
	spotlight_shadow.alpha = 0
	spotlight_shadow.pixel_x = -384
	spotlight_shadow.pixel_y = -384
	spotlight_shadow.icon_state = "shadow"
	parent_client.images += spotlight_shadow
	
	animate(spotlight_shadow, alpha=204, easing=CIRCULAR_EASING|EASE_IN, time=20)
	
	addtimer(CALLBACK(src, PROC_REF(turn_on_light)), 30, TIMER_CLIENT_TIME, TIMER_OVERRIDE)

	living_target.setDir(get_vip_direction())
	
	RegisterSignal(vip, COMSIG_LIVING_DEATH, PROC_REF(destroy_component))
	RegisterSignal(source_power, COMSIG_COMPONENT_ENRAPTURE_REMOVE, PROC_REF(destroy_component))
	


	if(vip != living_target)
		RegisterSignal(vip, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))

		RegisterSignal(living_target, COMSIG_LIVING_DIR_CHANGE, PROC_REF(set_dir_override))
		RegisterSignal(living_target, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))
		RegisterSignal(living_target, COMSIG_LIVING_DEATH, PROC_REF(destroy_component))

	RegisterSignal(parent, COMSIG_MIND_TRANSFERRED, PROC_REF(handle_mind_transfer))

/datum/component/enraptured/proc/turn_on_light()
	if(in_sight)
		SEND_SOUND(living_target, 'sound/effects/clock_tick.ogg')

	parent_client.images -= spotlight_shadow
	parent_client.screen |= fake_shadow_plane
	parent_client.images |= halogen_light
	parent_client.images |= actual_light
	return



/datum/component/enraptured/proc/get_vip_direction()
	return get_dir(get_turf(living_target), get_turf(vip))


/datum/component/enraptured/proc/handle_mind_transfer(datum/source, mob/living/new_mob)
	UnregisterSignal(living_target, list(COMSIG_LIVING_DIR_CHANGE, COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DEATH))

	living_target = new_mob
	check_range()

	RegisterSignal(living_target, COMSIG_LIVING_DIR_CHANGE, PROC_REF(set_dir_override))
	RegisterSignal(living_target, COMSIG_MOVABLE_MOVED, PROC_REF(check_range))
	RegisterSignal(living_target, COMSIG_LIVING_DEATH, PROC_REF(destroy_component))


/datum/component/enraptured/proc/destroy_component()
	SIGNAL_HANDLER
	UnregisterSignal(living_target, list(COMSIG_LIVING_DIR_CHANGE, COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DEATH))
	UnregisterSignal(vip, list(COMSIG_MOVABLE_MOVED, COMSIG_LIVING_DEATH, COMSIG_COMPONENT_ENRAPTURE_REMOVE))
	UnregisterSignal(parent, COMSIG_MIND_TRANSFERRED)
	REMOVE_TRAIT(living_target, TRAIT_ENRAPTURED, MAJESTY_1_TRAIT)
	Destroy()

/datum/component/enraptured/Destroy()
	parent_client.images -= spotlight_shadow
	parent_client.screen -= fake_shadow_plane
	parent_client.images -= halogen_light
	parent_client.images -= actual_light
	if(in_sight)
		SEND_SOUND(living_target, 'sound/effects/clock_tick.ogg')
	
	return ..()

/datum/component/enraptured/proc/check_range(datum/source)
	SIGNAL_HANDLER
	if(in_sight && ((get_dist(get_turf(vip), get_turf(living_target)) > 8) || !can_see(living_target, vip, 8)))
		
		if(parent_client.screen.Find(fake_shadow_plane))
			parent_client.screen -= fake_shadow_plane
			parent_client.images -= halogen_light
			parent_client.images -= actual_light
			animate(spotlight_shadow, alpha=204, time=0)
		animate(spotlight_shadow, alpha=0, easing=CIRCULAR_EASING|EASE_IN, time=20)
		UnregisterSignal(living_target, COMSIG_LIVING_DIR_CHANGE)
		in_sight = FALSE

	if(!in_sight && (get_dist(get_turf(vip), get_turf(living_target)) <= 8) && can_see(living_target, vip, 8))
		animate(spotlight_shadow, alpha=255, easing=CIRCULAR_EASING|EASE_IN, time=20)
		addtimer(CALLBACK(src, PROC_REF(toggle_fake_shadow_back_on)), 21, TIMER_CLIENT_TIME)

		RegisterSignal(living_target, COMSIG_LIVING_DIR_CHANGE, PROC_REF(set_dir_override))
		in_sight = TRUE
	
	if(!in_sight)
		return

	var/atom/living_target_atom = living_target
	living_target_atom.setDir(get_vip_direction())

/datum/component/enraptured/proc/toggle_fake_shadow_back_on()
	if(!in_sight)
		return
	animate(spotlight_shadow, alpha=0, time=0)
	if(!parent_client.screen.Find(fake_shadow_plane))
		SEND_SOUND(living_target, 'sound/effects/clock_tick.ogg')
		parent_client.screen |= fake_shadow_plane
		parent_client.images |= halogen_light
		parent_client.images |= actual_light

/datum/component/enraptured/proc/set_dir_override(datum/source, dir, newdir)
	SIGNAL_HANDLER
	if(newdir != get_vip_direction())
		return COMPONENT_LIVING_DIR_CHANGE_BLOCK

/datum/component/enraptured/CheckDupeComponent(datum/component, mob/living/new_vip, datum/discipline_power/vtr/new_source_power)
	if(!new_vip || !new_source_power)
		return TRUE
	
	if(SSroll.opposed_roll(
		vip,
		new_vip,
		dice_a = vip.get_total_charisma() + new_source_power.discipline.level,
		dice_b = new_vip.get_total_charisma() + source_power.discipline.level, 
		alert_atom = living_target,
		draw_goes_to_b = FALSE))
		return TRUE
	
	destroy_component()
	
	return FALSE