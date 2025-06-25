/datum/discipline_power/vtr/animalism/possess
	name = "Possess Animal"
	desc = "Bind an animal to your will, controlling them as an extension of your body."
	level = 1
	violates_masquerade = FALSE
	cancelable = TRUE
	target_type = TARGET_LIVING
	duration_override = TRUE
	var/mob/living/simple_animal/possessed_creature = null

	var/datum/action/unpossess/unpossess_datum = null
	var/datum/mind/tracked_mind = null
	range = 7

/datum/discipline_power/vtr/animalism/possess/can_activate(mob/living/simple_animal/target, alert = FALSE)
	. = ..()
	if(possessed_creature)
		if(alert)
			to_chat(owner, span_warning("You are already possessing a creature!"))
		return FALSE
	var/datum/discipline/vtr/animalism/our_disc = discipline
	if(!target || !our_disc.allowed_types.Find(target.type))
		if(alert)
			to_chat(owner, span_warning("You cannot cast [src] on [target]!"))
		return FALSE
	if(target.mind)
		if(alert)
			to_chat(owner, span_warning("[target] resists your possession!"))
		return FALSE

/datum/discipline_power/vtr/animalism/possess/activate(mob/living/simple_animal/target)
	..()
	if(istype(target, /mob/living/simple_animal/pet/rat))
		var/mob/living/simple_animal/pet/rat/never_despawn_rat = target
		never_despawn_rat.should_despawn = FALSE
	
	tracked_mind = owner.mind
	owner.mind.transfer_to(target)
	possessed_creature = target
	unpossess_datum = new(target, src)
	unpossess_datum.Grant(target)
	RegisterSignal(possessed_creature, list(COMSIG_PARENT_QDELETING, COMSIG_PARENT_PREQDELETED, COMSIG_LIVING_DEATH), PROC_REF(deactivate_trigger))
	RegisterSignal(owner, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(deactivate_trigger))
	RegisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE, PROC_REF(prevent_other_powers))

/datum/discipline_power/vtr/animalism/possess/proc/deactivate_trigger(datum/source)
	SIGNAL_HANDLER
	deactivate()

/datum/discipline_power/vtr/animalism/possess/deactivate()
	. = ..()

	UnregisterSignal(possessed_creature, list(COMSIG_PARENT_QDELETING, COMSIG_PARENT_PREQDELETED, COMSIG_LIVING_DEATH))
	UnregisterSignal(owner, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH, COMSIG_POWER_TRY_ACTIVATE))
	if(tracked_mind)
		tracked_mind.transfer_to(owner, TRUE)
	tracked_mind = null

	qdel(unpossess_datum)
	possessed_creature = null

