/mob/living/proc/add_merit(merittype, spawn_effects) //separate proc due to the way these ones are handled
	if(HAS_TRAIT(src, merittype))
		return
	var/datum/merit/T = merittype
	var/qname = initial(T.name)
	if(!SSmerits || !SSmerits.merits[qname])
		return
	
	new merittype (src, spawn_effects)
	return TRUE

/mob/living/proc/remove_merit(merittype)
	for(var/datum/merit/Q in roundstart_merits)
		if(Q.type == merittype)
			qdel(Q)
			return TRUE
	return FALSE

/mob/living/proc/has_merit(merittype)
	for(var/datum/merit/Q in roundstart_merits)
		if(Q.type == merittype)
			return TRUE
	return FALSE