/*

	This component makes a human look like another mob, and overrides their examine text to match.
	
*/
/datum/component/disguise
	var/mob/living/disguise_mob
	var/list/simplemob_cache
	
	var/disguise_title_cache

	var/disguise_outfit_cache

	var/disguise_health_cache
	
	var/disguise_drunkenness_cache

	var/disguise_scar_cache

	var/is_face_visible_cache = FALSE

	var/original_name

	var/source_power

/datum/component/disguise/Initialize(mob/living/disguise_mob, datum/source_power)
	if(!disguise_mob || !istype(parent, /mob/living/carbon/human))
		return COMPONENT_INCOMPATIBLE
	src.disguise_mob = disguise_mob
	src.source_power = source_power
	var/mob/living/carbon/human/parent_human = parent

	RegisterSignal(parent, COMSIG_HUMAN_EXAMINE_OVERRIDE, PROC_REF(disguise_override))
	RegisterSignal(source_power, COMSIG_POWER_DEACTIVATE, PROC_REF(remove_disguise))

	original_name = parent_human.real_name
	parent_human.real_name = disguise_mob.real_name
	

	var/image/obfuscate_overlay = image(disguise_mob, loc=parent_human, layer = ABOVE_MOB_LAYER)
	obfuscate_overlay.setDir(null)
	obfuscate_overlay.override = TRUE
	parent_human.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/everyone, "obfuscate", obfuscate_overlay)
	parent_human.update_body()
	
	handle_examine_cache(disguise_mob)
	


/datum/component/disguise/proc/remove_disguise()
	SIGNAL_HANDLER
	Destroy()

/datum/component/disguise/Destroy()
	if(!parent)
		return

	UnregisterSignal(parent, COMSIG_HUMAN_EXAMINE_OVERRIDE)
	UnregisterSignal(source_power, COMSIG_POWER_DEACTIVATE)
	var/mob/living/carbon/human/parent_human = parent
	if(parent_human.alternate_appearances)
		parent_human.remove_alt_appearance("obfuscate")
	parent_human.real_name = original_name
	parent_human.update_body()
	. = ..()

/datum/component/disguise/proc/handle_examine_cache()
	if(!ishuman(disguise_mob))
		simplemob_cache = disguise_mob.examine(parent)
		return
	
	var/mob/living/carbon/human/disguise_human = disguise_mob
	disguise_title_cache = disguise_human.examine_title(parent)
	disguise_outfit_cache = disguise_human.examine_outfit(parent)
	disguise_health_cache = disguise_human.examine_health(parent)
	disguise_drunkenness_cache = disguise_human.examine_drunkenness(parent)
	disguise_scar_cache = disguise_human.examine_scars(parent)
	is_face_visible_cache = disguise_human.is_face_visible()


/datum/component/disguise/proc/disguise_override(datum/source, mob/user, list/return_list)
	SIGNAL_HANDLER

	
	if(!ishuman(disguise_mob))
		return_list.Add(simplemob_cache)
		return COMPONENT_EXAMINE_CHANGE_RESPONSE
	
	return_list.Add("<span class='info'>*---------*")
	var/mob/living/carbon/human/human_parent = parent	
	var/mob/living/carbon/human/disguise = disguise_mob


	//false identity's title, when it was taken
	var/examine_result = disguise_title_cache
	examine_result ? return_list.Add(examine_result) : null

	//the disguise's Beast
	examine_result = disguise.examine_beast(user)
	examine_result ? return_list.Add(examine_result) : null


	//The disguise target's fame
	examine_result = disguise.examine_reputation(user)
	examine_result ? return_list.Add(examine_result) : null

	//outfit from the false identity, when it was taken
	examine_result = disguise_outfit_cache
	examine_result ? return_list.Add(examine_result) : null

	//Statuses of the real person
	examine_result = human_parent.examine_status(user, disguise.gender)
	examine_result ? return_list.Add(examine_result) : null

	//Death status of real person
	examine_result = human_parent.examine_death(user, disguise.gender)
	examine_result ? return_list.Add(examine_result) : null

	//health of the false identity, when it was taken
	examine_result = disguise_health_cache
	examine_result ? return_list.Add(examine_result) : null

	//bleeding status of the real person
	examine_result = human_parent.examine_health_no_disguise(user, disguise.gender)
	examine_result ? return_list.Add(examine_result) : null

	if(!(human_parent.stat == DEAD || (HAS_TRAIT(human_parent, TRAIT_FAKEDEATH))))
		//drunkness of false identity, when it was taken
		examine_result = disguise_drunkenness_cache
		examine_result ? return_list.Add(examine_result) : null

		//mood of the real person
		examine_result = human_parent.examine_mood(user, disguise.gender)
		examine_result ? return_list.Add(examine_result) : null

	//scars of the false identity, when it was taken
	examine_result = disguise_scar_cache
	examine_result ? return_list.Add(examine_result) : null

	//flavortext window handling
	examine_result = flavortext_window_disguise(user, disguise, examine_result)
	examine_result ? return_list.Add(examine_result) : null
	
	examine_result = human_parent.examine_hud_info(user)
	examine_result ? return_list.Add(examine_result) : null

	return_list.Add("*---------*</span>")
	return COMPONENT_EXAMINE_CHANGE_RESPONSE


/datum/component/disguise/proc/flavortext_window_disguise(mob/user, mob/living/carbon/human/disguise_mob, list/return_list)
	var/mob/living/carbon/human/human_parent = parent

	if (is_face_visible_cache)
		return span_notice("[copytext_char(disguise_mob.flavor_text, 1, 110)]... <a href='byond://?src=[REF(human_parent)];view_flavortext_fake=[REF(disguise_mob)]'>\[Look closer?\]</a>")
	else
		return span_notice("<a href='byond://?src=[REF(human_parent)];view_flavortext_fake=[REF(disguise_mob)]'>\[Examine closely...\]</a>")
