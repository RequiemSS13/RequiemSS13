/datum/discipline/vtr/auspex
	name = "Auspex"
	desc = "Allows to see entities, auras and their health through walls."
	icon_state = "auspex"
	power_type = /datum/discipline_power/vtr/auspex

/datum/discipline_power/vtr/auspex
	name = "Auspex power name"
	desc = "Auspex power description"

	activate_sound = 'code/modules/wod13/sounds/auspex.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/auspex_deactivate.ogg'

/datum/discipline_power/vtr/auspex/proc/get_auspex_level()
	switch(discipline.level)
		if(2)
			return AUSPEX_LEVEL_2
		if(3)
			return AUSPEX_LEVEL_3
		if(4)
			return AUSPEX_LEVEL_4
		if(5)
			return AUSPEX_LEVEL_5
	return 0

