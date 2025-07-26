/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(istype(user.client.mob, /mob/dead/observer/avatar))
		to_chat(user, "<span class='notice'>You can't modify preferences while auspex ghosted!</span>")
		return

	if(href_list["bancheck"])
		var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, href_list["bancheck"])
		var/admin = FALSE
		if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
			admin = TRUE
		for(var/i in ban_details)
			if(admin && !text2num(i["applies_to_admins"]))
				continue
			ban_details = i
			break //we only want to get the most recent ban's details
		if(ban_details?.len)
			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, "<span class='danger'>You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [href_list["bancheck"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]</span>")
			return

	var/task_result_save = FALSE
	switch(href_list["preference"])
		if("trait")
			task_result_save = process_trait_links(user, href_list)
		if("job")
			task_result_save = process_job_links(user, href_list)
		if("connection")
			task_result_save = process_connection_links(user, href_list)
		if("loadout")
			task_result_save = process_loadout_links(user, href_list)

	if(!task_result_save)	
		switch(href_list["task"])
			if("random")
				task_result_save = process_random_task_links(user, href_list)
			if("input")
				task_result_save = process_input_task_links(user, href_list)
			else
				task_result_save = process_misc_task_links(user, href_list)

	if(task_result_save)
		save_preferences()
		save_character()
		ShowChoices(user)
		return TRUE
	return
