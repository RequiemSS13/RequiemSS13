//SPIRIT'S TOUCH
/datum/discipline_power/vtr/auspex/the_spirits_touch
	name = "Spirit's Touch"
	desc = "Feel the psychic resonances left on objects around you."

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SEE|DISC_CHECK_CONSCIOUS

	level = 3

	range = 1
	target_type = TARGET_LIVING | TARGET_OBJ | TARGET_SELF | TARGET_TURF
	
	deactivate_sound = null

/datum/discipline_power/vtr/auspex/the_spirits_touch/activate(atom/target)
	. = ..()
	var/list/result = target.examine(owner)
	result.Add(target.spirit_touch_description(owner))
	to_chat(owner, result.Join("\n"))
