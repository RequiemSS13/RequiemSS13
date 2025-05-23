/obj/effect/vip_barrier/boris
	name = "Kiss Entrance"
	desc = "Marks the beginning of the Kiss Nightclub. Watched by a taciturn guardian."
	protected_zone_id = "kiss_front"
	social_roll_difficulty = 2


/obj/effect/vip_barrier/boris/check_entry_permission_custom(var/mob/living/carbon/human/entering_mob)
	return TRUE