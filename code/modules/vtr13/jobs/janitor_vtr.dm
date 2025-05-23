
/datum/job/vamp/vtr/janitor_vtr
	title = "Street Janitor"
	department_head = list("Prince")
	faction = "Vampire"
	total_positions = 6
	spawn_positions = 6
	supervisors = "the Camarilla."
	selection_color = "#e3e3e3"

	outfit = /datum/outfit/job/janitor_vtr

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	exp_type_department = EXP_TYPE_SERVICES

	display_order = JOB_DISPLAY_ORDER_JANITOR_VTR

	allowed_species = list("Vampire", "Ghoul", "Human")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

	v_duty = "Clean up all traces of Masquerade violations as the Camarilla has instructed you to."
	duty = "Keep the streets clean. You are paid to keep your mouth shut about the things you see."

/datum/outfit/job/janitor_vtr
	name = "Street Janitor"
	jobtype = /datum/job/vamp/vtr/janitor_vtr

	id = /obj/item/card/id/cleaning
	uniform = /obj/item/clothing/under/vampire/janitor
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/janitor_vtr
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	gloves = /obj/item/clothing/gloves/vampire/cleaning
	backpack_contents = list(/obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/keys/hack=1, /obj/item/vamp/creditcard=1)

/obj/effect/landmark/start/vtr/janitor_vtr
	name = "Street Janitor"
	icon_state = "Street Janitor"
