
/datum/discipline_power/vtr/protean/horrid_form
	name = "Horrid Form"
	desc = "Become an apex predator."

	level = 4

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	toggled = TRUE

	duration_length = 10 SECONDS
	cooldown_length = 20 SECONDS
	var/mob/living/shapeshifted_creature

	var/obj/effect/proc_holder/spell/targeted/shapeshift/protean/GA

	var/datum/discipline_power/vtr/protean/shape_of_the_beast/discipline_power

	var/datum/action/deactivate_protean_shape/deactivate_shape_action

	var/horrid_form = /mob/living/simple_animal/hostile/protean

/datum/discipline_power/vtr/protean/horrid_form/post_gain()
	. = ..()
	if(discipline.level == 5)
		horrid_form =  /mob/living/simple_animal/hostile/protean/best

/datum/discipline_power/vtr/protean/horrid_form/activate()
	. = ..()
	owner.visible_message(span_alert("[owner]'s body begins to distort and reform into something MONSTEROUS!"))
	if (!GA)
		GA = new(owner)
	GA.shapeshift_type = horrid_form
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	owner.drop_all_held_items()
	shapeshifted_creature = GA.Shapeshift(owner)
	deactivate_shape_action = new(shapeshifted_creature, src)
	deactivate_shape_action.Grant(shapeshifted_creature)
	RegisterSignal(shapeshifted_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(deactivate_trigger))

/datum/discipline_power/vtr/protean/horrid_form/deactivate()
	. = ..()
	owner.Stun(3 SECONDS)
	owner.do_jitter_animation(30)
	qdel(deactivate_shape_action)
	UnregisterSignal(shapeshifted_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH))
	if(shapeshifted_creature)
		GA.Restore(GA.myshape)