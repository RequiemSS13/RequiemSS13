

///Setup a hardcore random character and calculate their hardcore random score
/datum/preferences/proc/hardcore_random_setup(mob/living/carbon/human/character, antagonist, is_latejoiner)
	var/rand_gender = pick(list(MALE, FEMALE, PLURAL))
	random_character(rand_gender, antagonist)
	select_hardcore_quirks()
	hardcore_survival_score = hardcore_survival_score ** 1.2 //30 points would be about 60 score
	if(is_latejoiner)//prevent them from cheatintg
		hardcore_survival_score = 0

///Go through all quirks that can be used in hardcore mode and select some based on a random budget.
/datum/preferences/proc/select_hardcore_quirks()

	var/quirk_budget = rand(8, 35)


	all_quirks = list() //empty it out

	var/list/available_hardcore_quirks = SSquirks.hardcore_quirks.Copy()

	while(quirk_budget > 0)
		for(var/i in available_hardcore_quirks) //Remove from available quirks if its too expensive.
			var/datum/quirk/available_quirk = i
			if(available_hardcore_quirks[available_quirk] > quirk_budget)
				available_hardcore_quirks -= available_quirk

		if(!available_hardcore_quirks.len)
			break

		var/datum/quirk/picked_quirk = pick(available_hardcore_quirks)

		var/picked_quirk_blacklisted = FALSE
		for(var/bl in SSquirks.quirk_blacklist) //Check if the quirk is blacklisted with our current quirks. quirk_blacklist is a list of lists.
			var/list/blacklist = bl
			if(!(picked_quirk in blacklist))
				continue
			for(var/iterator_quirk in all_quirks) //Go through all the quirks we've already selected to see if theres a blacklist match
				if((iterator_quirk in blacklist) && !(iterator_quirk == picked_quirk)) //two quirks have lined up in the list of the list of quirks that conflict with each other, so return (see quirks.dm for more details)
					picked_quirk_blacklisted = TRUE
					break
			if(picked_quirk_blacklisted)
				break

		if(picked_quirk_blacklisted)
			available_hardcore_quirks -= picked_quirk
			continue

		if(initial(picked_quirk.mood_quirk) && CONFIG_GET(flag/disable_human_mood)) //check for moodlet quirks
			available_hardcore_quirks -= picked_quirk
			continue

		all_quirks += initial(picked_quirk.name)
		quirk_budget -= available_hardcore_quirks[picked_quirk]
		hardcore_survival_score += available_hardcore_quirks[picked_quirk]
		available_hardcore_quirks -= picked_quirk
