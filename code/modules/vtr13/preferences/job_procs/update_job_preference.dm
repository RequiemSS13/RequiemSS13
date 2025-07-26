/datum/preferences/proc/update_job_preference(mob/user, role, desiredLvl)
	if(!SSjob || SSjob.occupations.len <= 0)
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job)
		return

	if (!isnum(desiredLvl))
		to_chat(user, "<span class='danger'>update_job_preference - desired level was not a number. Please notify coders!</span>")
		return

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	if(role == SSjob.overflow_role)
		if(job_preferences[job.title] == JP_LOW)
			jpval = null
		else
			jpval = JP_LOW

	SetJobPreferenceLevel(job, jpval)
	return TRUE
