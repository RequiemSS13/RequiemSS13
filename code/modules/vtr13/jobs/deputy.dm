/datum/job/vamp/vtr/deputy
	title = "Deputy"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Seneschal")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Sheriff"
	selection_color = "#00ffff"
	minimal_player_age = 7
	exp_requirements = 300

	outfit = /datum/outfit/job/deputy
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS
	minimum_vamp_rank = VAMP_RANK_NEONATE
	mind_traits = list(TRAIT_DONUT_LOVER)

	display_order = JOB_DISPLAY_ORDER_DEPUTY
	known_contacts = list("Prince", "Keeper of Elysium", "Sheriff")
	bounty_types = CIV_JOB_SEC

	endorsement_required = TRUE
	is_deputy = TRUE


	allowed_species = list("Vampire")
	v_duty = "You're a Deputy, one of the Sheriff's finest hounds. Ensure that the Traditions are kept. Protect the Invictus and its leadership."

/datum/outfit/job/deputy
	name = "Deputy"
	jobtype = /datum/job/vamp/vtr/deputy

	ears = /obj/item/p25radio
	id = /obj/item/card/id/deputy
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench/armored
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/invictus
	backpack_contents = list(/obj/item/vampire_stake=1, /obj/item/vamp/creditcard=1, /obj/item/vamp/keys/sheriff_vtr=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag


/datum/outfit/job/deputy/pre_equip(mob/living/carbon/human/H)
	..()

/obj/effect/landmark/start/vtr/deputy
	name = "Deputy"
	icon_state = "Hound"
