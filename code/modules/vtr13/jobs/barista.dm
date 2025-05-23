
/datum/job/vamp/vtr/barista
	title = "Barista"
	faction = "Vampire"
	total_positions = 2
	spawn_positions = 2
	supervisors = "Caffeine"
	selection_color = "#e3e3e3"

	outfit = /datum/outfit/job/barista

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	exp_type_department = EXP_TYPE_SERVICES

	display_order = JOB_DISPLAY_ORDER_BARISTA

	allowed_species = list("Human")

	duty = "Fuel the city's tireless nights with caffinated drinks and conversation. Listen to tired cops and assorted night-owls."

/datum/outfit/job/barista
	name = "Bartender"
	jobtype = /datum/job/vamp/vtr/barista

	id = /obj/item/card/id/barista
	uniform = /obj/item/clothing/under/vampire/emo
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/barista
	r_pocket = /obj/item/cockclock
	backpack_contents = list(/obj/item/vamp/keys/barista=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

/obj/effect/landmark/start/vtr/barista
	name = "Barista"
	icon_state = "Street Janitor"
