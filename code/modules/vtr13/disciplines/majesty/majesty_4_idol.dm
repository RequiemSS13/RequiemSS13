/datum/discipline_power/vtr/majesty/idol
	name = "Idol"
	desc = "Become so resplendant that others cannot bring themselves to so much as touch you."
	level = 4
	cancelable = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 30 SECONDS
	var/image/the_glow
	var/list/clients_affected = list()
	var/list/mobs_affected = list()
	var/idol_range = 5
	var/charmed_status_debuff = 2


/datum/discipline_power/vtr/majesty/idol/post_gain()
	the_glow = image('icons/effects/genetics.dmi', owner, "servitude", -MUTATIONS_LAYER)
	the_glow.appearance_flags = RESET_ALPHA
	if(discipline.level >= 5)
		idol_range = 6

/datum/discipline_power/vtr/majesty/idol/activate()
	. = ..()
	for(var/mob/living/victim in viewers(charmed_status_debuff, owner))
		if(!SSroll.opposed_roll(
			owner,
			victim,
			dice_a = owner.get_total_social() + discipline.level,
			dice_b = victim.get_total_social() + victim.get_total_blood() - HAS_TRAIT_FROM(victim, TRAIT_CHARMED, owner) ? charmed_status_debuff : 0, 
			alert_atom = victim,
			show_player_a = TRUE,
			show_player_b = FALSE))
			if(victim.mind)
				to_chat(victim, span_notice("An obsession for [owner] briefly sparks but you manage to suppress it."))
			continue
		affect_target(victim)

/datum/discipline_power/vtr/majesty/idol/deactivate(atom/target, direct)
	. = ..()

	//sanity check jic the client is no longer part of the linked mob
	for(var/client/affected_client in clients_affected)
		affected_client.images -= the_glow
		clients_affected -= affected_client
	
	for(var/mob/living/affected_target in mobs_affected)
		remove_idol_regular(affected_target)


/datum/discipline_power/vtr/majesty/idol/proc/affect_target(mob/living/target)
	RegisterSignal(target, COMSIG_ATOM_BULLET_ACT, PROC_REF(check_bullet_act))
	RegisterSignal(target, COMSIG_MOB_CLICKON, PROC_REF(check_click))
	RegisterSignal(target, COMSIG_MOB_ATTACKED_BY_MELEE, PROC_REF(check_attacked))
	
	apply_discipline_affliction_overlay(target, "presence", 1, 5 SECONDS)
	to_chat(target, "<span class='userlove'>[owner] is amazing. Resplendant. You are not worthy of their presence.</span>")
	mobs_affected += target
	if(target.client)
		target.client.images |= the_glow
		clients_affected += target.client



/datum/discipline_power/vtr/majesty/idol/proc/check_bullet_act(mob/living/target, obj/projectile/bullet, def_zone)
	SIGNAL_HANDLER
	if(bullet.firer == owner)
		remove_idol_violent(target)

/datum/discipline_power/vtr/majesty/idol/proc/check_attacked(mob/living/target, mob/living/attacker)
	if(attacker == owner)
		remove_idol_violent(target)

/datum/discipline_power/vtr/majesty/idol/proc/remove_idol_regular(mob/living/target)
	if(target.mind)
		to_chat(span_warning("Your compulsion to idolize [owner] fades."))
	remove_idol(target)

/datum/discipline_power/vtr/majesty/idol/proc/remove_idol_violent(mob/living/target)
	if(target.mind)
		to_chat(span_warning("Your idolitry shatters as [owner] harms you."))
	remove_idol(target)

/datum/discipline_power/vtr/majesty/idol/proc/remove_idol(mob/living/target)
	UnregisterSignal(target, list(COMSIG_ATOM_BULLET_ACT, COMSIG_MOB_CLICKON, COMSIG_MOB_ATTACKED_BY_MELEE))
	if(target.client)
		target.client.images -= the_glow
		clients_affected -= target.client
	mobs_affected -= target

/datum/discipline_power/vtr/majesty/idol/proc/check_click(datum/source, atom/clicked_atom)
	if(clicked_atom == owner)
		var/mob/living/source_mob = source
		if(source_mob?.mind)
			to_chat(source_mob, "<span class='userlove'>[owner] is too wondrous, you can't bring yourself to touch them!</span>")
		return COMSIG_MOB_CANCEL_CLICKON