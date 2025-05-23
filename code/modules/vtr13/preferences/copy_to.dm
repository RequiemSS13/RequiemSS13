/datum/preferences/proc/copy_to(mob/living/carbon/human/character, icon_updates = 1, roundstart_checks = TRUE, character_setup = FALSE, antagonist = FALSE, is_latejoiner = TRUE, loadout = FALSE)

	hardcore_survival_score = 0 //Set to 0 to prevent you getting points from last another time.

	if((randomise[RANDOM_SPECIES] || randomise[RANDOM_HARDCORE]) && !character_setup)
		random_species()

	if((randomise[RANDOM_BODY] || (randomise[RANDOM_BODY_ANTAG] && antagonist) || randomise[RANDOM_HARDCORE]) && !character_setup)
		slot_randomized = TRUE
		random_character(gender, antagonist)

	if((randomise[RANDOM_NAME] || (randomise[RANDOM_NAME_ANTAG] && antagonist) || randomise[RANDOM_HARDCORE]) && !character_setup)
		slot_randomized = TRUE
		real_name = pref_species.random_name(gender)

	if(randomise[RANDOM_HARDCORE] && parent?.mob.mind && !character_setup)
		if(can_be_random_hardcore())
			hardcore_random_setup(character, antagonist, is_latejoiner)

	if(roundstart_checks)
		if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == "human"))
			var/firstspace = findtext(real_name, " ")
			var/name_length = length(real_name)
			if(!firstspace)	//we need a surname
				real_name += " [pick(GLOB.last_names)]"
			else if(firstspace == name_length)
				real_name += "[pick(GLOB.last_names)]"

	character.real_name = real_name
	character.true_real_name = real_name
	character.name = character.real_name
	character.diablerist = diablerist
	character.headshot_link = headshot_link

	character.physique = physique
	character.stamina = stamina
	character.charisma = charisma
	character.composure = composure
	character.wits = wits

	character.resolve = resolve
	character.info_known = info_known

	character.recalculate_max_health(TRUE)

	character.blood_potency = 0
	character.vamp_rank = vamp_rank
	switch(vamp_rank)
		if(VAMP_RANK_FLEDGLING)
			character.blood_potency = 1
		if(VAMP_RANK_NEONATE)
			character.blood_potency = 1
		if(VAMP_RANK_ANCILLAE)
			character.blood_potency = 3
		if(VAMP_RANK_ELDER)
			character.blood_potency = 5

	if(pref_species.name == "Vampire")
		var/datum/vampireclane/CLN = new clane.type()
		character.clane = CLN
		qdel(character.regent_clan)
		character.clane.current_accessory = clane_accessory
		character.maxbloodpool = 9 + character.blood_potency
		if(character.clane.name == "Revenant")
			character.bloodpool = character.composure
		else
			character.bloodpool = rand(character.composure, character.maxbloodpool)
		character.humanity = humanity
		character.vtr_faction = vamp_faction
	else if(pref_species.name == "Ghoul")
		character.clane = null
		var/datum/vampireclane/CLN = new regent_clan.type()
		character.regent_clan = CLN
		character.maxbloodpool = 5 + character.stamina
		character.bloodpool = rand(character.composure, character.maxbloodpool)
		character.vtr_faction = vamp_faction
	else if(pref_species.name == "Werewolf")
		character.blood_potency = 5
	else
		character.clane = null
		qdel(character.regent_clan)
		character.bloodpool = character.maxbloodpool

	character.masquerade = masquerade

	if(!character_setup)
		if(character in GLOB.masquerade_breakers_list)
			if(character.masquerade > 2)
				GLOB.masquerade_breakers_list -= character
		else if(character.masquerade < 3)
			GLOB.masquerade_breakers_list += character

	character.flavor_text = sanitize_text(flavor_text)
	character.ooc_notes = sanitize_text(ooc_notes)
	character.gender = gender
	character.age = age
	character.chronological_age = actual_age

	if(gender == MALE || gender == FEMALE)
		character.body_type = gender
	else
		character.body_type = body_type

	character.base_body_mod = ""

	character.eye_color = eye_color
	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		if(!initial(organ_eyes.eye_color))
			organ_eyes.eye_color = eye_color
		organ_eyes.old_eye_color = eye_color
	character.hair_color = hair_color
	character.facial_hair_color = facial_hair_color

	character.skin_tone = skin_tone

	character.hairstyle = hairstyle
	if(character.age < 16)
		facial_hairstyle = "Shaved"
		character.facial_hairstyle = facial_hairstyle
	else
		character.facial_hairstyle = facial_hairstyle
	character.underwear = underwear
	character.underwear_color = underwear_color
	character.undershirt = undershirt
	character.socks = socks
	character.backpack = backpack

	if(loadout)
		for(var/gear_name in equipped_gear)
			var/datum/gear/gear = SSloadout.gear_datums[gear_name]
			if(gear?.slot)
				character.equip_to_slot_or_del(gear.spawn_item(character, character), gear.slot)

	var/datum/species/chosen_species
	chosen_species = pref_species.type
	character.dna.features = features.Copy()
	character.set_species(chosen_species, icon_update = FALSE, pref_load = TRUE)

	character.dna.real_name = character.real_name

	if(character.clane)
		character.clane.on_gain(character)

	if(pref_species.name == "Werewolf")
		var/datum/auspice/CLN = new auspice.type()
		character.auspice = CLN
		character.auspice.level = auspice_level
		character.auspice.tribe = tribe
		character.auspice.on_gain(character)
		switch(breed)
			if("Homid")
				character.auspice.gnosis = 1
				character.auspice.start_gnosis = 1
				character.auspice.base_breed = "Homid"
			if("Lupus")
				character.auspice.gnosis = 5
				character.auspice.start_gnosis = 5
				character.auspice.base_breed = "Lupus"
			if("Metis")
				character.auspice.gnosis = 3
				character.auspice.start_gnosis = 3
				character.auspice.base_breed = "Crinos"
		if(character.transformator)
			if(character.transformator.crinos_form && character.transformator.lupus_form)
				character.transformator.crinos_form.sprite_color = werewolf_color
				character.transformator.crinos_form.sprite_scar = werewolf_scar
				character.transformator.crinos_form.sprite_hair = werewolf_hair
				character.transformator.crinos_form.sprite_hair_color = werewolf_hair_color
				character.transformator.crinos_form.sprite_eye_color = werewolf_eye_color
				character.transformator.lupus_form.sprite_color = werewolf_color
				character.transformator.lupus_form.sprite_eye_color = werewolf_eye_color

				if(werewolf_name)
					character.transformator.crinos_form.name = werewolf_name
					character.transformator.lupus_form.name = werewolf_name
				else
					character.transformator.crinos_form.name = real_name
					character.transformator.lupus_form.name = real_name

				character.transformator.crinos_form.physique = physique
				character.transformator.crinos_form.stamina = stamina
				character.transformator.crinos_form.wits = wits
				character.transformator.crinos_form.resolve = resolve
				character.transformator.crinos_form.composure = composure

				character.transformator.lupus_form.physique = physique
				character.transformator.lupus_form.stamina = stamina
				character.transformator.lupus_form.wits = wits
				character.transformator.lupus_form.resolve = resolve
				character.transformator.lupus_form.composure = composure

				character.transformator.lupus_form.maxHealth = round((initial(character.transformator.lupus_form.maxHealth)+(initial(character.maxHealth)/4)*(character.physique + character.additional_physique )))+(character.auspice.level-1)*50
				character.transformator.lupus_form.health = character.transformator.lupus_form.maxHealth
				character.transformator.crinos_form.maxHealth = round((initial(character.transformator.crinos_form.maxHealth)+(initial(character.maxHealth)/4)*(character.physique + character.additional_physique )))+(character.auspice.level-1)*50
				character.transformator.crinos_form.health = character.transformator.crinos_form.maxHealth
	if(icon_updates)
		character.update_body()
		character.update_hair()
		character.update_body_parts()
	if(!character_setup)
		parent << browse(null, "window=preferences_window")
		parent << browse(null, "window=preferences_browser")
