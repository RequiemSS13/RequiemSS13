/datum/preferences/proc/process_input_task_links(mob/user, list/href_list)

	if(href_list["task"] != "input")
		CRASH("process_tasks_input called on topic that was not an input task!")

	switch(href_list["preference"])
		if("ghostform")
//=======PREFERENCES_PAGE=======
			var/new_form = tgui_input_list(user, "Thanks for supporting BYOND - Choose your ghostly form:","Thanks for supporting BYOND",GLOB.ghost_forms)
			if(new_form)
				ghost_form = new_form
		if("ghostorbit")
			var/new_orbit = tgui_input_list(user, "Thanks for supporting BYOND - Choose your ghostly orbit:","Thanks for supporting BYOND",GLOB.ghost_orbits)
			if(new_orbit)
				ghost_orbit = new_orbit

		if("ghostaccs")
			var/new_ghost_accs = alert("Do you want your ghost to show full accessories where possible, hide accessories but still use the directional sprites where possible, or also ignore the directions and stick to the default sprites?",,GHOST_ACCS_FULL_NAME, GHOST_ACCS_DIR_NAME, GHOST_ACCS_NONE_NAME)
			switch(new_ghost_accs)
				if(GHOST_ACCS_FULL_NAME)
					ghost_accs = GHOST_ACCS_FULL
				if(GHOST_ACCS_DIR_NAME)
					ghost_accs = GHOST_ACCS_DIR
				if(GHOST_ACCS_NONE_NAME)
					ghost_accs = GHOST_ACCS_NONE

		if("ghostothers")
			var/new_ghost_others = alert("Do you want the ghosts of others to show up as their own setting, as their default sprites or always as the default white ghost?",,GHOST_OTHERS_THEIR_SETTING_NAME, GHOST_OTHERS_DEFAULT_SPRITE_NAME, GHOST_OTHERS_SIMPLE_NAME)
			switch(new_ghost_others)
				if(GHOST_OTHERS_THEIR_SETTING_NAME)
					ghost_others = GHOST_OTHERS_THEIR_SETTING
				if(GHOST_OTHERS_DEFAULT_SPRITE_NAME)
					ghost_others = GHOST_OTHERS_DEFAULT_SPRITE
				if(GHOST_OTHERS_SIMPLE_NAME)
					ghost_others = GHOST_OTHERS_SIMPLE

//=======CHARACTER_PAGE=======
		if("name")
			if(real_name && alert(user, "WARNING: Changing your name will dissociate any existing character connections from this slot!", "WARNING", "Okay", "Cancel") == "Cancel")
				return

			var/new_name = tgui_input_text(user, "Choose your character's name:", "Character Preference", max_length = MAX_NAME_LEN)

			if(!new_name)
				return

			new_name = reject_bad_name(new_name)

			if(!new_name)
				to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and . It must not contain any words restricted by IC chat and name filters.</font>")
				return

			if(new_name != real_name)
				SScharacter_connection.retire_all_endorsements(user.ckey, real_name)
				real_name = new_name

		if("age")
			var/new_age = tgui_input_number(user, "Choose your character's biological age:\n([AGE_MIN]-[AGE_MAX])", "Character Preference", age, AGE_MAX, AGE_MIN, round_value = TRUE)
			if(new_age)
				if(pref_species.name == "Vampire" || pref_species.name == "Ghoul")
					age = clamp(round(new_age), min(AGE_MAX, actual_age) , AGE_MIN)
				else
					age = clamp(round(new_age), AGE_MAX, AGE_MIN)

				update_preview_icon()

		if("actual_age")
			var/new_age = tgui_input_number(user, "Choose your character's actual age:\n([age]-[6000])", "Character Preference", actual_age, 6000, age, round_value = TRUE)
			if(new_age)
				actual_age = clamp(new_age, age, age+1000)
				update_preview_icon()

		if("info_choose")
			var/new_info_known = tgui_input_list(user, "Choose who knows your character:", "Fame", list(INFO_KNOWN_UNKNOWN, INFO_KNOWN_FACTION, INFO_KNOWN_PUBLIC))
			if(new_info_known)
				info_known = new_info_known

		if("hair")
			var/new_hair = input(user, "Choose your character's hair colour:", "Character Preference","#"+hair_color) as color|null
			if(new_hair)
				hair_color = sanitize_hexcolor(new_hair)

		if("hairstyle")
			var/new_hairstyle
			new_hairstyle = tgui_input_list(user, "Choose your character's hairstyle:", "Character Preference", GLOB.hairstyles_list)
			if(new_hairstyle)
				hairstyle = new_hairstyle

		if("next_hairstyle")
			hairstyle = next_list_item(hairstyle, GLOB.hairstyles_list)

		if("previous_hairstyle")
			hairstyle = previous_list_item(hairstyle, GLOB.hairstyles_list)

		if("facial")
			var/new_facial = input(user, "Choose your character's facial-hair colour:", "Character Preference","#"+facial_hair_color) as color|null
			if(new_facial)
				facial_hair_color = sanitize_hexcolor(new_facial)

		if("facial_hairstyle")
			var/new_facial_hairstyle
			new_facial_hairstyle = tgui_input_list(user, "Choose your character's facial-hairstyle:", "Character Preference", GLOB.facial_hairstyles_list)
			if(new_facial_hairstyle)
				facial_hairstyle = new_facial_hairstyle

		if("next_facehairstyle")
			facial_hairstyle = next_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

		if("previous_facehairstyle")
			facial_hairstyle = previous_list_item(facial_hairstyle, GLOB.facial_hairstyles_list)

		if("underwear")
			var/new_underwear
			new_underwear = tgui_input_list(user, "Choose your character's underwear:", "Character Preference", GLOB.underwear_list)
			if(new_underwear)
				underwear = new_underwear

		if("underwear_color")
			var/new_underwear_color = input(user, "Choose your character's underwear color:", "Character Preference","#"+underwear_color) as color|null
			if(new_underwear_color)
				underwear_color = sanitize_hexcolor(new_underwear_color)

		if("undershirt")
			var/new_undershirt
			new_undershirt = tgui_input_list(user, "Choose your character's undershirt:", "Character Preference", GLOB.undershirt_list)
			if(new_undershirt)
				undershirt = new_undershirt

		if("socks")
			var/new_socks
			new_socks = tgui_input_list(user, "Choose your character's socks:", "Character Preference", GLOB.socks_list)
			if(new_socks)
				socks = new_socks

		if("eyes")
			var/new_eyes = input(user, "Choose your character's eye colour:", "Character Preference","#"+eye_color) as color|null
			if(new_eyes)
				eye_color = sanitize_hexcolor(new_eyes)

		if("werewolf_name")
			if(!pref_species.id != "garou")
				return

			var/new_name = tgui_input_text(user, "Choose your character's werewolf name:", "Character Preference", max_length = MAX_NAME_LEN)
			if(new_name)
				new_name = reject_bad_name(new_name)
				if(new_name)
					werewolf_name = new_name
				else
					to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and . It must not contain any words restricted by IC chat and name filters.</font>")

		if("werewolf_color")
			if(pref_species.id != "garou")
				return

			var/list/colors = list("black", "gray", "red", "white", "ginger", "brown")
			var/result = tgui_input_list(user, "Select fur color:", "Appearance Selection", sortList(colors))
			if(result)
				werewolf_color = result

		if("werewolf_scar")
			if(pref_species.id != "garou")
				return

			if(tribe == "Glasswalkers")
				if(werewolf_scar == 9)
					werewolf_scar = 0
				else
					werewolf_scar = min(9, werewolf_scar+1)
			else
				if(werewolf_scar == 7)
					werewolf_scar = 0
				else
					werewolf_scar = min(7, werewolf_scar+1)

		if("werewolf_hair")
			if(pref_species.id != "garou")
				return

			if(werewolf_hair == 4)
				werewolf_hair = 0
			else
				werewolf_hair = min(4, werewolf_hair+1)

		if("werewolf_hair_color")
			if(pref_species.id != "garou")
				return

			var/new_hair = input(user, "Select hair color:", "Appearance Selection",werewolf_hair_color) as color|null
			if(new_hair)
				werewolf_hair_color = sanitize_ooccolor(new_hair)

		if("werewolf_eye_color")
			if(pref_species.id != "garou")
				return

			var/new_eye = input(user, "Select eye color:", "Appearance Selection",werewolf_eye_color) as color|null
			if(new_eye)
				werewolf_eye_color = sanitize_ooccolor(new_eye)

		if("auspice")
			if(pref_species.id != "garou")
				return

			var/list/auspice_choices = list()
			for(var/i in GLOB.auspices_list)
				var/a = GLOB.auspices_list[i]
				var/datum/auspice/V = new a
				auspice_choices[V.name] += GLOB.auspices_list[i]
				qdel(V)
			var/result = tgui_input_list(user, "Select an Auspice", "Auspice Selection", auspice_choices)
			if(result)
				var/newtype = GLOB.auspices_list[result]
				var/datum/auspice/new_auspice = new newtype()
				auspice = new_auspice

		if("auspice_level")
			if (auspice_level >= 3)
				return
			auspice_level = max(1, auspice_level + 1)

		if("auspice_level_decrease")
			if (auspice_level <= 1)
				return
			auspice_level = min(1, auspice_level + 1)

		if("tribe")
			if(pref_species.id != "garou")
				return

			var/new_tribe = tgui_input_list(user, "Choose your Tribe:", "Tribe", sortList(list("Wendigo", "Glasswalkers", "Black Spiral Dancers")))
			if (new_tribe)
				tribe = new_tribe

		if("breed")
			if(pref_species.id != "garou")
				return

			var/new_breed = tgui_input_list(user, "Choose your Breed:", "Breed", sortList(list("Homid", "Metis", "Lupus")))
			if (new_breed)
				breed = new_breed

		if("increase_stat")
			var/datum/attribute/A = locate(href_list["attribute"])
			if(handle_upgrade(A.score))
				A.score++

		if("decrease_stat")
			var/datum/attribute/A = locate(href_list["attribute"])
			A.score--
		
		if("increase_potency")
			set_potency(get_potency() + 1)
			adjust_blood_potency()

		if("decrease_potency")
			set_potency(get_potency() - 1)
			adjust_blood_potency()

		if("clane")
			if(!(pref_species.id == "kindred"))
				return

			if (tgui_alert(user, "Are you sure you want to change your Clan? This will reset your merits, flaws, banes and rank.", "Confirmation", list("Yes", "No")) != "Yes")
				return

			var/list/available_clans = list()
			for(var/i in GLOB.clanes_list)
				var/a = GLOB.clanes_list[i]
				var/datum/vampireclane/V = new a
				if (V.whitelisted)
					if (SSwhitelists.is_whitelisted(user.ckey, V.name))
						available_clans[V.name] += GLOB.clanes_list
				else
					available_clans[V.name] += GLOB.clanes_list[i]
				qdel(V)

			var/result = tgui_input_list(user, "Select a clane", "Clane Selection", sortList(available_clans))
			if(result)
				var/newtype = GLOB.clanes_list[result]
				clane = new newtype()
				vamp_rank = VAMP_RANK_NEONATE
				adjust_blood_potency()
				all_merits.Cut()
				discipline_types = list()
				discipline_levels = list()
				for (var/disc_type in clane.clane_disciplines)
					discipline_types.Add(disc_type)
					discipline_levels.Add(0)

				if(length(clane.accessories))
					if("none" in clane.accessories)
						clane_accessory = "none"
					else
						clane_accessory = pick(clane.accessories)
				if(clane.name == "Revenant")
					qdel(vamp_faction)
					vamp_faction = new /datum/vtr_faction/vamp_faction/unaligned()
					vamp_rank = VAMP_RANK_HALF_DAMNED
					adjust_blood_potency()
				
				if(clane.name == "Mekhet")
					AddBanesUntilItIsDone()

		if("regent_clan")
			if(pref_species.id != "ghoul")
				return

			var/list/available_clans = list()
			for(var/i in GLOB.clanes_list)
				var/clane_type = GLOB.clanes_list[i]
				var/datum/vampireclane/new_clan = new clane_type
				if(new_clan.name == "Revenant") //Revenants cannot make ghouls
					continue
				if (new_clan.whitelisted)
					if (SSwhitelists.is_whitelisted(user.ckey, new_clan.name))
						available_clans[new_clan.name] += GLOB.clanes_list
				else
					available_clans[new_clan.name] += GLOB.clanes_list[i]
				qdel(new_clan)
			var/result = tgui_input_list(user, "Select your regent's clane", "Clane Selection", sortList(available_clans))
			if(result)
				var/newtype = GLOB.clanes_list[result]
				regent_clan = new newtype()
				for (var/disc_type in regent_clan.clane_disciplines)
					discipline_types.Add(disc_type)
					discipline_levels.Add(0)


		if("clane_acc")
			if(pref_species.id != "kindred")	//Due to a lot of people being locked to furries
				return

			if(!length(clane.accessories))
				clane_accessory = null
				return
			var/result = tgui_input_list(user, "Select a mark", "Marks", clane.accessories)
			if(result)
				clane_accessory = result

		if("newdiscipline")
			var/list/possible_new_disciplines = subtypesof(/datum/discipline/vtr) - discipline_types
			var/list/discipline_input_list = list()
			for (var/discipline_type in possible_new_disciplines)
				var/datum/discipline/discipline = new discipline_type
				if(!discipline.clan_restricted)
					discipline_input_list[discipline.name] = discipline.type
				qdel(discipline)

			var/new_discipline = tgui_input_list(user, "Select your new Discipline", "Discipline Selection", sortList(discipline_input_list))
			if(new_discipline)
				discipline_types += discipline_input_list[new_discipline]
				discipline_levels.Add(0)

		if("discipline")
			if(pref_species.id != "kindred" && pref_species.id != "ghoul")
				return

			var/i = text2num(href_list["upgradediscipline"])
			var/discipline_level = discipline_levels[i]

			if (!discipline_dots || (discipline_level >= 5))
				return
			discipline_levels[i] = clamp(discipline_level + 1, 1, 5)

		if("discipline_decrease")
			if(pref_species.id != "kindred" && pref_species.id != "ghoul")
				return

			var/i = text2num(href_list["upgradediscipline"])
			var/discipline_level = discipline_levels[i]

			if (!discipline_level)
				return
			discipline_levels[i] = clamp(discipline_level - 1, 0, 4)

		if("discipline_unlearn")
			if(pref_species.id != "kindred" && pref_species.id != "ghoul")
				return

			var/i = text2num(href_list["upgradediscipline"])
			var/discipline_type = discipline_types[i]
			if(!discipline_type)
				return
			discipline_levels.Cut(i, i+1)
			discipline_types.Cut(i, i+1)

		if("vamp_rank")
			if((clane?.name == "Revenant"))
				return

			var/list/age_selection = GLOB.vampire_rank_list
			if(!SSwhitelists.is_whitelisted(parent.ckey, "Elder"))
				age_selection = GLOB.vampire_rank_list_unwhitelisted
				if(vamp_rank == VAMP_RANK_ELDER)
					vamp_rank = VAMP_RANK_ANCILLAE

			var/new_vamp_rank = tgui_input_list(user, "Choose a vampire rank:", "Character Preference", age_selection, age_selection[vamp_rank])

			if(new_vamp_rank && check_vamp_rank_allowed(GLOB.vampire_rank_list[new_vamp_rank]))
				vamp_rank = GLOB.vampire_rank_list[new_vamp_rank]
			AddBanesUntilItIsDone()
			adjust_blood_potency()
		
		if("vamp_faction")
			if((clane?.name == "Revenant"))
				return

			if(tgui_alert(user, "WARNING: Changing faction will invalidate any endorsement you have recieved or given!", "WARNING", list("Okay", "Cancel")) == "Cancel")
				return

			var/new_faction_name = tgui_input_list(user, "Choose a Covenant:", "Character Preference", GLOB.vampire_faction_list, vamp_faction.name)

			if(new_faction_name != vamp_faction.name)
				qdel(vamp_faction)
				var/new_faction_type = GLOB.factions_list[new_faction_name]
				vamp_faction = new new_faction_type()

		if("ooc_notes")
			var/new_ooc_notes = tgui_input_text(user, "Choose your character's OOC notes:", "Character Preference", ooc_notes, MAX_MESSAGE_LEN, multiline = TRUE)
			if(!length(new_ooc_notes))
				return
			ooc_notes = new_ooc_notes

		if("flavor_text")
			var/new_flavor = tgui_input_text(user, "Choose your character's flavor text:", "Character Preference", flavor_text, MAX_FLAVOR_LEN, multiline = TRUE)
			if(new_flavor)
				flavor_text = new_flavor

		if("view_flavortext")
			var/datum/browser/popup = new(user, "[real_name]_flavortext", real_name, 500, 200)
			popup.set_content(replacetext(flavor_text, "\n", "<BR>"))
			popup.open(FALSE)
			return

		if("view_headshot")
			var/list/dat = list("<table width='100%' height='100%'><td align='center' valign='middle'><img src='[headshot_link]' width='250px' height='250px'></td></table>")
			var/datum/browser/popup = new(user, "[real_name]_headshot", "<div align='center'>Headshot</div>", 310, 330)
			popup.set_content(dat.Join())
			popup.open(FALSE)
			return

		if("headshot")
			to_chat(user, span_notice("Please use a relatively SFW image of the head and shoulder area to maintain immersion level. Lastly, ["<b>do not use a real life photo or use any image that is less than serious.</b>"]"))
			to_chat(user, span_notice("If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser."))
			to_chat(user, span_notice("Resolution: 250x250 pixels."))
			var/new_headshot_link = tgui_input_text(user, "Input the headshot link (https, hosts: gyazo, lensdump, imgbox, catbox, imgur):", "Headshot", headshot_link, encode = FALSE)
			if(isnull(new_headshot_link))
				return
			if(!length(new_headshot_link))
				headshot_link = null
				ShowChoices(user)
				return
			if(!valid_headshot_link(user, new_headshot_link))
				headshot_link = null
				ShowChoices(user)
				return
			headshot_link = new_headshot_link
			to_chat(user, span_notice("Successfully updated headshot picture!"))
			log_game("[key_name(user)] has set their Headshot image to '[headshot_link]'.")

		if("species")
			if (tgui_alert(user, "Are you sure you want to change species? This will reset your merits, flaws and banes.", "Confirmation", list("Yes", "No")) != "Yes")
				return

			var/list/choose_species = list()
			for (var/key in get_selectable_species())
				var/newtype = GLOB.species_list[key]
				var/datum/species/selecting_species = new newtype
				if (!selecting_species.selectable)
					qdel(selecting_species)
					continue
				if (selecting_species.whitelisted)
					if (parent && !SSwhitelists.is_whitelisted(parent.ckey, key))
						qdel(selecting_species)
						continue
				choose_species += key
				qdel(selecting_species)

			var/result = tgui_input_list(user, "Select a species", "Species Selection", sortList(choose_species))
			qdel(choose_species)

			if(result && result != pref_species.id)
				all_merits.Cut()
				auspice_level = 0
				qdel(clane)
				clane = null
				qdel(regent_clan)
				regent_clan = null
				var/newtype = GLOB.species_list[result]
				pref_species = new newtype()
				switch(pref_species.id)
					if("human","garou")
						vamp_rank = 0
						discipline_types.Cut()
						discipline_levels.Cut()
					if("ghoul")
						regent_clan = new /datum/vampireclane/vtr/daeva()
						vamp_faction = new /datum/vtr_faction/vamp_faction/unaligned()
						vamp_rank = VAMP_RANK_GHOUL
						discipline_types.Cut()
						discipline_levels.Cut()
						for (var/disc_type in regent_clan.clane_disciplines)
							discipline_types.Add(disc_type)
							discipline_levels.Add(0)
					if("kindred")
						clane = new /datum/vampireclane/vtr/daeva()
						vamp_faction = new /datum/vtr_faction/vamp_faction/unaligned()
						vamp_rank = VAMP_RANK_NEONATE
						discipline_types.Cut()
						discipline_levels.Cut()
						for (var/disc_type in clane.clane_disciplines)
							discipline_types.Add(disc_type)
							discipline_levels.Add(0)
				adjust_blood_potency()

		if("s_tone")
			var/new_s_tone = input(user, "Choose your character's skin-tone:", "Character Preference","#"+skin_tone) as color|null
			if(new_s_tone)
				skin_tone = sanitize_hexcolor(new_s_tone)

		if("s_tone_preset")
			var/s_tone_choice = tgui_input_list(user, "Choose your character's skin-tone:", "Character Preference", skin_tone_presets)
			var/new_s_tone_preset = skin_tone_presets[s_tone_choice]
			if(s_tone_choice)
				skin_tone = sanitize_hexcolor(new_s_tone_preset)

		if("ooccolor")
			var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference",ooccolor) as color|null
			if(new_ooccolor)
				ooccolor = sanitize_ooccolor(new_ooccolor)

		if("asaycolor")
			var/new_asaycolor = input(user, "Choose your ASAY color:", "Game Preference",asaycolor) as color|null
			if(new_asaycolor)
				asaycolor = sanitize_ooccolor(new_asaycolor)

		if("bag")
			var/new_backpack = tgui_input_list(user, "Choose your character's style of bag:", "Character Preference", GLOB.backpacklist)
			if(new_backpack)
				backpack = new_backpack
		if ("preferred_map")
			var/maplist = list()
			var/default = "Default"
			if (config.defaultmap)
				default += " ([config.defaultmap.map_name])"
			for (var/M in config.maplist)
				var/datum/map_config/VM = config.maplist[M]
				if(!VM.votable)
					continue
				var/friendlyname = "[VM.map_name] "
				if (VM.voteweight <= 0)
					friendlyname += " (disabled)"
				maplist[friendlyname] = VM.map_name
			maplist[default] = null
			var/pickedmap = input(user, "Choose your preferred map. This will be used to help weight random map selection.", "Character Preference")  as null|anything in sortList(maplist)
			if (pickedmap)
				preferred_map = maplist[pickedmap]

		if ("clientfps")
			var/desiredfps = input(user, "Choose your desired fps.\n-1 means recommended value (currently:[RECOMMENDED_FPS])\n0 means world fps (currently:[world.fps])", "Character Preference", clientfps)  as null|num
			if (!isnull(desiredfps))
				clientfps = sanitize_integer(desiredfps, -1, 1000, clientfps)
				if(parent)
					parent.fps = (clientfps < 0) ? RECOMMENDED_FPS : clientfps
		if("ui")
			var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
			if(pickedui)
				UI_style = pickedui
				if (parent?.mob.hud_used)
					parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
		if("pda_style")
			var/pickedPDAStyle = input(user, "Choose your PDA style.", "Character Preference", pda_style)  as null|anything in GLOB.pda_styles
			if(pickedPDAStyle)
				pda_style = pickedPDAStyle
		if("pda_color")
			var/pickedPDAColor = input(user, "Choose your PDA Interface color.", "Character Preference", pda_color) as color|null
			if(pickedPDAColor)
				pda_color = pickedPDAColor

		if ("max_chat_length")
			var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
			if (!isnull(desiredlength))
				max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)
		if ("ooc_bond_pref")
			var/new_ooc_pref = tgui_alert(user, "Select an OOC Preference for being Blood Bonded:", "Consent Preferences", list("Yes", "Ask", "No"))
			if(new_ooc_pref != ooc_bond_pref)
				ooc_bond_pref = new_ooc_pref
		if ("ooc_ghoul_pref")
			var/new_ooc_pref = tgui_alert(user, "Select an OOC Preference for being Ghouled:", "Consent Preferences", list("Yes", "Ask", "No"))
			if(new_ooc_pref != ooc_ghoul_pref)
				ooc_ghoul_pref = new_ooc_pref
		if ("ooc_embrace_pref")
			var/new_ooc_pref = tgui_alert(user, "Select an OOC Preference for being Embraced:", "Consent Preferences", list("Yes", "Ask", "No"))
			if(new_ooc_pref != ooc_embrace_pref)
				ooc_embrace_pref = new_ooc_pref
		if ("ooc_escalation_pref")
			var/new_ooc_pref = tgui_alert(user, "Select an OOC Preference for being Unprovoked Violence:", "Consent Preferences", list("Yes", "Ask", "No"))
			if(new_ooc_pref != ooc_escalation_pref)
				ooc_escalation_pref = new_ooc_pref
		if("ooc_link")
			to_chat(user, span_notice("Please use a character page that you have actually made and reflects the character."))
			var/new_ooc_link = tgui_input_text(user, "Input the headshot link (https, hosts: carrd, toyhou.se, refsheet, f-list, google-docs, neocities):", "Character Link", ooc_link, encode = FALSE)
			if(isnull(new_ooc_link))
				ooc_link = ""
				return TRUE
			if(!length(new_ooc_link))
				ooc_link = ""
				return TRUE
			if(!valid_character_link(user, new_ooc_link))
				ooc_link = ""
				return TRUE
			ooc_link = new_ooc_link
			to_chat(user, span_notice("Successfully updated ooc link!"))
			log_game("[key_name(user)] has set their ooc link to '[ooc_link]'.")
	return TRUE
