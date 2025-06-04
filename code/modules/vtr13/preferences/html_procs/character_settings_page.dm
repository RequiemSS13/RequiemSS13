/datum/preferences/proc/character_settings_page(mob/user, list/dat)
	if(reason_of_death != "None")
		dat += "<center><b>Last death</b>: [reason_of_death]</center>"
	dat += "<table width='100%'><tr><td width='50%' valign='top'>"
	dat += "<h2>[make_font_cool("IDENTITY")]</h2>"

	if(is_banned_from(user.ckey, "Appearance"))
		dat += "<b>You are banned from using custom names and appearances. Why we did this is beyond the reckoning of this writer - I would've just banned you from the server. Anyways, you can continue to adjust your characters, but you will be randomised once you join the game.</b><br>"

	dat += "<a href='byond://?_src_=prefs;preference=name;task=random'>Random Name</A> "
	dat += "<br><b>Name:</b> "
	dat += "<a href='byond://?_src_=prefs;preference=name;task=input'>[real_name]</a><BR>"

	if(!(AGENDER in pref_species.species_traits))
		dat += "<b>Gender:</b> <a href='byond://?_src_=prefs;preference=gender'>[gender == MALE ? "Male" : gender == FEMALE ? "Female" : "Other"]</a>"
	dat += "<BR><b>Body Type:</b> <a href='byond://?_src_=prefs;preference=body_type'>[body_type == MALE ? "Masculine" : body_type == FEMALE ? "Feminine" : "Other"]</a>"
	if(pref_species.name == "Vampire" || pref_species.name == "Ghoul" || pref_species.name == "Werewolf")
		dat += "<br><b>Biological Age:</b> <a href='byond://?_src_=prefs;preference=age;task=input'>[age]</a>"
		dat += "<br><b>Actual Age:</b> <a href='byond://?_src_=prefs;preference=actual_age;task=input'>[max(age, actual_age)]</a>"
	else
		dat += "<br><b>Age:</b> <a href='byond://?_src_=prefs;preference=age;task=input'>[age]</a>"
	dat += "<br>"
	dat += "<a href='byond://?_src_=prefs;preference=all;task=random'>Random Body</a>"
	dat += "</td><td width='50%' valign='top'>"
	dat += "<h2>[make_font_cool("OOC NOTES")]</h2>"
	dat += "<b>OOC Notes:</b> <a href='byond://?_src_=prefs;preference=ooc_notes;task=input'>Change</a><BR>"
	dat += "<i>[ooc_notes]</i><br>"
	dat += "<b>Blood Bonding Preference:</b> <a href='byond://?_src_=prefs;preference=ooc_bond_pref;task=input'>[ooc_bond_pref]</a><BR><BR>"
	dat += "<b>Ghouling Preference:</b> <a href='byond://?_src_=prefs;preference=ooc_ghoul_pref;task=input'>[ooc_ghoul_pref]</a><BR><BR>"
	dat += "<b>Embracing Preference:</b> <a href='byond://?_src_=prefs;preference=ooc_embrace_pref;task=input'>[ooc_embrace_pref]</a><BR><BR>"
	dat += "<b>Unprovoked Violence:</b> <a href='byond://?_src_=prefs;preference=ooc_escalation_pref;task=input'>[ooc_escalation_pref]</a>"
	dat += "</td></tr></table>"
	
	dat += "<h2>[make_font_cool("Splat")]</h2>"

	

	dat += "<b>Splat:</b> <a href='?_src_=prefs;preference=species;task=input'>[pref_species.name]</a><BR>"
	if(pref_species.name == "Vampire")
		dat += "<b>Humanity:</b> [humanity]/10"
		dat += "<br>"
	if(pref_species.name == "Werewolf")
		dat += "<b>Veil:</b> [masquerade]/5<BR>"
	if(pref_species.name == "Vampire" || pref_species.name == "Ghoul")
		dat += "<b>Masquerade:</b> [masquerade]/5<BR>"
	if(pref_species.name == "Vampire")
		dat += "<b>Beast's Temptation:</b> [tempted]/3<br>"

	if(pref_species.name == "Ghoul" || clane?.name == "Revenant")
		dat += "<b>Vampire Rank:</b> [GLOB.vampire_rank_names[vamp_rank]]"
	else if(pref_species.name == "Vampire")
		dat += "<b>Vampire Rank:</b> <a href='?_src_=prefs;preference=vamp_rank;task=input'>[GLOB.vampire_rank_names[vamp_rank]]</a>"
	if(pref_species.name == "Ghoul" || pref_species.name == "Vampire")
		dat += "<br>"
		dat += "<b>Description:</b>[GLOB.vampire_rank_desc_list[vamp_rank]]<BR>"
	if(pref_species.name == "Werewolf")
		dat += "<h2>[make_font_cool("TRIBE")]</h2>"
		dat += "<br><b>Werewolf Name:</b> "
		dat += "<a href='byond://?_src_=prefs;preference=werewolf_name;task=input'>[werewolf_name]</a><BR>"
		dat += "<b>Auspice:</b> <a href='byond://?_src_=prefs;preference=auspice;task=input'>[auspice.name]</a><BR>"
		dat += "Description: [auspice.desc]<BR>"
		dat += "<b>Power:</b> ●[auspice_level > 1 ? "●" : "○"][auspice_level > 2 ? "●" : "○"]([auspice_level])"
		if(character_dots && auspice_level != 3)
			dat += "<a href='byond://?_src_=prefs;preference=auspice_level;task=input'>+</a> <a href='byond://?_src_=prefs;preference=auspice_level_decrease;task=input'>-</a>"
		dat += "<b>Initial Rage:</b> ●[auspice.start_rage > 1 ? "●" : "○"][auspice.start_rage > 2 ? "●" : "○"][auspice.start_rage > 3 ? "●" : "○"][auspice.start_rage > 4 ? "●" : "○"]([auspice.start_rage])<BR>"
		var/gifts_text = ""
		var/num_of_gifts = 0
		for(var/i in 1 to auspice_level)
			var/zalupa
			switch (tribe)
				if ("Glasswalkers")
					zalupa = auspice.glasswalker[i]
				if ("Wendigo")
					zalupa = auspice.wendigo[i]
				if ("Black Spiral Dancers")
					zalupa = auspice.spiral[i]
			var/datum/action/T = new zalupa()
			gifts_text += "[T.name], "
		for(var/i in auspice.gifts)
			var/datum/action/ACT = new i()
			num_of_gifts = min(num_of_gifts+1, length(auspice.gifts))
			if(num_of_gifts != length(auspice.gifts))
				gifts_text += "[ACT.name], "
			else
				gifts_text += "[ACT.name].<BR>"
			qdel(ACT)
		dat += "<b>Initial Gifts:</b> [gifts_text]"
		// These mobs should be made in nullspace to avoid dumping them onto the map somewhere.
		var/mob/living/carbon/werewolf/crinos/DAWOF = new
		var/mob/living/carbon/werewolf/lupus/DAWOF2 = new

		DAWOF.sprite_color = werewolf_color
		DAWOF2.sprite_color = werewolf_color

		var/obj/effect/overlay/eyes_crinos = new(DAWOF)
		eyes_crinos.icon = 'icons/wod13/werewolf.dmi'
		eyes_crinos.icon_state = "eyes"
		eyes_crinos.layer = ABOVE_HUD_LAYER
		eyes_crinos.color = werewolf_eye_color
		DAWOF.overlays |= eyes_crinos

		var/obj/effect/overlay/scar_crinos = new(DAWOF)
		scar_crinos.icon = 'icons/wod13/werewolf.dmi'
		scar_crinos.icon_state = "scar[werewolf_scar]"
		scar_crinos.layer = ABOVE_HUD_LAYER
		DAWOF.overlays |= scar_crinos

		var/obj/effect/overlay/hair_crinos = new(DAWOF)
		hair_crinos.icon = 'icons/wod13/werewolf.dmi'
		hair_crinos.icon_state = "hair[werewolf_hair]"
		hair_crinos.layer = ABOVE_HUD_LAYER
		hair_crinos.color = werewolf_hair_color
		DAWOF.overlays |= hair_crinos

		var/obj/effect/overlay/eyes_lupus = new(DAWOF2)
		eyes_lupus.icon = 'icons/wod13/werewolf_lupus.dmi'
		eyes_lupus.icon_state = "eyes"
		eyes_lupus.layer = ABOVE_HUD_LAYER
		eyes_lupus.color = werewolf_eye_color
		DAWOF2.overlays |= eyes_lupus

		DAWOF.update_icons()
		DAWOF2.update_icons()
		dat += "[icon2html(getFlatIcon(DAWOF), user)][icon2html(getFlatIcon(DAWOF2), user)]<BR>"
		qdel(DAWOF)
		qdel(DAWOF2)
		dat += "<b>Breed:</b> <a href='byond://?_src_=prefs;preference=breed;task=input'>[breed]</a><BR>"
		dat += "<b>Tribe:</b> <a href='byond://?_src_=prefs;preference=tribe;task=input'>[tribe]</a><BR>"
		dat += "Color: <a href='byond://?_src_=prefs;preference=werewolf_color;task=input'>[werewolf_color]</a><BR>"
		dat += "Scars: <a href='byond://?_src_=prefs;preference=werewolf_scar;task=input'>[werewolf_scar]</a><BR>"
		dat += "Hair: <a href='byond://?_src_=prefs;preference=werewolf_hair;task=input'>[werewolf_hair]</a><BR>"
		dat += "Hair Color: <a href='byond://?_src_=prefs;preference=werewolf_hair_color;task=input'>[werewolf_hair_color]</a><BR>"
		dat += "Eyes: <a href='byond://?_src_=prefs;preference=werewolf_eye_color;task=input'>[werewolf_eye_color]</a><BR>"

	if(pref_species.name == "Vampire")
		dat += "<br>"
		dat += "<table width='100%'><tr><td width='50%' valign='top'>"
		dat += "<h2>[make_font_cool("CLAN")]</h2>"
		dat += "<b>Clan/Bloodline:</b> <a href='byond://?_src_=prefs;preference=clane;task=input'>[clane.name]</a><BR>"
		dat += "<b>Description:</b> [clane.desc]<BR>"
		dat += "<b>Curse:</b> [clane.curse]<BR>"
		if(length(clane.accessories))
			if(clane_accessory in clane.accessories)
				dat += "<b>Marks:</b> <a href='byond://?_src_=prefs;preference=clane_acc;task=input'>[clane_accessory]</a><BR>"
			else
				if("none" in clane_accessory)
					clane_accessory = "none"
				else
					clane_accessory = pick(clane.accessories)
				dat += "<b>Marks:</b> <a href='byond://?_src_=prefs;preference=clane_acc;task=input'>[clane_accessory]</a><BR>"
		else
			clane_accessory = null
		dat += "</td>"
		dat += "<td width ='50%' valign='top'>"
		dat += "<h2>[make_font_cool("INFAMY")]</h2>"
		dat += "<b>Fame: </b><a href ='byond://?_src_=prefs;preference=info_choose;task=input'>[info_known]</a><BR>"
		if(clane?.name == "Revenant")
			dat += "<b>Covenant: </b><u>[vamp_faction.name]</u><BR>"
			dat += "<b>Description:</b> [vamp_faction.desc]<BR>"
		else
			dat += "<b>Covenant: </b><a href='byond://?_src_=prefs;preference=vamp_faction;task=input'>[vamp_faction.name]</A><BR>"
			dat += "<b>Description:</b> [vamp_faction.desc]<BR>"
		dat += "</td></tr></table>"
		
	else if(pref_species.name == "Ghoul")
		dat += "<table width='100%'><tr><td width='50%' valign='top'>"
		dat += "<h2>[make_font_cool("CLAN")]</h2>"
		dat += "<b>Original Regent's Clan:</b> <a href='byond://?_src_=prefs;preference=regent_clan;task=input'>[regent_clan.name]</a><BR>"
		dat += "<b>Description:</b> [regent_clan.desc]<BR>"
		dat += "</td>"
		dat += "<td width ='50%' valign='top'>"
		dat += "<h2>[make_font_cool("INFAMY")]</h2>"
		dat += "<b>Fame:</b><BR> <a href ='byond://?_src_=prefs;preference=info_choose;task=input'>[info_known]</a>"
		dat += "<BR><BR><b>Covenant:</b><BR> <a href='byond://?_src_=prefs;preference=vamp_faction;task=input'>The [vamp_faction.name]</A><BR>"
		dat += "<b>Description:</b> [vamp_faction.desc]<BR>"
		dat += "</td></tr></table>"

	dat += "<table width='100%'><tr><td width='30%' valign='top'>"
	dat += "<h2>[make_font_cool("DESCRIPTION")]</h2>"
	dat += "<b>Flavor Text: </b><a href='byond://?_src_=prefs;preference=flavor_text;task=input'>Change</a><BR>"
	if(length(flavor_text) <= 110)
		dat += "<i>[flavor_text]</i><br><br>"
	else
		dat += "<i>[copytext_char(flavor_text, 1, 110)]...</i> <a href='byond://?_src_=prefs;preference=view_flavortext;task=input'>Show More</a><br><br>"
	dat += "<b>Headshot(1:1):</b> <a href='byond://?_src_=prefs;preference=headshot;task=input'>Change</a>"
	if(headshot_link != null)
		dat += " <a href='byond://?_src_=prefs;preference=view_headshot;task=input'>View</a>"
	dat += "<br><br>"
	dat += "<b>Character Link:</b> <a href='byond://?_src_=prefs;preference=ooc_link;task=input'>Change</a><br><i>[ooc_link]</i>"

	dat += "</td>"
	dat += "<td width ='20%' valign='top'>"
	
	dat += "<h2>[make_font_cool("EQUIP")]</h2>"

	dat += "<b>Underwear:</b><BR><a href ='byond://?_src_=prefs;preference=underwear;task=input'>[underwear]</a>"

	dat += "<br><b>Underwear Color:</b><BR><span style='border: 1px solid #161616; background-color: #[underwear_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=underwear_color;task=input'>Change</a>"

	dat += "<BR><b>Undershirt:</b><BR><a href ='byond://?_src_=prefs;preference=undershirt;task=input'>[undershirt]</a>"

	dat += "<br><b>Socks:</b><BR><a href ='byond://?_src_=prefs;preference=socks;task=input'>[socks]</a>"

	dat += "<br><b>Backpack:</b><BR><a href ='byond://?_src_=prefs;preference=bag;task=input'>[backpack]</a>"

	if((HAS_FLESH in pref_species.species_traits) || (HAS_BONE in pref_species.species_traits))
		dat += "<BR><b>Temporal Scarring:</b><BR><a href='byond://?_src_=prefs;preference=persistent_scars'>[(persistent_scars) ? "Enabled" : "Disabled"]</A>"
		dat += "<a href='byond://?_src_=prefs;preference=clear_scars'>Clear scar slots</A>"


	dat += APPEARANCE_CATEGORY_COLUMN
	dat += "<h3>[make_font_cool("SKIN")]</h3>"
	dat += "<span style='border: 1px solid #161616; background-color: #[skin_tone];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=s_tone;task=input'>Change</a>"
	dat += "&nbsp;<a href='byond://?_src_=prefs;preference=s_tone_preset;task=input'>Use Preset</a>"
	dat += "<br>"

	dat += "<h3>[make_font_cool("EYES")]</h3>"
	dat += "<span style='border: 1px solid #161616; background-color: #[eye_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=eyes;task=input'>Change</a>"
	dat += "</td><br>"

	dat += APPEARANCE_CATEGORY_COLUMN
	dat += "<h3>[make_font_cool("HAIR")]</h3>"
	dat += "<a href='byond://?_src_=prefs;preference=hairstyle;task=input'>[hairstyle]</a>"
	dat += "<a href='byond://?_src_=prefs;preference=previous_hairstyle;task=input'>&lt;</a> <a href='byond://?_src_=prefs;preference=next_hairstyle;task=input'>&gt;</a>"
	dat += "<br><span style='border:1px solid #161616; background-color: #[hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=hair;task=input'>Change</a>"
	dat += "<br>"

	dat += "<h3>[make_font_cool("FACIAL")]</h3>"
	dat += "<a href='byond://?_src_=prefs;preference=facial_hairstyle;task=input'>[facial_hairstyle]</a>"
	dat += "<a href='byond://?_src_=prefs;preference=previous_facehairstyle;task=input'>&lt;</a> <a href='byond://?_src_=prefs;preference=next_facehairstyle;task=input'>&gt;</a>"
	dat += "<br><span style='border: 1px solid #161616; background-color: #[facial_hair_color];'>&nbsp;&nbsp;&nbsp;</span> <a href='byond://?_src_=prefs;preference=facial;task=input'>Change</a>"
	dat += "</td><br>"

	dat += "</td></tr></table>"
