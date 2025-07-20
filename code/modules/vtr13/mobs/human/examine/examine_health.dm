/mob/living/carbon/human/proc/examine_health(mob/user)
	. = list()
	var/t_He = p_they(TRUE)
	var/t_His = p_their(TRUE)
	var/t_his = p_their()
	var/t_has = p_have()
	var/t_is = p_are()



	var/temp = getBruteLoss() //no need to calculate each of these twice

	var/list/missing = list(BODY_ZONE_HEAD, BODY_ZONE_CHEST, BODY_ZONE_L_ARM, BODY_ZONE_R_ARM, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
	var/list/disabled = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/body_part = X
		if(body_part.bodypart_disabled)
			disabled += body_part
		missing -= body_part.body_zone
		for(var/obj/item/I in body_part.embedded_objects)
			if(I.isEmbedHarmless())
				. += span_warning("<B>[t_He] [t_has] [icon2html(I, user)] \a [I] stuck to [t_his] [body_part.name]!</B>")
			else
				. += span_warning("<B>[t_He] [t_has] [icon2html(I, user)] \a [I] embedded in [t_his] [body_part.name]!</B>")

		for(var/i in body_part.wounds)
			var/datum/wound/iter_wound = i
			. += span_warning("[iter_wound.get_examine_description(user)]")

	for(var/X in disabled)
		var/obj/item/bodypart/body_part = X
		var/damage_text
		if(HAS_TRAIT(body_part, TRAIT_DISABLED_BY_WOUND))
			continue // skip if it's disabled by a wound (cuz we'll be able to see the bone sticking out!)
		if(!(body_part.get_damage(include_stamina = FALSE) >= body_part.max_damage)) //we don't care if it's stamcritted
			damage_text = "limp and lifeless"
		else
			damage_text = (body_part.brute_dam >= body_part.burn_dam) ? body_part.heavy_brute_msg : body_part.heavy_burn_msg
		. += span_warning("<B>[capitalize(t_his)] [body_part.name] is [damage_text]!</B>")

	//stores missing limbs
	var/l_limbs_missing = 0
	var/r_limbs_missing = 0
	for(var/t in missing)
		if(t==BODY_ZONE_HEAD)
			. += "<span class='deadsay'><B>[t_His] [parse_zone(t)] is missing!</B><span class='warning'>"
			continue
		if(t == BODY_ZONE_L_ARM || t == BODY_ZONE_L_LEG)
			l_limbs_missing++
		else if(t == BODY_ZONE_R_ARM || t == BODY_ZONE_R_LEG)
			r_limbs_missing++

		. += span_warning("<B>[capitalize(t_his)] [parse_zone(t)] is missing!</B>")

	if(l_limbs_missing >= 2 && r_limbs_missing == 0)
		. += span_warning("[t_He] look[p_s()] all right now.")
	else if(l_limbs_missing == 0 && r_limbs_missing >= 2)
		. += span_warning("[t_He] really keeps to the left.")
	else if(l_limbs_missing >= 2 && r_limbs_missing >= 2)
		. += span_warning("[t_He] [p_do()]n't seem all there.")

	if(!(user == src && src.hal_screwyhud == SCREWYHUD_HEALTHY)) //fake healthy
		if(temp)
			if(temp < 25)
				. += span_warning("[t_He] [t_has] minor bruising.")
			else if(temp < 50)
				. += span_warning("[t_He] [t_has] <b>moderate</b> bruising!")
			else
				. += span_warning("<B>[t_He] [t_has] severe bruising!</B>")

		temp = getFireLoss()
		if(temp)
			if(temp < 25)
				. += span_warning("[t_He] [t_has] minor burns.")
			else if (temp < 50)
				. += span_warning("[t_He] [t_has] <b>moderate</b> burns!")
			else
				. += span_warning("<B>[t_He] [t_has] severe burns!</B>")

		temp = getCloneLoss()
		if(temp)
			if(temp < 25)
				. += span_warning("[t_He] [t_has] minor cellular damage.")
			else if(temp < 50)
				. += span_warning("[t_He] [t_has] <b>moderate</b> cellular damage!")
			else
				. += span_warning("<b>[t_He] [t_has] severe cellular damage!</b>")


	if(fire_stacks > 0)
		. += span_warning("[t_He] [t_is] covered in something flammable.")
	if(fire_stacks < 0)
		. += span_warning("[t_He] look[p_s()] a little soaked.")


	if(nutrition < NUTRITION_LEVEL_STARVING - 50)
		. += "[t_He] [t_is] severely malnourished."
	else if(nutrition >= NUTRITION_LEVEL_FAT)
		. += "[t_He] [t_is] quite chubby."
	switch(disgust)
		if(DISGUST_LEVEL_GROSS to DISGUST_LEVEL_VERYGROSS)
			. += "[t_He] look[p_s()] a bit grossed out."
		if(DISGUST_LEVEL_VERYGROSS to DISGUST_LEVEL_DISGUSTED)
			. += "[t_He] look[p_s()] really grossed out."
		if(DISGUST_LEVEL_DISGUSTED to INFINITY)
			. += "[t_He] look[p_s()] extremely disgusted."

	switch(blood_volume)
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			. += "[t_He] look[p_s()] a little anemic."
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_OKAY)
			. += "[t_He] look[p_s()] anemic."
		if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
			. += "[t_He] look[p_s()] incredibly anemic."
		if(-INFINITY to BLOOD_VOLUME_SURVIVE)
			. += "[t_He] [t_is] deathly pale."
	return length(.) ? . : null
