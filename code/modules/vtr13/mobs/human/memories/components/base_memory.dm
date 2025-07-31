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
	INVOKE_ASYNC(src, PROC_REF(open_invader_window), invader)

/datum/component/base_memory/proc/open_invader_window(mob/invader)
	get_memory_data(src, FALSE)
	var/datum/browser/popup = new(invader, "memories_window_invader", null, 500, 500)
	popup.set_content(dat.Join("<br>"))
	popup.open()


/datum/component/base_memory/proc/get_memory_data(datum/source, var/is_own_memories = TRUE)

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
		dat += "[icon2html(getFlatIcon(owner, SOUTH), owner)]I am [owner.real_name]."
	dat += "Tonight, I have taken the role of \a [owner.mind.assigned_role]."

	if(is_own_memories && istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/owner_human = owner
		for(var/datum/vtr_bank_account/account in GLOB.bank_account_list)
			if(owner_human.bank_id == account.bank_id)
				dat += "<b>My bank account code is: [account.code]</b>"
				break

	var/obj/structure/vaultdoor/basement = find_door_pin(/obj/structure/vaultdoor/pincode/basement)
	if(basement && (owner.mind.assigned_role == "Sheriff" || owner.mind.assigned_role == "Seneschal"))
		dat += "The code for the basement vault is<b>: [basement.pincode]</b>"

	var/obj/structure/vaultdoor/records = find_door_pin(/obj/structure/vaultdoor/pincode/records)
	if(records && (owner.mind.assigned_role == "Page" || owner.mind.assigned_role == "Seneschal" || owner.mind.assigned_role == "Sheriff" || owner.mind.assigned_role == "Hound"))
		dat += "The code for the masquerade records room is<b>: [records.pincode]</b>"

	dat += "<hr>"

	SEND_SIGNAL(src, COMSIG_MEMORY_SPLAT_TEXT, owner, is_own_memories)

	var/datum/mind/brain = parent
	switch(brain.tempted_mod)
		if(1)
			dat += "The Beast is tempting me."
		if(2)
			dat += "The Beast is pushing me to lose myself."
		if(3)
			dat += "The Beast is screaming to be let loose."

	if(HAS_TRAIT(owner, TRAIT_CHARMED))
		for(var/mob/charmer in owner.status_traits[TRAIT_CHARMED])
			dat += "I find myself trusting [charmer]."

	dat += "<b>Physique</b>: [owner.get_physique()]"
	dat += "<b>Stamina</b>: [owner.get_stamina()]"
	dat += "<b>Charisma</b>: [owner.get_charisma()]"
	dat += "<b>Composure</b>: [owner.get_composure()]"
	dat += "<b>Wits</b>: [owner.get_wits()]"
	dat += "<b>Resolve</b>: [owner.get_resolve()]"
	dat += "<hr>"
	SEND_SIGNAL(src, COMSIG_MEMORY_DISCIPLINE_TEXT, owner, is_own_memories)

	if(length(owner.knowscontacts) > 0)
		dat += "<b>I have the contact info of some others in this city:</b>"
		for(var/i in owner.knowscontacts)
			dat += "-[i] contact"

	if(is_own_memories && owner.mind)
		if(length(owner.mind.character_connections) || length(owner.mind.fake_character_connections))
			dat += "<hr>"
			dat += "<b>I've made some connections in the city:</b>"
		if(length(owner.mind.character_connections))
			for(var/datum/character_connection/connection in owner.mind.character_connections)
				if(connection.hidden)
					continue
				dat += "<b>[connection.connection_desc]</b> <a style='white-space:nowrap;' href='byond://?src=[REF(source)];delete_connection=[connection.group_id]'>Delete</a>"
		if(length(owner.mind.fake_character_connections))
			for(var/datum/character_connection/connection in owner.mind.fake_character_connections)
				dat += "<b>[connection.connection_desc]</b> <a style='white-space:nowrap;' href='byond://?src=[REF(source)];delete_connection=[connection.group_id]'>Delete</a>"

	return dat
