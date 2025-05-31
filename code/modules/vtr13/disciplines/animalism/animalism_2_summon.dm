/datum/discipline_power/vtr/animalism/summon
	name = "Summon Small Animals"
	desc = "Summon a cat or rat from the urban environment."
	level = 2
	violates_masquerade = FALSE
	var/list/summon_list = list(
		"rat" = /mob/living/simple_animal/hostile/beastmaster/rat,
		"cat" = /mob/living/simple_animal/hostile/beastmaster/cat)
	var/options_lockout = FALSE //prevents storing activations through the option menu

/datum/discipline_power/vtr/animalism/summon/activate()
	. = ..()
	var/limit = 1 + owner.get_charisma() + owner.more_companions
	if(length(owner.beastmaster) >= limit)
		var/mob/living/simple_animal/hostile/beastmaster/beast = pick(owner.beastmaster)
		beast.death()

	if(!length(owner.beastmaster))
		var/datum/action/beastmaster_stay/stay = new()
		stay.Grant(owner)
		var/datum/action/beastmaster_deaggro/deaggro = new()
		deaggro.Grant(owner)


/datum/discipline_power/vtr/animalism/summon/activate()
	. = ..()
	if(options_lockout)
		return
	options_lockout = TRUE
	var/choice = tgui_input_list(owner, "Choose a creature to summon:", "Creatures", summon_list)
	options_lockout = FALSE
	if(!choice)
		return
	var/creature_to_summon = summon_list[choice]
	var/mob/living/simple_animal/hostile/beastmaster/picked_summon = new creature_to_summon(get_turf(owner))
	picked_summon.my_creator = owner
	owner.beastmaster |= picked_summon
	picked_summon.beastmaster = owner

