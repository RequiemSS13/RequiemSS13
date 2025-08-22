/datum/job/vamp/vtr/vicar
	title = "Vicar"
	department_head = list("Bishop")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = " the Bishop"
	selection_color = "#cab866"

	outfit = /datum/outfit/job/vicar

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_VICAR

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_LANCEA
	minimum_vamp_rank = VAMP_RANK_NEONATE
	known_contacts = list("Bishop")

	endorsement_required = TRUE
	is_deputy = TRUE

	allowed_species = list("Vampire")
	v_duty = "You're a Vicar, a senior member of the Lancea et Sanctum. Bear up the Lance and keep the Chapel in the name of your Bishop. Advise your fellow Kindred on matters of faith and morality. Discretely dispose of any unfortunate lapses in judgement."

/datum/outfit/job/vicar
	name = "Vicar"
	jobtype = /datum/job/vamp/vtr/vicar
	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/sanctified
	l_pocket = /obj/item/vamp/phone/sanctified
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/vamp/keys/bishop=1)

/obj/effect/landmark/start/vtr/vicar
	name = "Vicar"
	icon_state = "Clerk"
