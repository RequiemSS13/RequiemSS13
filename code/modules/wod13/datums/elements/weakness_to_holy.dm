/**
 * # Holy Weakness
 *
 * A weakness that causes affected
 * mobs to periodically light on fire
 * when entering holy areas. Currently
 * "holy areas" means churches.
 */
/datum/element/holy_weakness
	element_flags = ELEMENT_DETACH

	/// Mobs being exposed to and harmed by holiness
	var/list/mob/living/exposed_to_holiness

/datum/element/holy_weakness/Attach(datum/target)
	. = ..()

	if (!isliving(target))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_ENTER_AREA, PROC_REF(handle_enter_area))


/datum/element/holy_weakness/Detach(datum/source, force)
	UnregisterSignal(source, COMSIG_ENTER_AREA)
	LAZYREMOVE(exposed_to_holiness, source)

	return ..()

/datum/element/holy_weakness/proc/handle_enter_area(mob/living/source, area/vtm/vtr/entered_area)
	SIGNAL_HANDLER
	// Holy weakness only triggers on entering churches
	if (!entered_area?.holy_ground)
		LAZYREMOVE(exposed_to_holiness, source)
	else
		LAZYADD(exposed_to_holiness, source)
		if(source.mind)
			to_chat(source, span_danger("You must leave this holy place. It is not for you."))
	
	if(exposed_to_holiness && length(exposed_to_holiness))
		// Start repeatedly setting this mob on fire if they stay in the holy area
		START_PROCESSING(SSdcs, src)
	else
		STOP_PROCESSING(SSdcs, src)

/datum/element/holy_weakness/process(delta_time)
	// Ignite all exposed mobs on a probability of ~50% per 4 seconds
	for (var/mob/living/cursed_mob as anything in exposed_to_holiness)
		if (!DT_PROB(12.5, delta_time))
			continue

		to_chat(cursed_mob, span_userdanger("Your body begins to burn! You must leave this place!"))
		cursed_mob.apply_damage(20, BURN)

