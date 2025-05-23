/datum/preferences/proc/process_trait_links(mob/user, list/href_list)
	switch(href_list["task"])
		if("close")
			user << browse(null, "window=mob_occupation")
			ShowChoices(user)
		if("update")
			var/quirk = href_list["trait"]
			if(!SSquirks.quirks[quirk])
				return
			for(var/V in SSquirks.quirk_blacklist) //V is a list
				var/list/L = V
				if(!(quirk in L))
					continue
				for(var/Q in all_quirks)
					if((Q in L) && !(Q == quirk)) //two quirks have lined up in the list of the list of quirks that conflict with each other, so return (see quirks.dm for more details)
						to_chat(user, "<span class='danger'>[quirk] is incompatible with [Q].</span>")
						return
			var/value = SSquirks.quirk_points[quirk]
			var/balance = GetQuirkBalance()
			if(quirk in all_quirks)
				if(balance + value < 0)
					to_chat(user, "<span class='warning'>Refunding this would cause you to go below your balance!</span>")
					return
				all_quirks -= quirk
			else
				var/is_positive_quirk = SSquirks.quirk_points[quirk] > 0
				if(is_positive_quirk && GetPositiveQuirkCount() >= MAX_QUIRKS)
					to_chat(user, "<span class='warning'>You can't have more than [MAX_QUIRKS] positive quirks!</span>")
					return
				if(balance - value < 0)
					to_chat(user, "<span class='warning'>You don't have enough balance to gain this quirk!</span>")
					return
				all_quirks += quirk
		if("reset")
			all_quirks = list()
	return TRUE