
/datum/job/vamp/vtr/whip
	title = "Whip"
	department_head = list("Carthian Representative")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Carthian Representative"
	selection_color = "#ff1904"

	outfit = /datum/outfit/job/whip

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_CAR

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_CARTHIAN

	minimum_vamp_rank = VAMP_RANK_NEONATE

	display_order = JOB_DISPLAY_ORDER_WHIP
	bounty_types = CIV_JOB_RANDOM
	known_contacts = list("Carthian Representative")

	endorsement_required = TRUE
	is_deputy = TRUE

	allowed_species = list("Vampire")
	v_duty = "You're a member of the Carthian Representative's cabinet. Organize votes. Keep the contraband flowing. Protect your fellow Carthians from the abuses of their elders."

/datum/outfit/job/whip
	name = "Whip"
	jobtype = /datum/job/vamp/vtr/whip

	id = /obj/item/card/id/whip
	uniform = /obj/item/clothing/under/vampire/emo
	l_pocket = /obj/item/vamp/phone/carthian
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/vamp/keys/representative=1, /obj/item/melee/chainofcommand=1)

/obj/effect/landmark/start/vtr/whip
	name = "Whip"
	icon_state = "Supply Technician"
