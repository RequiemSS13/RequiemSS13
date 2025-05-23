/datum/preferences/proc/process_random_task_links(mob/user, list/href_list)

	if(href_list["task"] != "random")
		CRASH("process_tasks_random called on topic that was not a random task!")

	switch(href_list["preference"])
		if("name")
			real_name = pref_species.random_name(gender,1)
		if("all")
			random_character(gender)
	return TRUE