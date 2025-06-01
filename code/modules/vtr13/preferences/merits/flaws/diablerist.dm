/datum/merit/flaw/diablerist
	name = "Diablerist"
	desc = "For one reason or another, you have committed Diablerie in your past, a great crime within Kindred society. Your blood potency is one higher, but the stain of this act is a weakness you must hide. <b>This is not a license to Diablerize without proper reason!</b>"
	mob_trait = TRAIT_DIABLERIE
	dots = 0
	splat_flags = MERIT_SPLAT_KINDRED
	clan_flags = MERIT_CLAN_DAEVA|MERIT_CLAN_GANGREL|MERIT_CLAN_MEKHET|MERIT_CLAN_NOSFERATU|MERIT_CLAN_VENTRUE

/datum/merit/flaw/diablerist/add()
	merit_holder.add_potency_mod(1, TRAIT_DIABLERIE)

/datum/merit/flaw/diablerist/remove()
	merit_holder.remove_potency_mod(TRAIT_DIABLERIE)