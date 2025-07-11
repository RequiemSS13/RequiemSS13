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
	var/list/memory_data = parent_component.get_memory_data(src, TRUE)
	var/mob/living/living_owner = owner
	living_owner.refresh_character_connections()

	var/datum/browser/popup = new(owner, "memories_window", null, 500, 500)
	popup.set_content(memory_data.Join("<br>"))
	popup.open()

/datum/action/memory_button/Topic(href, href_list)
	if(href_list["delete_connection"])
		
		var/mob/living/living_owner = owner
		if(!living_owner)
			return

		if(!SScharacter_connection.retire_connection(living_owner, living_owner.ckey, living_owner.true_real_name, text2num(href_list["delete_connection"])))
			return
		Trigger()