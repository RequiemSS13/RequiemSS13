/datum/merit/bane/childe_of_orlok
	name = "Childe of Orlok"
	desc = "The Nosferatu curse has changed you to the point where your appearance alone violates the masquerade. WARNING: If you take this bane, you should pick something to cover your face in the loadout section."
	mob_trait = TRAIT_UGLY
	clan_flags = MERIT_CLAN_NOSFERATU
	human_only = TRUE


/datum/merit/bane/childe_of_orlok/on_spawn()
	. = ..()
	var/mob/living/carbon/human/human_merit_holder = merit_holder
	if(!human_merit_holder?.dna?.species?.limbs_id)
		return
	human_merit_holder.unique_body_sprite = "nosferatu"
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