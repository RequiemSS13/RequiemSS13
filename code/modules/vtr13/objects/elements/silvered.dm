/datum/element/silvered
	element_flags = ELEMENT_DETACH

/datum/element/silvered/Attach(atom/target)
	. = ..()
	if(istype(target, /obj/projectile))
		RegisterSignal(target, COMSIG_PROJECTILE_ON_HIT, PROC_REF(bullet_act))
		return


	if(!isitem(target))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(target, COMSIG_ITEM_ATTACK, PROC_REF(on_attack))
	RegisterSignal(target, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))

/datum/element/silvered/proc/bullet_act(datum/source, atom/movable/firer, atom/target)
	if(!iscarbon(target) || (!HAS_TRAIT(target, TRAIT_SILVER_BANE) && !iswerewolf(target) && !isgarou(target)))
		return
	
	var/mob/living/carbon/carbon_target = target
	to_chat(target, span_warning("<b>The bullet burns! It is silver!</b>"))
	if((iswerewolf(target) || isgarou(target)) && carbon_target.auspice.gnosis && prob(50))
		adjust_gnosis(-1, carbon_target)
	carbon_target.apply_damage(20, CLONE)
	carbon_target.apply_status_effect(STATUS_EFFECT_SILVER_SLOWDOWN)

/datum/element/silvered/proc/on_attack(datum/source, mob/target, mob/user)
	SIGNAL_HANDLER

	if(user.stat)
		return

	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] presses \the [source] against \the [target]."))
	
	if(!iscarbon(target) || (!HAS_TRAIT(target, TRAIT_SILVER_BANE) && !iswerewolf(target) && !isgarou(target)))
		return

	var/mob/living/carbon/carbon_target = target
	carbon_target.apply_damage(20, CLONE)
	to_chat(carbon_target, "<span class='userdanger'>The silver burns hot on your flesh!</span>", confidential = TRUE)

/datum/element/silvered/proc/on_pickup(datum/source, mob/holder)
	if(!iscarbon(holder) || (!HAS_TRAIT(holder, TRAIT_SILVER_BANE) && !iswerewolf(holder) && !isgarou(holder)))
		return
	addtimer(CALLBACK(src, PROC_REF(drop_it_like_it_is_hot), holder, source), rand(2,8))


/datum/element/silvered/proc/drop_it_like_it_is_hot(mob/living/carbon/holder, obj/item/silver_item)
	if(!holder || !silver_item || silver_item.loc != holder)
		return

	holder.apply_damage(20, CLONE)
	
	if(holder.dropItemToGround(silver_item))
		to_chat(holder, span_warning("\The [silver_item] hurts to touch! You cast it away in fear!"))
		return
	to_chat(holder, span_warning("\The [silver_item] hurts you, but you cannot drop it!"))
	addtimer(CALLBACK(src, PROC_REF(drop_it_like_it_is_hot), holder), 5 SECONDS)

/datum/element/silvered/Detach(datum/target)
	UnregisterSignal(target, COMSIG_PROJECTILE_ON_HIT)
	UnregisterSignal(target, COMSIG_ITEM_ATTACK)
	UnregisterSignal(target, COMSIG_ITEM_PICKUP)