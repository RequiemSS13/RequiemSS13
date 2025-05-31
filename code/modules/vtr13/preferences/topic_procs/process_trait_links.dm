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
			if(merit_dots + value < 0)
				to_chat(user, "<span class='warning'>You don't have enough leftover dots to remove this merit!</span>")
				return

			if(SSmerits.getMeritCategory(merit_name) == MERIT_BANE)
				var/min_banes = GetRequiredBanes()
				if(min_banes >= GetMeritCount(MERIT_BANE))
					to_chat(user, "<span class='warning'>You must have at least [min_banes] bane[min_banes>1?"s":""]!</span>")
					return
			all_merits -= merit_name

			//depopulate settings for this merit
			var/datum/merit/merit_type = SSmerits.merits[merit_name]
			if(initial(merit_type.custom_setting_types))
				for(var/setting_name in SSmerits.merit_setting_keys[initial(merit_type.name)])
					var/datum/merit_setting/setting = SSmerits.all_merit_settings[setting_name]
					setting.depopulate(src)
			
			//handle cases where removing a quirk resets a whole category
			if(initial(merit_type.categories_reset_on_remove))
				var/list/categories_to_remove = splittext(initial(merit_type.categories_reset_on_remove),",")
				for(var/category_merit_name in all_merits)
					if(!categories_to_remove.Find(MERIT_BANE) || !SSmerits.merits_banes[category_merit_name])
						continue
					if(!categories_to_remove.Find(MERIT_FLAW) || !SSmerits.merits_flaws[category_merit_name])
						continue
					if(!categories_to_remove.Find(MERIT_MERIT) || !SSmerits.merits_merits[category_merit_name])
						continue
					if(!categories_to_remove.Find(MERIT_LANGUAGE) || !SSmerits.merits_languages[category_merit_name])
						continue

					all_merits -= category_merit_name

					//depopulate settings for this merit category
					var/datum/merit/category_merit_type = SSmerits.merits[merit_name]
					if(initial(category_merit_type.custom_setting_types))
						for(var/setting_name in SSmerits.merit_setting_keys[initial(category_merit_type.name)])
							var/datum/merit_setting/setting = SSmerits.all_merit_settings[setting_name]
							setting.depopulate(src)
			
			if(initial(merit_type.recalculate_loadout))
				calculate_loadout_dots()

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
			if(merit_dots - value < 0)
				to_chat(user, "<span class='warning'>You don't have enough dots to add this merit!</span>")
				return
			switch(SSmerits.getMeritCategory(merit_name))
				if(MERIT_MERIT)
					if(GetMeritCount(MERIT_MERIT) >= MAX_MERITS)
						to_chat(user, span_warning("You cannot have more than [MAX_MERITS] Merits!"))
						return
				if(MERIT_FLAW)
					if(GetMeritCount(MERIT_FLAW) >= MAX_FLAWS)
						to_chat(user, span_warning("You cannot have more than [MAX_FLAWS] Flaws!"))
						return
				if(MERIT_BANE)
					if(pref_species.name != "Vampire" )
						to_chat(user, span_warning("Only vampires can have banes!"))
						return
				if(MERIT_LANGUAGE)
					var/max_languages = GetMaxLanguages()
					if(GetMeritCount(MERIT_LANGUAGE) >= max_languages)
						to_chat(user, span_warning("You cannot have more than [max_languages] Languages!"))
						return
			
			var/datum/merit/merit_type = SSmerits.merits[merit_name]

			//handle cases where adding a quirk resets a whole category
			if(initial(merit_type.categories_reset_on_add))
				var/list/categories_to_remove = splittext(initial(merit_type.categories_reset_on_add),",")
				for(var/category_merit_name in all_merits)
					if(!categories_to_remove.Find(MERIT_BANE) || !SSmerits.merits_banes[category_merit_name])
						continue
					if(!categories_to_remove.Find(MERIT_FLAW) || !SSmerits.merits_flaws[category_merit_name])
						continue
					if(!categories_to_remove.Find(MERIT_MERIT) || !SSmerits.merits_merits[category_merit_name])
						continue
					if(!categories_to_remove.Find(MERIT_LANGUAGE) || !SSmerits.merits_languages[category_merit_name])
						continue
					
					all_merits -= category_merit_name

					//depopulate settings for this merit category
					var/datum/merit/category_merit_type = SSmerits.merits[merit_name]
					if(initial(category_merit_type.custom_setting_types))
						for(var/setting_name in SSmerits.merit_setting_keys[initial(category_merit_type.name)])
							var/datum/merit_setting/setting = SSmerits.all_merit_settings[setting_name]
							setting.depopulate(src)

			//handle populating custom settings
			var/list/custom_setting_keys = SSmerits.merit_setting_keys[initial(merit_type.name)]
			if(custom_setting_keys)
				for(var/setting_name in custom_setting_keys)
					var/datum/merit_setting/setting = SSmerits.all_merit_settings[setting_name]
					var/value_set = setting.populate_preset_custom_value(user, src, TRUE)
					if(!value_set && initial(merit_type.custom_setting_required))
						to_chat(user, span_warning("The custom settings for the '[merit_name]' [initial(merit_type.category)] must have a value."))
						return TRUE

			all_merits += merit_name

			if(initial(merit_type.recalculate_loadout))
				calculate_loadout_dots()

		if("reset")
			all_merits = list()
			merit_custom_settings = list()
	return TRUE