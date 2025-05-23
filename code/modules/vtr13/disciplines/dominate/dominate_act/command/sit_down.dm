/datum/forced_movement/dominate_command

/datum/dominate_act/command/sit_down
	phrase = "Sit down."
	activate_verb = "sit down"
	linked_trait = TRAIT_COMMAND_SIT_DOWN
	duration = 5 SECONDS

/datum/dominate_act/command/sit_down/apply(mob/living/target, mob/living/aggressor)
	..()
	var/obj/structure/chair/a_chair
	for(var/obj/structure/chair/chair in view(7, get_turf(target)))
		a_chair = chair
		break
	if(!a_chair)
		target.set_resting(FALSE, TRUE, TRUE)

	var/forced_movement = new /datum/forced_movement/dominate_command(target, a_chair)
	RegisterSignal(forced_movement, COMSIG_PARENT_PREQDELETED, PROC_REF(buckle_self))

	
	
/datum/dominate_act/command/sit_down/proc/buckle_self(datum/forced_movement/source)
	if(!source)
		return
	UnregisterSignal(source, COMSIG_PARENT_PREQDELETED)
	
	if(!source.target || !source.victim)
		return

	if(get_turf(source.target) != get_turf(source.victim))
		return

	var/mob/living/victim = source.victim

	var/obj/structure/chair/chair = source.target
	chair.buckle_mob(victim)
	request_early_removal(victim)

/datum/dominate_act/command/sit_down/remove(mob/living/target)
	. = ..()
	if(!.)
		return
	
	if(!target.force_moving || !istype(target.force_moving, /datum/forced_movement/dominate_command))
		return

	UnregisterSignal(target.force_moving, COMSIG_PARENT_PREQDELETED)
	target.force_moving = null