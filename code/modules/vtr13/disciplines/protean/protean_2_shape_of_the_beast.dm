#define PROTEAN_ANIMAL_FORM_RAT "Rat (1 Blood)"
#define PROTEAN_ANIMAL_FORM_RAT_COST 1

#define PROTEAN_ANIMAL_FORM_CAT "Cat (1 Blood)"
#define PROTEAN_ANIMAL_FORM_CAT_COST 1

#define PROTEAN_ANIMAL_FORM_BAT "Bat (2 Blood)"
#define PROTEAN_ANIMAL_FORM_BAT_COST 2

#define PROTEAN_ANIMAL_FORM_DEER "Deer (2 Blood)"
#define PROTEAN_ANIMAL_FORM_DEER_COST 2

#define PROTEAN_ANIMAL_FORM_WOLF "Wolf (2 Blood)"
#define PROTEAN_ANIMAL_FORM_WOLF_COST 2

#define PROTEAN_ANIMAL_FORM_BEAR "A Fucking Bear (5 Blood)"
#define PROTEAN_ANIMAL_FORM_BEAR_COST 5

/datum/discipline_power/vtr/protean/shape_of_the_beast
	name = "Shape of the Beast"
	desc = "Take on the form of an animal."

	level = 2

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	duration_override = TRUE

	bothers_with_duration_timers = FALSE

	cooldown_length = 60 SECONDS

	var/list/shapeshift_types = list(
		PROTEAN_ANIMAL_FORM_RAT = /mob/living/simple_animal/hostile/beastmaster/rat,
		PROTEAN_ANIMAL_FORM_CAT = /mob/living/simple_animal/hostile/beastmaster/cat)

	var/mob/living/shapeshifted_creature

	var/obj/effect/proc_holder/spell/targeted/shapeshift/protean/GA

	var/datum/action/select_protean_shape/select_shape_action

	var/datum/action/deactivate_protean_shape/deactivate_shape_action

	var/desired_form = PROTEAN_ANIMAL_FORM_RAT
	
/datum/discipline_power/vtr/protean/shape_of_the_beast/post_gain()
	. = ..()
	if(discipline.level >= 3)
		shapeshift_types[PROTEAN_ANIMAL_FORM_BAT] = /mob/living/simple_animal/hostile/beastmaster/rat/flying
		shapeshift_types[PROTEAN_ANIMAL_FORM_DEER] = /mob/living/simple_animal/deer
	if(discipline.level >= 4)
		shapeshift_types[PROTEAN_ANIMAL_FORM_WOLF] = /mob/living/simple_animal/hostile/beastmaster
	if(discipline.level == 5)
		shapeshift_types[PROTEAN_ANIMAL_FORM_BEAR] = /mob/living/simple_animal/hostile/bear/wod13/protean_shapeshift_bear
	select_shape_action =  new(owner, src)
	select_shape_action.Grant(owner)

/datum/discipline_power/vtr/protean/shape_of_the_beast/spend_resources()
	var/cost = 1
	switch(desired_form)
		if(PROTEAN_ANIMAL_FORM_RAT)
			cost = PROTEAN_ANIMAL_FORM_RAT_COST
		if(PROTEAN_ANIMAL_FORM_CAT)
			cost = PROTEAN_ANIMAL_FORM_CAT_COST
		if(PROTEAN_ANIMAL_FORM_BAT)
			cost = PROTEAN_ANIMAL_FORM_BAT_COST
		if(PROTEAN_ANIMAL_FORM_DEER)
			cost = PROTEAN_ANIMAL_FORM_DEER_COST
		if(PROTEAN_ANIMAL_FORM_WOLF)
			cost = PROTEAN_ANIMAL_FORM_WOLF_COST
		if(PROTEAN_ANIMAL_FORM_BEAR)
			cost = PROTEAN_ANIMAL_FORM_BEAR_COST

	if(owner.bloodpool <= cost)
		return FALSE
	owner.bloodpool = owner.bloodpool - cost
	owner.update_action_buttons()
	return TRUE

/datum/discipline_power/vtr/protean/shape_of_the_beast/pre_activation_checks()
	owner.do_jitter_animation(30)
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	owner.visible_message(span_alert("[owner]'s body emits visceral cracks and groans as they begin to change form!"))
	ADD_TRAIT(owner, TRAIT_UNMASQUERADE, PROTEAN_4_TRAIT)
	var/successful_transform = FALSE
	if(do_mob(owner, owner, 5 SECONDS))
		successful_transform = TRUE
	REMOVE_TRAIT(owner, TRAIT_UNMASQUERADE, PROTEAN_4_TRAIT)
	return successful_transform

/datum/discipline_power/vtr/protean/shape_of_the_beast/activate()
	. = ..()
	if (!GA)
		GA = new(owner)
	owner.drop_all_held_items()
	var/shape_to_use = shapeshift_types[desired_form]
	GA.shapeshift_type = shape_to_use
	shapeshifted_creature = GA.Shapeshift(owner)
	
	if(!shapeshifted_creature)
		return
	deactivate_shape_action = new(shapeshifted_creature, src)
	deactivate_shape_action.Grant(shapeshifted_creature)
	
	RegisterSignal(shapeshifted_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH), PROC_REF(deactivate_trigger))
	RegisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE, PROC_REF(prevent_other_powers))


/datum/discipline_power/vtr/protean/shape_of_the_beast/deactivate()
	. = ..()
	owner.Stun(1.5 SECONDS)
	owner.do_jitter_animation(30)
	qdel(deactivate_shape_action)
	UnregisterSignal(shapeshifted_creature, list(COMSIG_PARENT_QDELETING, COMSIG_LIVING_DEATH))
	UnregisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE)
	if(shapeshifted_creature)
		playsound(get_turf(shapeshifted_creature), 'sound/effects/dismember.ogg', 100, TRUE, -6)
		shapeshifted_creature.visible_message(span_alert("[shapeshifted_creature]'s body emits visceral cracks and groans as they suddenly revert into [owner]!"))
		GA.Restore(GA.myshape)

//Action button for selecting
/datum/action/select_protean_shape
	name = "Select Protean Shapes"
	desc = "Choose which creatures to turn into when you use your protean abilities."
	background_icon_state = "gift"
	icon_icon = 'code/modules/wod13/UI/actions.dmi'
	button_icon_state = "protean"
	var/datum/discipline_power/vtr/protean/shape_of_the_beast/discipline_power

/datum/action/select_protean_shape/New(Target, datum/discipline_power/vtr/protean/shape_of_the_beast/power)
	..(Target)
	discipline_power = power


/datum/action/select_protean_shape/Trigger()
	var/selection = tgui_input_list(owner, "Select what creature Shape of the Beast turns you into:", "Animal Shapeshift Selection", discipline_power.shapeshift_types, discipline_power.desired_form)
	if(selection)
		discipline_power.desired_form = selection


#undef PROTEAN_ANIMAL_FORM_RAT
#undef PROTEAN_ANIMAL_FORM_RAT_COST

#undef PROTEAN_ANIMAL_FORM_CAT
#undef PROTEAN_ANIMAL_FORM_CAT_COST

#undef PROTEAN_ANIMAL_FORM_DEER
#undef PROTEAN_ANIMAL_FORM_DEER_COST

#undef PROTEAN_ANIMAL_FORM_WOLF
#undef PROTEAN_ANIMAL_FORM_WOLF_COST

#undef PROTEAN_ANIMAL_FORM_BEAR
#undef PROTEAN_ANIMAL_FORM_BEAR_COST