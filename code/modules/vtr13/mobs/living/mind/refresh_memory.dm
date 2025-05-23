/datum/mind/proc/refresh_memory()
	if(!current && istype(current, /mob/living/carbon))
		return
	src.RemoveElement(/datum/element/memories)
	src.AddElement(/datum/element/memories)

	if(iskindred(current) || isgarou(current))
		src.AddComponent(/datum/component/frenzy_handler)