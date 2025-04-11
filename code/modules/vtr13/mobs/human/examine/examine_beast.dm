/mob/living/carbon/human/proc/examine_beast(mob/user)
	var/notify_beast = FALSE
	if(iskindred(user))
		notify_beast = TRUE
	else if(isghoul(user))
		if(HAS_TRAIT(user, TRAIT_USING_AUSPEX))
			notify_beast = TRUE
	
	if(notify_beast && iskindred(src))
		var/t_He = p_they(TRUE)
		var/t_him = p_them()
		var/t_is = p_are()
		return span_danger("You sense the beast within [t_him] - [t_He] [t_is] a kindred.")