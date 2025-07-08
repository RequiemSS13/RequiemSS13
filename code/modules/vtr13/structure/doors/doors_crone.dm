/obj/structure/vampdoor/vtr_crone
	icon_state = "wood-1"
	baseicon = "wood"
	burnable = TRUE
	locked = TRUE
	lock_id = "acolyte"
	lockpick_difficulty = 2


/obj/structure/vampdoor/vtr_crone/basement
	icon_state = "ship-1"
	baseicon = "ship"
	burnable = FALSE
	lockpick_difficulty = 6 //crones have had a lot of time to make this boat harder to crack than most places

/obj/structure/vampdoor/vtr_crone/basement/unlocked
	locked = FALSE

/obj/structure/vampdoor/vtr_crone/cells
	icon_state = "prison-1"
	baseicon = "prison"
	burnable = FALSE
	lockpick_difficulty = 6

/obj/structure/vampdoor/vtr_crone/office
	icon_state = "ship-1"
	baseicon = "ship"
	burnable = FALSE
	lock_id = "heirophant"
	lockpick_difficulty = 5
