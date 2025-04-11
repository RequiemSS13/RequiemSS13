SUBSYSTEM_DEF(dominate_compulsion)
	name = "Dominate Compulsions"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_ATOMS
	var/list/compel_list = list()
	var/list/command_list = list()
	var/duration = 1 MINUTES

/datum/controller/subsystem/dominate_compulsion/Initialize()
	for(var/dominate_act_type in subtypesof(/datum/dominate_act/compel))
		var/datum/dominate_act/dominate_act = new dominate_act_type()
		if(compel_list["[dominate_act.phrase]"])
			CRASH("Two dominate_act/compel classes of the same phrase exist on [dominate_act.phrase]! Not allowed!")
		compel_list["[dominate_act.phrase]"] = dominate_act

	for(var/dominate_act_type in subtypesof(/datum/dominate_act/command))
		var/datum/dominate_act/dominate_act = new dominate_act_type()
		if(command_list["[dominate_act.phrase]"])
			CRASH("Two dominate_act/command classes of the same phrase exist on [dominate_act.phrase]! Not allowed!")
		command_list["[dominate_act.phrase]"] = dominate_act

	return ..()