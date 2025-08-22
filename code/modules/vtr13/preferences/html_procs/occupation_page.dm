/datum/preferences/proc/occupation_page(mob/user, list/dat)
	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.
	character_connections = SScharacter_connection.get_character_connections(parent.ckey, src.real_name)
	var/limit = 9
	var/widthPerColumn = 295
	
	var/width = widthPerColumn

	var/HTML = "<center>"
	if(!SSjob || SSjob.occupations.len <= 0)
		HTML += "The job SSticker is not yet finished creating jobs, please try again later"
	else
		HTML += "<b>Choose occupation chances</b><br>"
		HTML += "<div align='center'>Left-click to raise an occupation preference, right-click to lower it.<br></div>"
		HTML += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		HTML += "<table width='100%' cellpadding='1' cellspacing='0' border='1px solid white' border-collapse='collapse'><tr><td width='20%' valign='top'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr>"
		var/index = -1

		var/bypass = FALSE
		/*
		if (check_rights_for(user.client, R_ADMIN))
			bypass = TRUE
		*/
		for(var/datum/job/vamp/vtr/job in sortList(SSjob.occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))
			index += 1
			if((index >= limit))
				width += widthPerColumn
				HTML += "</table></td><td width='20%' valign='top'><table width='100%' cellpadding='1' cellspacing='0'><tr>"
				index = 0

			HTML += "<tr bgcolor='[job.selection_color]'><td width='25%' align='center'>"
			var/rank = job.title

			var/displayed_rank = rank
			if(length(job.alt_titles) && (rank in alt_titles_preferences))
				displayed_rank = alt_titles_preferences[rank]

			if(is_banned_from(user.ckey, rank))
				HTML += "<font color=red><b>[rank]</b></font></td><td width='75%' align='center'><a href='byond://?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
				continue
			var/required_playtime_remaining = job.required_playtime_remaining(user.client)

			if(required_playtime_remaining && !bypass)
				HTML += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \]</font></b></td></tr>"
				continue
			if(!job.player_old_enough(user.client) && !bypass)
				var/available_in_days = job.available_in_days(user.client)
				HTML += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[IN [(available_in_days)] DAYS\]</font></b></td></tr>"
				continue
			if(!job.allowed_species.Find(pref_species.name) && !bypass)
				HTML += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[pref_species.name] RESTRICTED\]</font></b></td></tr>"
				continue
			if((pref_species.name == "Vampire" || pref_species.name == "Ghoul") && GLOB.vampire_factions_list.Find(job.exp_type_department) && vamp_faction && vamp_faction.name != job.exp_type_department && !bypass)
				HTML += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[vamp_faction?.name] RESTRICTED\]</font></b></td></tr>"
				continue
			if((pref_species.name == "Vampire" || pref_species.name == "Ghoul") && job.minimum_vamp_rank && vamp_rank < job.minimum_vamp_rank && !bypass)
				HTML += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[GLOB.vampire_rank_names[vamp_rank]] RESTRICTED\]</font></b></td></tr>"
				continue
			if(masquerade < job.minimal_masquerade && !bypass)
				HTML += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[job.minimal_masquerade] MASQUERADE REQUIRED\]</font></b></td></tr>"
			if(job.endorsement_required && endorsement_roles_eligable && !endorsement_roles_eligable.Find(job.title) && !bypass)
				var/endorsements_needed_count = FACTION_HEAD_ENDORSEMENT_MIN
				if(job.title == "Seneschal")
					endorsements_needed_count = SENESCHAL_SPECIAL_ENDORSEMENT_MIN + FACTION_HEAD_ENDORSEMENT_MIN
				else if(job.is_deputy)
					endorsements_needed_count = DEPUTY_ENDORSEMENT_MIN
				HTML += "<font color=#290204><b>[rank]</b></font></td><td width='75%' align='center'><b><font color=#290204> \[[endorsements_needed_count] ENDORSEMENT[endorsements_needed_count > 1 ? "S" : ""] NEEDED\]</font></b></td></tr>"
				continue
			if((job_preferences[SSjob.overflow_role] == JP_LOW) && (rank != SSjob.overflow_role) && !is_banned_from(user.ckey, SSjob.overflow_role))
				HTML += "<font color=orange><b>[rank]</b></font></td><td width='75%' align='center'></td></tr>"
				continue
			
			// TFN EDIT START: alt job titles
			var/rank_title_line = "[displayed_rank]"
			if(length(job.alt_titles) && (rank in GLOB.leader_positions))//Bold head jobs
				rank_title_line = "<b><a href='byond://?_src_=prefs;preference=job;task=alt_title;job_title=[job.title]'>[rank_title_line]</a></b>"
			else if(length(job.alt_titles))
				rank_title_line = "<a href='byond://?_src_=prefs;preference=job;task=alt_title;job_title=[job.title]'>[rank_title_line]</a>"
			else
				rank_title_line = "<span class='dark'><b>[rank]</b></span>"
			HTML += rank_title_line
			// TFN EDIT END

			HTML += "</td><td width='75%' align='center'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences[job.title])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			HTML += "<a class='white' href='byond://?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"

			if(rank == SSjob.overflow_role)//Overflow is special
				if(job_preferences[SSjob.overflow_role] == JP_LOW)
					HTML += "<font color=green>Yes</font>"
				else
					HTML += "<font color=red>No</font>"
				HTML += "</a></td></tr>"
				continue

			HTML += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			HTML += "</a></td></tr>"
		HTML += "</td'></tr></table>"
		HTML += "</center></table>"

		var/message = "Be an [SSjob.overflow_role] if preferences unavailable"
		if(joblessrole == BERANDOMJOB)
			message = "Get random job if preferences unavailable"
		else if(joblessrole == RETURNTOLOBBY)
			message = "Return to lobby if preferences unavailable"
		HTML += "<center><br><a href='byond://?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		HTML += "<center><a href='byond://?_src_=prefs;preference=job;task=reset'>Reset Preferences</a></center>"
	dat += HTML