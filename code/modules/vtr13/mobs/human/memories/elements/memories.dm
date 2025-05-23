
//Element handling the creation and deletion of memories, based on the splat of the holder
/datum/element/memories
	element_flags = ELEMENT_DETACH

/datum/element/memories/Attach(datum/target)
	. = ..()

	if(!istype(target, /datum/mind))
		return ELEMENT_INCOMPATIBLE
	var/datum/mind/target_mind = target
	if(!target_mind.current || !istype(target_mind.current, /mob/living/carbon))
		return ELEMENT_INCOMPATIBLE

	var/datum/component/memory_component = target_mind.AddComponent(/datum/component/base_memory, target_mind.current)

	if(!memory_component)
		return ELEMENT_INCOMPATIBLE

	if(ishumanbasic(target_mind.current))
		memory_component.AddElement(/datum/element/human_memory_modifier, target_mind.current)

	if(iskindred(target_mind.current))
		memory_component.AddElement(/datum/element/kindred_memory_modifier, target_mind.current)

	if(isghoul(target_mind.current))
		memory_component.AddElement(/datum/element/ghoul_memory_modifier, target_mind.current)


/datum/element/memories/Detach(datum/source, force)
	. = ..()
	SEND_SIGNAL(source, COMSIG_MEMORY_DELETE)