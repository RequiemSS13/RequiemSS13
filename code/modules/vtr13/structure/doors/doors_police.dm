/obj/structure/vampdoor/vtr_police
	icon_state = "cam-1"
	baseicon = "cam"
	locked = TRUE
	lock_id = "police"
	lockpick_difficulty = 2

/obj/structure/vampdoor/vtr_police/backdoor
	lockpick_difficulty = 3

/obj/structure/vampdoor/vtr_police/medium //used for both interrogation and equipment room
	lockpick_difficulty = 4

/obj/structure/vampdoor/vtr_police/cells
	icon_state = "prison-1"
	baseicon = "prison"
	lockpick_difficulty = 6

/obj/structure/vampdoor/vtr_police/sergeant
	lock_id = "sergeant"
	lockpick_difficulty = 4

/obj/structure/vampdoor/vtr_police/chief
	lock_id = "chief"
	lockpick_difficulty = 5

/obj/structure/vampdoor/vtr_police/armory
	icon_state = "vault-1"
	baseicon = "vault"
	lock_id = "sergeant"
	lockpick_difficulty = 7 //there are 9 million guns in here, this is the hardest lock on the map and will require maxed stats and either luck or enough time for multiple attempts
