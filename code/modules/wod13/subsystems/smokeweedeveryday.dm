SUBSYSTEM_DEF(smokeweedeveryday)
	name = "Smoke Weed Every Day"
	init_order = INIT_ORDER_DEFAULT
	wait = 1800
	priority = FIRE_PRIORITY_VERYLOW

/datum/controller/subsystem/smokeweedeveryday/fire()
	for(var/obj/structure/weedshit/W in GLOB.weed_list)
		if(W)
			if(W.weeded != 0 && W.weeded != 5)
				if(!W.wet)
					if(W.health)
						W.health = max(0, W.health-1)
					else
						W.weeded = 5
				else if(W.health)
					if(prob(33))
						W.wet = FALSE
					W.health = min(3, W.health+1)
					W.weeded = min(4, W.weeded+1)
			W.update_weed_icon()
