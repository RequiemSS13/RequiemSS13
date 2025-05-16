/datum/preferences/proc/process_trait_links(mob/user, list/href_list)
	switch(href_list["task"])
		if("close")
			user << browse(null, "window=mob_occupation")
			ShowChoices(user)

		if("remove")
			var/merit_name = href_list["trait"]

			if(!all_merits.Find(merit_name))
				return

			var/value = SSmerits.merit_points[merit_name]
			if(character_dots + value < 0)
				to_chat(user, "<span class='warning'>You don't have enough dots to remove this merit!</span>")
				return

			if(SSmerits.getMeritCategory(merit_name) == MERIT_BANE)
				var/min_banes = GetRequiredBanes()
				if(min_banes >= GetMeritCount(MERIT_BANE))
					to_chat(user, "<span class='warning'>You must have at least [min_banes] bane[min_banes>1?"s":""]!</span>")
					return

			all_merits -= merit_name

		if("add")
			var/merit_name = href_list["trait"]
			
			if(all_merits.Find(merit_name) || !SSmerits.CanAddMerit(src, SSmerits.merits[merit_name]))
				return

			for(var/list/blacklist_list in SSmerits.merit_blacklist) //V is a list
				if(!(merit_name in blacklist_list))
					continue
				for(var/selected_merit in (all_merits - merit_name))
					if((selected_merit in blacklist_list))
						to_chat(user, "<span class='danger'>[merit_name] is incompatible with [selected_merit].</span>")
						return

			var/value = SSmerits.merit_points[merit_name]
			if(character_dots - value < 0)
				to_chat(user, "<span class='warning'>You don't have enough dots to add this merit!</span>")
				return
			switch(SSmerits.getMeritCategory(merit_name))
				if(MERIT_MERIT)
					if(GetMeritCount(MERIT_MERIT) >= MAX_MERITS)
						to_chat(user, span_warning("You cannot have more than [MAX_MERITS] Merits!"))
						return
				if(MERIT_FLAW)
					if(GetMeritCount(MERIT_FLAW) >= MAX_FLAWS)
						to_chat(user, span_warning("You cannot have more than [MAX_FLAWS] Merits!"))
						return
				if(MERIT_BANE)
					if(pref_species.name != "Vampire" )
						to_chat(user, span_warning("Only vampires can have banes!"))
						return

			all_merits += merit_name

		if("reset")
			all_merits = list()
	return TRUE