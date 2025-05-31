/datum/attribute
	var/name = ""
	var/description = ""
	var/score = 0
	var/bonus_score = 0
	/// A dictionary of modifiers to this attribute.
	var/list/modifiers = list()

/datum/attribute/proc/get(include_bonus = TRUE)
	if(include_bonus)
		return score + bonus_score
	else
		return score

/datum/attribute/proc/setter(amount)
	score = amount

/datum/attribute/proc/update_modifiers()
	SHOULD_NOT_OVERRIDE(TRUE)
	bonus_score = initial(bonus_score)
	for(var/source in modifiers)
		bonus_score += modifiers[source]
	bonus_score = clamp(bonus_score, -10, 10)

/datum/attribute/physique
	name = "Physique"
	description = PHYSIQUE_DESCRIPTION
	score = 1

/datum/attribute/stamina
	name = "Stamina"
	description = STAMINA_DESCRIPTION
	score = 1

/datum/attribute/charisma
	name = "Charisma"
	description = CHARISMA_DESCRIPTION
	score = 1

/datum/attribute/charisma/proc/barter()
	return (score + (bonus_score * 0.1))

/datum/attribute/composure
	name = "Composure"
	description = COMPOSURE_DESCRIPTION
	score = 1

/datum/attribute/wits
	name = "Wits"
	description = WITS_DESCRIPTION
	score = 1

/datum/attribute/resolve
	name = "Resolve"
	description = RESOLVE_DESCRIPTION
	score = 1
