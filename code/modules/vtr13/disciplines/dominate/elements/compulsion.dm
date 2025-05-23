/datum/element/compulsion
	var/list/mob_deactivate_signals = list(
		COMSIG_MOB_ATTACKED_HAND,
		COMSIG_MOB_ATTACKED_BY_MELEE,
		COMSIG_LIVING_DEATH,
		COMSIG_DOMINATE_ACT_END_EARLY
	)

/datum/element/compulsion/Attach(datum/target, mob/living/aggressor, datum/dominate_act/act, custom_signals = null)
	..()

	if(!act || !istype(act, /datum/dominate_act) || !isliving(target))
		return COMPONENT_INCOMPATIBLE

	act.apply(target, aggressor, src)

	//we don't need to listen for signals when the dominate_act is a one-off
	if(!act.no_remove)
		RegisterSignal(target, mob_deactivate_signals, PROC_REF(Detach))
	else
		Detach(target, FALSE) //Auto-detach for no_remove instances

/datum/element/compulsion/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, mob_deactivate_signals)