/datum/discipline_power/vtr/animalism/possess
	name = "Possess Animal"
	desc = "Elgeon write a description kthx. Get that rat in you"
	level = 1
	violates_masquerade = FALSE
	cancelable = TRUE
	target_type = TARGET_LIVING
	var/mob/living/simple_animal/possessed_creature = null
	var/list/allowed_types = list(
		/mob/living/simple_animal/hostile/beastmaster/rat,
		/mob/living/simple_animal/hostile/beastmaster/cat,
		/mob/living/simple_animal/pet/rat,
		/mob/living/simple_animal/pet/cat/vampire
	)
	range = 7

/datum/discipline_power/vtr/animalism/possess/can_activate(mob/living/simple_animal/target, alert = FALSE)
	. = ..()
	if(possessed_creature)
		to_chat(owner, span_warning("You arealready possessing a creature!</span>"))

	if(!target || !allowed_types.Find(target.type))
		to_chat(owner, span_warning("You cannot cast [src] on [target]!</span>"))
		return FALSE
	if(target.mind)
		to_chat(owner, span_warning("[target] resists your possession!"))
		return FALSE
	
	

/datum/discipline_power/vtr/animalism/possess/activate(mob/living/simple_animal/target)
	..()
	if(istype(target, /mob/living/simple_animal/pet/rat))
		// Hex TODO: make rats not delete themselves after I reorganize npcroles
		return
	owner.mind.transfer_to(target)
	possessed_creature = target
	RegisterSignal(possessed_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(deactivate_trigger))
	RegisterSignal(owner, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(deactivate_trigger))
	RegisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE, PROC_REF(prevent_other_powers))

/datum/discipline_power/vtr/animalism/possess/proc/prevent_other_powers(datum/source, datum/target)
	SIGNAL_HANDLER
	to_chat(owner, span_warning("You cannot use other disciplines while possessing a creature!"))
	return POWER_PREVENT_ACTIVATE

/datum/discipline_power/vtr/animalism/possess/proc/deactivate_trigger(datum/source)
	SIGNAL_HANDLER
	try_deactivate()

/datum/discipline_power/vtr/animalism/possess/deactivate()
	. = ..()

	UnregisterSignal(possessed_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH))
	UnregisterSignal(owner, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH, COMSIG_POWER_TRY_ACTIVATE))
	if(possessed_creature.mind)
		possessed_creature.mind.transfer_to(owner)
	possessed_creature = null
