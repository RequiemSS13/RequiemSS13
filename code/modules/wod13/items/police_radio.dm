/obj/item/police_radio
	name = "dispatch frequency radio"
	desc = "911, I'm stuck in my dishwasher and stepbrother is coming in my room..."
	icon_state = "radio"
	icon = 'code/modules/wod13/items.dmi'
	onflooricon = 'code/modules/wod13/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/last_shooting = 0
	var/last_shooting_victims = 0

/obj/item/police_radio/examine(mob/user)
	. = ..()
	var/turf/T = get_turf(user)
	if(T)
		. += "<b>Location:</b> [T.x]:[T.y]"

/obj/item/police_radio/proc/announce_crime(var/crime, var/atom/location)
	switch(crime)
		if("shooting")
			if(last_shooting+50 < world.time)
				last_shooting = world.time
				var/area/A = get_area(location)
				say("Gun shots at [A.name], [location.x]:[location.y]...")
		if("victim")
			if(last_shooting_victims+50 < world.time)
				last_shooting_victims = world.time
				var/area/A = get_area(location)
				say("Engaged combat at [A.name], wounded civillian, [location.x]:[location.y]...")
		if("murder")
			var/area/A = get_area(location)
			say("Murder at [A.name], [location.x]:[location.y]...")

/obj/item/police_radio/Initialize()
	. = ..()
	GLOB.police_radios += src

/obj/item/police_radio/Destroy()
	. = ..()
	GLOB.police_radios -= src
