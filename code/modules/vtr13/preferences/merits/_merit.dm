//Late-stage TGcode doesn't work with existing merit code even slightly.
//So if I'm gonna fuckin do this thing, I have to make it separate for the sake of my sanity.
//When rebase comes, if rebase comes, we can switch over to TG's system and these should sort-of work.

/datum/merit
	var/name = "Test Requiem Merit"
	var/desc = "This is a test merit."
	var/dots = 0
	var/human_only = TRUE
	var/gain_text
	var/lose_text
	var/mob_trait
	var/mob/living/merit_holder
	var/category = MERIT_MERIT

	var/abstract_type = /datum/merit
	
	var/processing_trait = FALSE 

	var/categories_reset_on_remove //comma delimited string. Will cause the listed categories to be wiped clean if quirk is removed in preferences.
	var/categories_reset_on_add //comma delimited string. Will cause the listed categories to be wiped clean if quirk is removed in preferences.
	
	var/recalculate_loadout = FALSE	//Recalculates loadouts when this merit is added/removed

	var/splat_flags = 0
	var/faction_flags = 0
	var/clan_flags = 0
	var/custom_setting_required = TRUE
	var/custom_setting_types //comma delimited string of setting keys
	var/list/custom_settings

/datum/merit/New(mob/living/merit_mob, spawn_effects)
	if(!merit_mob || (human_only && !ishuman(merit_mob)) || merit_mob.has_merit(type) || !SSmerits.CanAddMerit(merit_mob?.client?.prefs, src.type))
		qdel(src)
		return
	merit_holder = merit_mob
	SSmerits.merit_objects += src
	if(gain_text)
		to_chat(merit_holder, gain_text)
	
	merit_holder.roundstart_merits += src
	if(mob_trait)
		ADD_TRAIT(merit_holder, mob_trait, ROUNDSTART_TRAIT)
	
	if(processing_trait)
		START_PROCESSING(SSmerits, src)
	
	if(merit_holder.client)
		if(!populate_settings(merit_mob))
			qdel(src)
			return

	add()
	if(spawn_effects)
		on_spawn()
	if(merit_holder.client)
		post_add()
	else
		RegisterSignal(merit_holder, COMSIG_MOB_LOGIN, PROC_REF(on_merit_holder_first_login))
	
	return ..()


/**
 * On client connection set merit preferences.
 *
 * Run post_add to set the client preferences for the merit.
 * Clear the attached signal for login.
 * Used when the merit has been gained and no client is attached to the mob.
 */
/datum/merit/proc/on_merit_holder_first_login(mob/living/source)
	SIGNAL_HANDLER
	UnregisterSignal(source, COMSIG_MOB_LOGIN)
	if(!populate_settings(source))
		qdel(src)
		return
	post_add()

/datum/merit/Destroy()
	if(processing_trait)
		STOP_PROCESSING(SSmerits, src)
	if(merit_holder)
		to_chat(merit_holder, lose_text)
		merit_holder.roundstart_merits -= src
		if(mob_trait)
			REMOVE_TRAIT(merit_holder, mob_trait, ROUNDSTART_TRAIT)
	remove()
	SSmerits.merit_objects -= src
	return ..()

/datum/merit/proc/transfer_mob(mob/living/to_mob)
	merit_holder.roundstart_merits -= src
	to_mob.roundstart_merits += src
	if(mob_trait)
		REMOVE_TRAIT(merit_holder, mob_trait, ROUNDSTART_TRAIT)
		ADD_TRAIT(to_mob, mob_trait, ROUNDSTART_TRAIT)
	merit_holder = to_mob
	on_transfer()


/datum/merit/proc/populate_settings(mob/user)
	if(!custom_setting_types)
		return TRUE
	var/datum/preferences/prefs = user?.client?.prefs
	if(!prefs)
		return TRUE

	for(var/setting_name in SSmerits.merit_setting_keys[src.name])
		var/datum/merit_setting/setting = SSmerits.all_merit_settings[setting_name]
		setting.populate(user, prefs, src)
	
	if(custom_setting_required && (!custom_settings || !length(custom_settings)))
		return FALSE
	
	return TRUE


/datum/merit/proc/add() //special "on add" effects
/datum/merit/proc/on_spawn() //these should only trigger when the character is being created for the first time, i.e. roundstart/latejoin
/datum/merit/proc/remove() //special "on remove" effects
/datum/merit/proc/on_process() //process() has some special checks, so this is the actual process
/datum/merit/proc/post_add() //for text, disclaimers etc. given after you spawn in with the trait
/datum/merit/proc/on_transfer() //code called when the trait is transferred to a new mob

/datum/merit/process(delta_time)
	if(QDELETED(merit_holder))
		merit_holder = null
		qdel(src)
		return
	if(merit_holder.stat == DEAD)
		return
	on_process(delta_time)


/mob/living/proc/cleanse_merit_datums() //removes all trait datums
	for(var/V in roundstart_merits)
		var/datum/merit/T = V
		qdel(T)

/mob/living/proc/transfer_merit_datums(mob/living/to_mob)
	for(var/V in roundstart_merits)
		var/datum/merit/T = V
		T.transfer_mob(to_mob)
