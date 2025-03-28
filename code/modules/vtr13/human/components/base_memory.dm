/datum/component/base_memory
	var/mob/living/carbon/owner
	var/list/dat
	var/datum/action/memory_button/memory_button

/datum/component/base_memory/Initialize(mob/living/carbon/owner)
	src.owner = owner
	if(!istype(parent, /datum/mind) || !owner)
		return COMPONENT_INCOMPATIBLE
	memory_button = new(owner, src)
	memory_button.Grant(owner)
	RegisterSignal(parent, COMSIG_MEMORY_DELETE, PROC_REF(remove_memory))
	RegisterSignal(parent, COMSIG_MEMORY_AUSPEX_INVADE, PROC_REF(auspex_invade))

/datum/component/base_memory/CheckDupeComponent()
	return TRUE

/datum/component/base_memory/UnregisterFromParent()

	memory_button.Remove(owner)
	

/datum/component/base_memory/proc/remove_memory()
	SIGNAL_HANDLER
	UnregisterSignal(owner, COMSIG_MEMORY_DELETE)
	Destroy()

/datum/component/base_memory/proc/auspex_invade(datum/source, mob/invader)
	SIGNAL_HANDLER
	if(!invader.mind)
		return
	get_memory_data(FALSE)
	invader << browse(dat.Join("<br>"), "window=vampire;size=500x450;border=1;can_resize=1;can_minimize=0")
	

/datum/component/base_memory/proc/get_memory_data(var/is_own_memories = TRUE)
	dat = list()
	dat += {"
		<style type="text/css">

		body {
			background-color: #090909; color: white;
		}

		</style>
		"}
	dat += "<center><h2>Memories</h2></center>"

	if(!(SEND_SIGNAL(src, COMSIG_MEMORY_NAME_OVERRIDE, owner, is_own_memories) & COMPONENT_MEMORY_OVERRIDE))
		dat += "[icon2html(getFlatIcon(owner, SOUTH), owner)]I am [owner.true_real_name]."
	dat += ""
	dat += "Tonight, I have taken the role of \a [owner.mind.assigned_role]."
	dat += ""
	SEND_SIGNAL(src, COMSIG_MEMORY_SPLAT_TEXT, owner, is_own_memories)
	
	dat += "<b>Physique</b>: [owner.physique] + [owner.additional_physique]"
	dat += "<b>Dexterity</b>: [owner.dexterity] + [owner.additional_dexterity]"
	dat += "<b>Social</b>: [owner.social] + [owner.additional_social]"
	dat += "<b>Mentality</b>: [owner.mentality] + [owner.additional_mentality]"
	dat += "<b>Cruelty</b>: [owner.blood] + [owner.additional_blood]"
	dat += "<b>Lockpicking</b>: [owner.lockpicking] + [owner.additional_lockpicking]"
	dat += "<b>Athletics</b>: [owner.athletics] + [owner.additional_athletics]"
	dat += ""
	SEND_SIGNAL(src, COMSIG_MEMORY_DISCIPLINE_TEXT, owner, is_own_memories)

	if(owner.Myself)
		if(owner.Myself.Friend)
			if(owner.Myself.Friend.owner)
				dat += "<b>My friend's name is [owner.Myself.Friend.owner.true_real_name].</b>"
				if(owner.Myself.Friend.phone_number)
					dat += "Their number is [owner.Myself.Friend.phone_number]."
				if(owner.Myself.Friend.friend_text)
					dat += "[owner.Myself.Friend.friend_text]"
		if(owner.Myself.Enemy)
			if(owner.Myself.Enemy.owner)
				dat += "<b>My nemesis is [owner.Myself.Enemy.owner.true_real_name]!</b>"
				if(owner.Myself.Enemy.enemy_text)
					dat += "[owner.Myself.Enemy.enemy_text]"
		if(owner.Myself.Lover)
			if(owner.Myself.Lover.owner)
				dat += "<b>I'm in love with [owner.Myself.Lover.owner.true_real_name].</b>"
				if(owner.Myself.Lover.phone_number)
					dat += "Their number is [owner.Myself.Lover.phone_number]."
				if(owner.Myself.Lover.lover_text)
					dat += "[owner.Myself.Lover.lover_text]"

	var/obj/keypad/armory/armory = find_keypad(/obj/keypad/armory)
	if(armory && (owner.mind.assigned_role == "Sheriff" || owner.mind.assigned_role == "Seneschal"))
		dat += "The pincode for the armory keypad is<b>: [armory.pincode]</b>"
	
	var/obj/keypad/panic_room/panic = find_keypad(/obj/keypad/panic_room)
	if(panic && (owner.mind.assigned_role == "Page" || owner.mind.assigned_role == "Seneschal"))
		dat += "The pincode for the panic room keypad is<b>: [panic.pincode]</b>"

	if(length(owner.knowscontacts) > 0)
		dat += "<b>I have the contact info of some others in this city:</b>"
		for(var/i in owner.knowscontacts)
			dat += "-[i] contact"
	
	if(is_own_memories && istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/owner_human = owner
		for(var/datum/vtm_bank_account/account in GLOB.bank_account_list)
			if(owner_human.bank_id == account.bank_id)
				dat += "<b>My bank account code is: [account.code]</b>"
				break
	if(is_own_memories && owner.mind.character_connections)
		dat += " "
		dat += "<b>I've made some connections in the city:</b>"
		for(var/datum/character_connection/connection in owner.mind.character_connections)
			dat += ("<b>[connection.connection_desc]</b>" + is_own_memories?"":"<a style='white-space:nowrap;' href='?src=[REF(src)];delete_connection=[connection.group_id]'>Delete</a>")
		dat += " "
	
	return dat



/datum/action/memory_button
	name = "About Me"
	desc = "Check things that you know about yourself."
	button_icon_state = "masquerade"
	check_flags = NONE
	var/datum/component/base_memory/parent_component

/datum/action/memory_button/New(Target, datum/component/base_memory/parent_component)
	..(Target)
	src.parent_component = parent_component

/datum/action/memory_button/Trigger()
	var/list/memory_data = parent_component.get_memory_data(TRUE)
	owner << browse(memory_data.Join("<br>"), "window=vampire;size=500x450;border=1;can_resize=1;can_minimize=0")

/datum/action/memory_button/Topic(href, href_list)
	if(href_list["delete_connection"])
		var/mob/living/owner_human
		owner_human.retire_connection(text2num(href_list["delete_connection"]))
		Trigger()