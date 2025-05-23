/datum/discipline_power/vtr/protean/misty_dispersal
	name = "Mist Form"
	desc = "Become a cloud of blood, traveling through doors and coalescing somewhere else."
	level = 5
	vitae_cost = 8
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE
	cooldown_length = 15 MINUTES
	duration_length = 15 SECONDS
	violates_masquerade = TRUE
	cancelable = TRUE
	
	var/mob/living/shapeshifted_creature

	var/obj/effect/proc_holder/spell/targeted/shapeshift/protean/GA

	var/datum/action/deactivate_protean_shape/deactivate_shape_action

	var/mist_form = /mob/living/simple_animal/hostile/blood_mist

/datum/discipline_power/vtr/protean/misty_dispersal/activate()
	. = ..()
	owner.visible_message(span_alert("[owner] explodes into a cloud of stinking, acidic blood!"))
	var/datum/effect_system/smoke_spread/blood_mist/smoke = new
	smoke.set_up(4, owner)
	smoke.start()
	playsound(get_turf(owner), 'sound/effects/smoke.ogg', 50, TRUE)

	if (!GA)
		GA = new(owner)
	GA.shapeshift_type = mist_form
	owner.drop_all_held_items()
	shapeshifted_creature = GA.Shapeshift(owner)

	if(!shapeshifted_creature)
		return
	deactivate_shape_action = new(shapeshifted_creature, src)
	deactivate_shape_action.Grant(shapeshifted_creature)

	RegisterSignal(shapeshifted_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(deactivate_trigger))
	RegisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE, PROC_REF(prevent_other_powers))


/datum/discipline_power/vtr/protean/misty_dispersal/deactivate()
	. = ..()
	qdel(deactivate_shape_action)
	UnregisterSignal(shapeshifted_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH))
	UnregisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE)
	if(shapeshifted_creature)
		GA.Restore(GA.myshape)

