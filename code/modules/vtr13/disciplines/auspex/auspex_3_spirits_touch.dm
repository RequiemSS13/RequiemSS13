//SPIRIT'S TOUCH
/datum/discipline_power/vtr/auspex/the_spirits_touch
	name = "Spirit's Touch"
	desc = "Feel the psychic resonances left on objects around you."

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SEE|DISC_CHECK_CONSCIOUS

	level = 3

	range = 1
	target_type = TARGET_LIVING | TARGET_OBJ | TARGET_SELF | TARGET_TURF
	
	deactivate_sound = null

/datum/discipline_power/vtr/auspex/the_spirits_touch/activate(atom/target)
	. = ..()
	var/list/result = target.examine(owner)
	result.Add(target.spirit_touch_description(owner))
	to_chat(owner, result.Join("\n"))


/atom/proc/spirit_touch_description(mob/living/carbon/human/user)
	if(!user)
		return

	if(!isturf(src) && !isobj(src) && !ismob(src))
		return
	var/list/hiddenprints = return_hiddenprints()
	var/list/blood = return_blood_DNA()
	var/list/reagents = list()

	if(isturf(src))
		var/turf/T = src
		// Only get reagents from non-mobs.
		if(T.reagents && T.reagents.reagent_list.len)

			for(var/datum/reagent/R in T.reagents.reagent_list)
				T.reagents[R.name] = R.volume

				// Get blood data from the blood reagent.
				if(istype(R, /datum/reagent/blood))

					if(R.data["blood_DNA"] && R.data["blood_type"])
						var/blood_DNA = R.data["blood_DNA"]
						var/blood_type = R.data["blood_type"]
						LAZYINITLIST(blood)
						blood[blood_DNA] = blood_type
	if(isobj(src))
		var/obj/T = src
		// Only get reagents from non-mobs.
		if(T.reagents && T.reagents.reagent_list.len)

			for(var/datum/reagent/R in T.reagents.reagent_list)
				T.reagents[R.name] = R.volume

				// Get blood data from the blood reagent.
				if(istype(R, /datum/reagent/blood))

					if(R.data["blood_DNA"] && R.data["blood_type"])
						var/blood_DNA = R.data["blood_DNA"]
						var/blood_type = R.data["blood_type"]
						LAZYINITLIST(blood)
						blood[blood_DNA] = blood_type
	var/found_something = FALSE
	var/list/result = list()

	// Fingerprints
	if(length(hiddenprints))
		result += span_notice("<B>Was Touched By:</B>")
		for(var/print in hiddenprints)
			result += span_notice("[hiddenprints[print]]")
		found_something = TRUE

	// Blood
	if (length(blood))
		result += span_notice("<B>BLOOD:</B>")
		found_something = TRUE
		for(var/B in blood)
			if(B)
				result += "Type: <font color='red'>[blood[B]]</font> DNA (UE): <font color='red'>[B]</font>"

	//Reagents
	if(length(reagents))
		result += span_notice("<B>Reagents:</B>")
		for(var/R in reagents)
			result += span_notice("Reagent: <font color='red'>[R]</font> Volume: <font color='red'>[reagents[R]]</font>")
		found_something = TRUE

	if(!found_something)
		result += span_notice("<I># No Recent Interactions #</I>") // Don't display this to the holder user

	return result