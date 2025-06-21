/datum/job/vamp/vtr/clergy
	title = "Clergy"
	department_head = list("Bishop")
	faction = "Vampire"
	total_positions = 20
	spawn_positions = 20
	supervisors = " the Bishop"
	selection_color = "#cab866"

	outfit = /datum/outfit/job/clergy

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_CLERGY

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SERVICES

	allowed_species = list("Human")

	duty = "You are low-ranking clergy at St. Catherine's Church, a confessor of its bizzare, heretical Catholicism. Minister to the souls of those in need and defer to your superiors."
	known_contacts = list("Bishop")

/datum/outfit/job/clergy
	name = "Clergy"
	jobtype = /datum/job/vamp/vtr/clergy
	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/sanctified
	l_pocket = /obj/item/vamp/phone/sanctified
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/vamp/keys/clergy=1)

/obj/effect/landmark/start/vtr/clergy
	name = "Clergy"
	icon_state = "Clerk"
