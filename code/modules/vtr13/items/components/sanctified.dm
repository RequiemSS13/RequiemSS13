/datum/component/sanctified
	var/last_detonated = 0
	var/cooldown =  60 SECONDS

/datum/component/sanctified/Initialize()
	if(!isitem(parent))
		return ELEMENT_INCOMPATIBLE
	RegisterSignal(parent, COMSIG_ITEM_ATTACK_SELF, PROC_REF(on_attack_self))
	RegisterSignal(parent, COMSIG_ITEM_ATTACK, PROC_REF(on_attack))
	RegisterSignal(parent, COMSIG_ITEM_PICKUP, PROC_REF(on_pickup))

/datum/component/sanctified/proc/on_attack_self(datum/source, mob/user)
	SIGNAL_HANDLER
	if(user.stat || last_detonated+cooldown > world.time)
		return
	last_detonated = world.time

	for(var/mob/living/target in get_hearers_in_view(4, user.loc))
		if(HAS_TRAIT(target, TRAIT_HOLY_WEAKNESS))
			SEND_SOUND(target, sound('code/modules/wod13/sounds/cross.ogg', 0, 0, 50))
			bang(target, user)

/datum/component/sanctified/proc/bang(mob/living/target, var/mob/living/user)
	if(target.stat == DEAD)	//They're dead!
		return
		
	target.show_message("<span class='warning'><b>THE FAITH IS BLINDING!</b></span>", MSG_AUDIBLE)
	var/distance = max(0, get_dist(get_turf(parent), get_turf(target)))

	if(target.flash_act(affect_silicon = 1))
		target.Immobilize(max(10/max(1,distance), 5))

/datum/component/sanctified/proc/on_attack(datum/source, mob/target, mob/user)
	SIGNAL_HANDLER
	if(user.a_intent == INTENT_HELP)
		user.visible_message(span_notice("[user] presses \the [source] against \the [target]."))
	
	if(!iscarbon(target))
		return

	if(!HAS_TRAIT(target, TRAIT_HOLY_WEAKNESS))
		return

	if(user.stat || last_detonated+cooldown > world.time)
		return

	last_detonated = world.time

	var/mob/living/carbon/carbon_target = target
	carbon_target.apply_damage(15, BURN)
	INVOKE_ASYNC(carbon_target, TYPE_PROC_REF(/mob, emote), "scream")
	to_chat(carbon_target, "<span class='userdanger'>The zeal burns hot on your flesh!</span>", confidential = TRUE)

/datum/component/sanctified/proc/on_pickup(datum/source, mob/holder)
	if(!HAS_TRAIT(holder, TRAIT_HOLY_WEAKNESS) || !iscarbon(holder))
		return
	addtimer(CALLBACK(src, PROC_REF(drop_it_like_it_is_hot), holder), rand(2,8))


/datum/component/sanctified/proc/drop_it_like_it_is_hot(mob/living/carbon/holder)
	if(!holder || !parent)
		return
	var/atom/parent_atom = parent
	if(parent_atom.loc != holder)
		return

	holder.apply_damage(10, BURN)
	if(holder.dropItemToGround(parent) || !HAS_TRAIT(holder, TRAIT_HOLY_WEAKNESS))
		to_chat(holder, span_warning("\The [parent] burns you! You cast it away in fear!"))
		return
	to_chat(holder, span_warning("\The [parent] burns you, but you cannot drop it!"))
	addtimer(CALLBACK(src, PROC_REF(drop_it_like_it_is_hot), holder), 5 SECONDS)