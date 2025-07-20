/datum/component/frenzy_handler
	var/mob/living/current
	var/mob/living/frenzy_target
	var/last_rage_hit = 0
	var/is_draugr = FALSE

/datum/component/frenzy_handler/Initialize()
	if(!istype(parent, /datum/mind))
		return COMPONENT_INCOMPATIBLE

	var/datum/mind/brain = parent
	if(!brain.current)
		return COMPONENT_INCOMPATIBLE

	current = brain.current

	RegisterSignal(parent, COMSIG_MIND_TRY_FRENZY, PROC_REF(rollfrenzy))
	RegisterSignal(parent, COMSIG_MIND_TRANSFERRED, PROC_REF(handle_mind_transfer))
	RegisterSignal(parent, COMSIG_MIND_DRAUGR, PROC_REF(handle_draugr))

/datum/component/frenzy_handler/proc/handle_draugr(datum/source)
	if(is_draugr)
		return
	to_chat(current, "<span class='userdanger'>You have lost control of the Beast within you, and it has taken your body. Be more humane next time.</span>")
	current.ghostize(FALSE)

	is_draugr = TRUE
	if(!HAS_TRAIT(parent, TRAIT_IN_FRENZY))
		enter_frenzy()


/datum/component/frenzy_handler/proc/rollfrenzy(datum/source, situational_modifier = 0)
	SIGNAL_HANDLER
	if(HAS_TRAIT(parent, TRAIT_IN_FRENZY))
		return

	var/datum/mind/brain = parent
	current = brain.current

	if(isgarou(current) || iswerewolf(current))
		to_chat(current, "I'm full of <span class='danger'><b>ANGER</b></span>, and I'm about to flare up in <span class='danger'><b>RAGE</b></span>. Rolling...")
	else if(iskindred(current))
		to_chat(current, "I need <span class='danger'><b>BLOOD</b></span>. The <span class='danger'><b>BEAST</b></span> is calling. Rolling...")
	else
		to_chat(current, "I'm too <span class='danger'><b>AFRAID</b></span> to continue doing this. Rolling...")

	SEND_SOUND(current, sound('code/modules/wod13/sounds/bloodneed.ogg', 0, 0, 50))

	var/roll_modifiers = situational_modifier - brain.tempted_mod - (HAS_TRAIT(current, TRAIT_FERAL_CURSE) ? 2 : 0)
	var/frenzy_dice = current.get_resolve() + current.get_composure() + roll_modifiers

	var/check = SSroll.storyteller_roll(frenzy_dice, 3)

	switch(check)
		if(0)	//bad frenzy
			enter_frenzy()
			if(iskindred(current))
				addtimer(CALLBACK(src, PROC_REF(exit_frenzy)), 300)
			else
				addtimer(CALLBACK(src, PROC_REF(exit_frenzy)), 300)

		if(1 to 2)
			enter_frenzy()
			if(iskindred(current))
				addtimer(CALLBACK(src, PROC_REF(exit_frenzy)), 200)
			else
				addtimer(CALLBACK(src, PROC_REF(exit_frenzy)), 200)
		else
			if(iskindred(current))
				brain.mod_tempted(1)

/datum/component/frenzy_handler/proc/enter_frenzy()
	if(HAS_TRAIT(parent, TRAIT_IN_FRENZY))
		return
	ADD_TRAIT(parent, TRAIT_IN_FRENZY, src)
	RegisterSignal(current, COMSIG_MOB_CLICKON, PROC_REF(cancel_click))
	RegisterSignal(current, COMSIG_LIVING_DEATH, PROC_REF(handle_current_death))
	RegisterSignal(SSfrenzypool, COMSIG_HANDLE_AUTOMATED_FRENZY, PROC_REF(handle_automated_frenzy))

	if(current.m_intent == MOVE_INTENT_WALK)
		current.toggle_move_intent()
	var/blood_potency = current.get_potency()
	current.add_wits_mod(blood_potency, TRAIT_IN_FRENZY)
	current.add_physique_mod(blood_potency, TRAIT_IN_FRENZY)
	current.add_stamina_mod(blood_potency, TRAIT_IN_FRENZY)

	if(ishuman(current))
		var/mob/living/carbon/human/current_human = current
		current_human.recalculate_max_health()

	SEND_SOUND(current, sound('code/modules/wod13/sounds/frenzy.ogg', 0, 0, 50))

	current.balloon_alert(current, "<span style='color: #0000ff;'>+FRENZY</span>")
	current.add_client_colour(/datum/client_colour/glass_colour/red)
	SSfrenzypool.frenzy_list += src

/datum/component/frenzy_handler/proc/handle_current_death()
	SIGNAL_HANDLER
	is_draugr = FALSE
	exit_frenzy()

/datum/component/frenzy_handler/proc/exit_frenzy()
	if(is_draugr)
		return

	var/datum/mind/brain = parent
	if(!HAS_TRAIT(brain, TRAIT_IN_FRENZY))
		return

	UnregisterSignal(current, COMSIG_MOB_CLICKON)
	UnregisterSignal(current, COMSIG_LIVING_DEATH)
	UnregisterSignal(SSfrenzypool, COMSIG_HANDLE_AUTOMATED_FRENZY)

	current.remove_wits_mod(TRAIT_IN_FRENZY)
	current.remove_physique_mod(TRAIT_IN_FRENZY)
	current.remove_stamina_mod(TRAIT_IN_FRENZY)

	if(ishuman(current))
		var/mob/living/carbon/human/current_human = current
		current_human.recalculate_max_health()

	REMOVE_TRAIT(brain, TRAIT_IN_FRENZY, src)
	current.remove_client_colour(/datum/client_colour/glass_colour/red)
	frenzy_target = null
	brain.mod_tempted(-3, FALSE)
	current.balloon_alert(current, "<span style='color: #0000ff;'>-FRENZY</span>")
	SSfrenzypool.frenzy_list -= src

/datum/component/frenzy_handler/proc/CheckFrenzyMove()
	if(current.stat >= SOFT_CRIT || \
	current.IsSleeping() || \
	current.IsUnconscious() || \
	current.IsKnockdown() || \
	current.IsStun() || \
	HAS_TRAIT(current, TRAIT_RESTRAINED))
		return FALSE
	return TRUE

/datum/component/frenzy_handler/proc/handle_automated_frenzy()
	for(var/mob/living/carbon/human/npc/NPC in viewers(5, current))
		NPC.Aggro(current)

	if(isturf(current.loc))
		set_frenzy_targets()
		if(frenzy_target)
			var/reqsteps = SSfrenzypool.wait/current.total_multiplicative_slowdown()
			for(var/i in 1 to reqsteps)
				addtimer(CALLBACK(src, PROC_REF(frenzystep)), (i - 1)*current.total_multiplicative_slowdown())
			return

		if(CheckFrenzyMove() && isturf(current.loc))
			var/turf/next_turf = get_step(current.loc, pick(NORTH, SOUTH, WEST, EAST))
			current.face_atom(next_turf)
			current.Move(next_turf)

/datum/component/frenzy_handler/proc/set_frenzy_targets()

	if(frenzy_target && \
		get_dist(frenzy_target, current) <= 7 && \
		frenzy_target.z == current.z && \
		(!iskindred(current) || frenzy_target.blood_volume) && \
		frenzy_target.stat != DEAD)
		return

	var/list/targets = list()
	for(var/mob/living/living_victim in oviewers(7, current))
		if((!iskindred(current) || living_victim.blood_volume) && living_victim.stat != DEAD)
			targets += living_victim

	if(length(targets))
		frenzy_target = pick(targets)
		return

	frenzy_target = null

/datum/component/frenzy_handler/proc/frenzystep()
	if(!isturf(current.loc) || !CheckFrenzyMove())
		return

	current.set_glide_size(DELAY_TO_GLIDE_SIZE(current.total_multiplicative_slowdown()))

	//rotshreck
	if(iskindred(current))
		var/atom/fear
		var/last_best_dist
		for(var/obj/effect/fire/fire in GLOB.fires_list)
			if(!fire || fire.z != current.z)
				continue
			var/dist = get_dist(current, fire)
			if(dist > 7 )
				continue
			if(!last_best_dist && last_best_dist < dist)
				continue
			last_best_dist = dist
			fear = fire
		if(fear)
			step_away(current,fear,99)
			if(prob(25))
				current.emote("scream")
			return

	//if there's no target, stop doing things
	if(!frenzy_target || frenzy_target.stat == DEAD)
		return

	//frezying creature has not yet reached its destination
	var/new_dist = get_dist(frenzy_target, current)
	if(new_dist > 1)
		step_towards(current, frenzy_target)
		current.face_atom(frenzy_target)
		return

	//get sum bloood
	if(iskindred(current) && current.bloodpool <= 5 && frenzy_target.blood_volume && current.last_drinkblood_use+95 <= world.time)
		current.a_intent = INTENT_GRAB
		var/mob/living/carbon/human/human_current = current

		if(current.grab_state < GRAB_AGGRESSIVE)
			frenzy_target.grabbedby(human_current)

		if(current.grab_state < GRAB_AGGRESSIVE)
			if(isnpc(frenzy_target))
				frenzy_target.emote("scream")
			return

		if(human_current.CheckEyewitness(frenzy_target, current, 7, FALSE))
			human_current.AdjustMasquerade(-1)

		human_current.vamp_bite()
		return

	//beat the shit out of it
	current.a_intent = INTENT_HARM
	if(last_rage_hit+5 < world.time)
		last_rage_hit = world.time
		current.UnarmedAttack(frenzy_target)



/datum/component/frenzy_handler/proc/handle_mind_transfer(datum/source, mob/living/new_character)
	SIGNAL_HANDLER
	if(!HAS_TRAIT(source, TRAIT_IN_FRENZY))
		return

	UnregisterSignal(current, COMSIG_LIVING_DEATH)
	UnregisterSignal(current, COMSIG_MOB_CLICKON)
	RegisterSignal(new_character, COMSIG_MOB_CLICKON, PROC_REF(cancel_click))
	RegisterSignal(new_character, COMSIG_LIVING_DEATH, PROC_REF(handle_current_death))

	var/blood_potency = current.get_potency()
	current.remove_wits_mod(TRAIT_IN_FRENZY)
	current.remove_physique_mod(TRAIT_IN_FRENZY)
	current.remove_stamina_mod(TRAIT_IN_FRENZY)

	if(ishuman(current))
		var/mob/living/carbon/human/current_human = current
		current_human.recalculate_max_health()

	blood_potency = new_character.get_potency()
	current.add_wits_mod(blood_potency, TRAIT_IN_FRENZY)
	current.add_physique_mod(blood_potency, TRAIT_IN_FRENZY)
	current.add_stamina_mod(blood_potency, TRAIT_IN_FRENZY)

	if(ishuman(current))
		var/mob/living/carbon/human/new_character_human = new_character
		new_character_human.recalculate_max_health()

	current = new_character

/datum/component/frenzy_handler/proc/cancel_click()
	SIGNAL_HANDLER
	to_chat(current, span_warning("The beast is in control now."))
	return COMSIG_MOB_CANCEL_CLICKON
