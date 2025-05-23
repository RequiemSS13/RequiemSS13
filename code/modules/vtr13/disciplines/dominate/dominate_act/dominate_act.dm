//A datum processed and applied via element/compulsion.
//all relevant instances for it are stored in SSdominate_act, you should never declare one.
//No procs for this datum or any of its children should be called outside of element/compulsion.
/datum/dominate_act
	var/phrase = "PLACEHOLDER 1" //MUST BE UNIQUE
	var/activate_verb = "placeholder"
	var/linked_trait = null //Set this if you set a duration
	var/no_remove = FALSE //Set to TRUE if the compulsion doesn't need to be removed
	var/duration

/datum/dominate_act/proc/can_attach(datum/target)
	SHOULD_CALL_PARENT(TRUE)
	if(linked_trait && HAS_TRAIT_FROM(target, linked_trait, DOMINATE_ACT_TRAIT))
		return FALSE

	var/mob/living/living_victim = target
	if(!living_victim || living_victim.stat >= UNCONSCIOUS || living_victim.IsSleeping() || living_victim.is_dominated)
		return FALSE

	return TRUE

/datum/dominate_act/proc/request_early_removal(datum/target)
	SEND_SIGNAL(target, COMSIG_DOMINATE_ACT_END_EARLY)

/datum/dominate_act/proc/apply_message(mob/living/target)
	to_chat(target, span_danger("You are x'd to [activate_verb]."))

/datum/dominate_act/proc/apply(mob/living/target, mob/living/aggressor, datum/element/linked_element)
	SHOULD_CALL_PARENT(TRUE)

	if(target.mind)
		apply_message(target)

	if(no_remove)
		return

	target.is_dominated = TRUE

	if(linked_trait)
		ADD_TRAIT(target, linked_trait, DOMINATE_ACT_TRAIT)

	if(duration)
		addtimer(CALLBACK(src, PROC_REF(remove), target, linked_element), duration)

	RegisterSignal(target, COMSIG_ELEMENT_DETACH, PROC_REF(remove)) //Detach when the parent element detaches.

/datum/dominate_act/proc/remove(datum/source, datum/element/linked_element)
	SIGNAL_HANDLER
	SHOULD_CALL_PARENT(TRUE)
	
	if(no_remove)
		CRASH("Hey uh dominate_act '[phrase]' has NO_REMOVE turned on, but remove() was called.")
	
	if(!istype(linked_element, /datum/element/compulsion))
		return FALSE

	if(!isliving(source))
		CRASH("Are You trying to remove a dominate_act from a person who doesn't exist? What???")
	
	var/mob/living/source_mob = source
	source_mob.is_dominated = FALSE
	
	if(linked_trait && !HAS_TRAIT(source, linked_trait))
		return FALSE
	
	if(source_mob.mind)
		to_chat(source_mob, span_notice("You no longer need to [activate_verb]."))
	
	UnregisterSignal(source, COMSIG_ELEMENT_DETACH)

	REMOVE_TRAIT(source, linked_trait, DOMINATE_ACT_TRAIT)

	return TRUE
