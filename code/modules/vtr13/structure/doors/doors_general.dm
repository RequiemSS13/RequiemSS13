//all the random doors around the city that should be locked but players shouldn't have keys for
/obj/structure/vampdoor/vtr_generic //to get behind the counter at taco bell or whatever
	icon_state = "cam-1"
	baseicon = "cam"
	locked = TRUE
	lock_id = "shop"
	lockpick_difficulty = 2

/obj/structure/vampdoor/vtr_generic/apartment //all apartment hallway doors, also the coffee shop backdoor until hunters get added
	icon_state = "wood-1"
	baseicon = "wood"
	burnable = TRUE
	lock_id = "apartment"
	lockpick_difficulty = 4

/obj/structure/vampdoor/vtr_generic/apartment_glass //that glass door below the hunter apartment
	icon_state = "glass_blue-1"
	baseicon = "glass_blue"
	opacity = FALSE
	glass = TRUE
	burnable = TRUE
	lock_id = "apartment"
	lockpick_difficulty = 4

/obj/structure/vampdoor/vtr_generic/house_glass
	icon_state = "glass_blue-1"
	baseicon = "glass_blue"
	opacity = FALSE
	glass = TRUE
	burnable = TRUE
	lock_id = "house"
	lockpick_difficulty = 4

/obj/structure/vampdoor/vtr_generic/vtr_house_wood
	icon_state = "wood-1"
	baseicon = "wood"
	burnable = TRUE
	locked = TRUE
	lock_id = "house"
	lockpick_difficulty = 4

/obj/structure/vampdoor/vtr_generic/ship
	icon_state = "ship-1"
	baseicon = "ship"
	burnable = FALSE
	locked = FALSE
