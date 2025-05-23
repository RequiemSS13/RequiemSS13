/mob/living/carbon/human/proc/examine_health_no_disguise(mob/user, temp_gender=null)
	. = list()
	var/t_He = p_they(TRUE, temp_gender)
	var/t_his = p_their(FALSE, temp_gender)
	var/t_is = p_are(FALSE, temp_gender)

	if(pulledby?.grab_state)
		. += span_warning("[t_He] [t_is] restrained by [pulledby]'s grip.")

	if(!is_bleeding())
		return length(.) ? . : null

	

	var/appears_dead = (stat == DEAD || (HAS_TRAIT(src, TRAIT_FAKEDEATH)))
	var/list/obj/item/bodypart/bleeding_limbs = list()
	var/list/obj/item/bodypart/grasped_limbs = list()

	for(var/i in bodyparts)
		var/obj/item/bodypart/body_part = i
		if(body_part.get_bleed_rate())
			bleeding_limbs += body_part
		if(body_part.grasped_by)
			grasped_limbs += body_part

	var/num_bleeds = LAZYLEN(bleeding_limbs)

	var/list/bleed_text
	if(appears_dead)
		bleed_text = list("<span class='deadsay'><B>Blood is visible in [t_his] open")
	else
		bleed_text = list("<B>[t_He] [t_is] bleeding from [t_his]")

	switch(num_bleeds)
		if(1 to 2)
			bleed_text += " [bleeding_limbs[1].name][num_bleeds == 2 ? " and [bleeding_limbs[2].name]" : ""]"
		if(3 to INFINITY)
			for(var/i in 1 to (num_bleeds - 1))
				var/obj/item/bodypart/body_part = bleeding_limbs[i]
				bleed_text += " [body_part.name],"
			bleed_text += " and [bleeding_limbs[num_bleeds].name]"

	if(appears_dead)
		bleed_text += ", but it has pooled and is not flowing.</span></B>\n"
	else
		if(reagents.has_reagent(/datum/reagent/toxin/heparin, needs_metabolizing = TRUE))
			bleed_text += " incredibly quickly"

		bleed_text += "!</B>\n"

	for(var/i in grasped_limbs)
		var/obj/item/bodypart/grasped_part = i
		bleed_text += "[t_He] [t_is] holding [t_his] [grasped_part.name] to slow the bleeding!\n"

	. += span_warning(bleed_text.Join())

	return length(.) ? . : null