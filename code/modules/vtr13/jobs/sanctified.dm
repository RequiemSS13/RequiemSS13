/datum/job/vamp/vtr/sanctified
	title = "Sanctified"
	department_head = list("Bishop")
	faction = "Vampire"
	total_positions = 20
	spawn_positions = 20
	supervisors = " the Bishop"
	selection_color = "#cab866"

	outfit = /datum/outfit/job/sanctified

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_SANCTIFIED

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_LANCEA
	known_contacts = list("Bishop")

	allowed_species = list("Vampire", "Ghoul")
	duty = "You're a ghoul belonging to one of the Sanctified, or to the Lancea et Sanctum itself. Help the Sanctified with their work. Dispose of corpses in the crematorium. Find salvation in the blood."
	v_duty = "You're one of the Sanctified, the clergy of the Lancea et Sanctum. Bear up the Lance and keep the Chapel. Keep the kine faithful. Advise your fellow Kindred on matters of faith and morality. Discretely dispose of any unfortunate lapses in judgement."

/datum/outfit/job/sanctified
	name = "Sanctified"
	jobtype = /datum/job/vamp/vtr/sanctified

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/sanctified
	l_pocket = /obj/item/vamp/phone/sanctified
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/vamp/keys/sanctified=1)

/obj/effect/landmark/start/vtr/sanctified
	name = "Sanctified"
	icon_state = "Clerk"
