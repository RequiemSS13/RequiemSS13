/mob/living/carbon/human/proc/examine_reputation(mob/user)
	var/t_him = p_them()

	if(iskindred(user) && iskindred(src) && is_face_visible())
		switch(info_known)
			if(INFO_KNOWN_PUBLIC)
				return "<b>You know [t_him] as \a [job] of the [clane] clan.</b>"
			if(INFO_KNOWN_FACTION)
				//TODO: HEX - Same faction nonsense inclusion.
				return "<b>You know [t_him] as \a [job] of the All-Night Society.</b>"
