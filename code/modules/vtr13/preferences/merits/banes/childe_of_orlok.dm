/datum/merit/bane/childe_of_orlok
	name = "Childe of Orlok"
	desc = "The Nosferatu curse has changed you to the point where your appearance alone violates the masquerade. WARNING: If you take this bane, you should pick something to cover your face in the loadout section."
	mob_trait = TRAIT_UGLY
	clan_flags = MERIT_CLAN_NOSFERATU
	human_only = TRUE
	custom_setting_required = TRUE
	custom_setting_types = "alt_sprite"

/datum/merit/bane/childe_of_orlok/on_spawn()
	. = ..()
	var/chosen_sprite = custom_settings["alt_sprite"]
	switch(chosen_sprite)
		if("Classic")
			chosen_sprite = "nosferatu"
		if("Otherworldly")
			chosen_sprite = "kiasyd"
		if("Rotten")
			chosen_sprite = "rotten1"
		if("Very Rotten")
			chosen_sprite = "rotten2"
		if("Extremely Rotten")
			chosen_sprite = "rotten3"
	var/mob/living/carbon/human/human_merit_holder = merit_holder
	if(!human_merit_holder?.dna?.species?.limbs_id)
		return
	human_merit_holder.unique_body_sprite = chosen_sprite
	human_merit_holder.update_body()
	human_merit_holder.update_body()
	human_merit_holder.update_icon()


/datum/merit/bane/childe_of_orlok/remove()
	var/mob/living/carbon/human/human_merit_holder = merit_holder
	if(!human_merit_holder?.dna?.species?.limbs_id)
		return
	human_merit_holder.unique_body_sprite = initial(human_merit_holder.unique_body_sprite)
	human_merit_holder.update_body_parts()
	human_merit_holder.update_body()
	human_merit_holder.update_icon()
