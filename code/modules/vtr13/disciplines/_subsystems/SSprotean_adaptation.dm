SUBSYSTEM_DEF(protean_adaptation)
	name = "Protean Adaptations"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_ATOMS
	var/barriers_enabled = TRUE

	///List of vip barriers
	var/list/adaptations_predatory = list()

	var/list/adaptations_unnatural = list()


/datum/controller/subsystem/protean_adaptation/Initialize()
	for(var/adaptation in subtypesof(/datum/adaptation/predatory))
		var/datum/adaptation/predatory/p_adaptation = new adaptation
		if(adaptations_predatory["[p_adaptation.name]"])
			CRASH("Two protean predatory adaptations of the same name exist on [p_adaptation.name]! Not allowed!")
		adaptations_predatory["[p_adaptation.name]"] = adaptation
		qdel(p_adaptation)
	
	for(var/adaptation in subtypesof(/datum/adaptation/unnatural))
		var/datum/adaptation/unnatural/u_adaptation = new adaptation
		if(adaptations_unnatural["[u_adaptation.name]"])
			CRASH("Two protean unnatural adaptations of the same name exist on [u_adaptation.name]! Not allowed!")
		adaptations_unnatural["[u_adaptation.name]"] = adaptation
		qdel(u_adaptation)

	return ..()
