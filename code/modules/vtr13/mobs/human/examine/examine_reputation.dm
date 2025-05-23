/mob/living/carbon/human/proc/examine_reputation(mob/user, temp_gender = null)
	var/t_him = p_them(FALSE, temp_gender)

	if(iskindred(user) && iskindred(src) && is_face_visible())
		switch(info_known)
			if(INFO_KNOWN_PUBLIC)
				return "<b>You know [t_him] as \a [job] of the [clane] clan.</b>"
			if(INFO_KNOWN_FACTION)
				//TODO: HEX - Same faction nonsense inclusion.
				return "<b>You know [t_him] as \a [job] of the [vtr_faction.name].</b>"
