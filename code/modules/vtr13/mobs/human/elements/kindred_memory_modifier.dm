//Alters memory text for Kindred
/datum/element/kindred_memory_modifier
	element_flags = ELEMENT_DETACH

/datum/element/kindred_memory_modifier/Attach(datum/target)
	. = ..()
	if(!istype(target, /datum/component/base_memory))
		return ELEMENT_INCOMPATIBLE
	var/datum/component/base_memory/linked_memory = target
	if(!linked_memory.owner || !iskindred(linked_memory.owner))
		return ELEMENT_INCOMPATIBLE

	RegisterSignal(target, COMSIG_MEMORY_NAME_OVERRIDE, PROC_REF(name_override))
	RegisterSignal(target, COMSIG_MEMORY_SPLAT_TEXT, PROC_REF(splat_text))
	RegisterSignal(target, COMSIG_MEMORY_DISCIPLINE_TEXT, PROC_REF(discipline_text))

/datum/element/kindred_memory_modifier/Detach(datum/source, force)
	. = ..()
	UnregisterSignal(source, COMSIG_MEMORY_NAME_OVERRIDE)
	UnregisterSignal(source, COMSIG_MEMORY_SPLAT_TEXT)
	UnregisterSignal(source, COMSIG_MEMORY_DISCIPLINE_TEXT)
	


/datum/element/kindred_memory_modifier/proc/name_override(datum/source, mob/living/carbon/human/owner, is_own_memories)
	SIGNAL_HANDLER
	var/datum/component/base_memory/base_memory = source
	base_memory.dat += "[icon2html(getFlatIcon(owner), owner)]I am [owner.true_real_name], a Vampire of clan [owner.clane.name]."
	return COMPONENT_MEMORY_OVERRIDE

/datum/element/kindred_memory_modifier/proc/splat_text(datum/source, mob/living/carbon/human/owner, is_own_memories)
	SIGNAL_HANDLER
	var/datum/component/base_memory/base_memory = source

	//TODO HEX: AGE RANK SHIT, FACTION SHIT
	base_memory.dat += "I am a member of the All-Night society."
	base_memory.dat += "I bear the rank of [owner.generation]."
	base_memory.dat += ""
	var/masquerade_level = " followed the Masquerade Tradition perfectly."
	switch(owner.masquerade)
		if(4)
			masquerade_level = " broke the Masquerade once."
		if(3)
			masquerade_level = " made a couple of small Masquerade breaches."
		if(2)
			masquerade_level = " provoked a moderate Masquerade breach."
		if(1)
			masquerade_level = " almost ruined the Masquerade."
		if(0)
			masquerade_level = "'m danger to the Masquerade and my own kind."
	base_memory.dat += "The Invictus think I[masquerade_level]"
	base_memory.dat += ""
	var/humanity = ""
	switch(owner.humanity)
		if(8 to 10)
			humanity = "I'm saintly."
		if(7)
			humanity = "I feel as human as when I lived."
		if(5 to 6)
			humanity = "I'm feeling distant from my humanity."
		if(4)
			humanity = "I don't feel any compassion for the Kine anymore."
		if(2 to 3)
			humanity = "I feel hunger for <b>BLOOD</b>. My humanity is slipping away."
		if(1)
			humanity = "Blood. Feed. Hunger. It gnaws. Must <b>FEED!</b>"
		if(0)
			humanity = "I have become the beast."
	base_memory.dat += humanity
	base_memory.dat += ""

/datum/element/kindred_memory_modifier/proc/discipline_text(datum/source, mob/living/carbon/human/owner, is_own_memories)
	SIGNAL_HANDLER
	var/datum/component/base_memory/base_memory = source
	if(owner.hud_used)
		base_memory.dat += "<b>Known disciplines:</b>"
		for(var/datum/action/discipline/D in owner.actions)
			if(D)
				if(D.discipline)
					base_memory.dat += "[D.discipline.name] [D.discipline.level] - [D.discipline.desc]"
		base_memory.dat += ""