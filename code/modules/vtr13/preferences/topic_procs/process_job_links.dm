/datum/preferences/proc/process_job_links(mob/user, list/href_list)

	if(href_list["preference"] != "job")
		CRASH("process_job_links called when preferences href not set to job!")

	switch(href_list["task"])
		if("reset")
			ResetJobs()
		if("random")
			switch(joblessrole)
				if(RETURNTOLOBBY)
					if(is_banned_from(user.ckey, SSjob.overflow_role))
						joblessrole = BERANDOMJOB
					else
						joblessrole = BEOVERFLOW
				if(BEOVERFLOW)
					joblessrole = BERANDOMJOB
				if(BERANDOMJOB)
					joblessrole = RETURNTOLOBBY
		if("alt_title")
			var/job_title = href_list["job_title"]
			var/titles_list = list(job_title)
			var/datum/job/J = SSjob.GetJob(job_title)
			for(var/alternative_titles in J.alt_titles)
				titles_list += alternative_titles
			var/chosen_title
			chosen_title = tgui_input_list(user, "Choose your job's title:", "Job Preference", sortList(titles_list))
			if(chosen_title)
				if(chosen_title == job_title)
					if(alt_titles_preferences[job_title])
						alt_titles_preferences.Remove(job_title)
				else
					alt_titles_preferences[job_title] = chosen_title
		if("setJobLevel")
			return update_job_preference(user, href_list["text"], text2num(href_list["level"]))
	return TRUE