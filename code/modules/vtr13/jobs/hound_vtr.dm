/datum/job/vamp/vtr/hound_vtr
	title = "Hound"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Seneschal")
	faction = "Vampire"
	total_positions = 7
	spawn_positions = 7
	supervisors = "the Sheriff"
	selection_color = "#00ffff"
	minimal_player_age = 7
	exp_requirements = 300

	outfit = /datum/outfit/job/hound_vtr
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS
	minimum_vamp_rank = VAMP_RANK_NEONATE
	mind_traits = list(TRAIT_DONUT_LOVER)

	display_order = JOB_DISPLAY_ORDER_HOUND_VTR

	bounty_types = CIV_JOB_SEC
	known_contacts = list("Prince", "Keeper of Elysium", "Sheriff")

	v_duty = "You're a Hound, one of the Sheriff's attack dogs and a member of the Invictus. Help the Sheriff enforce the Seneschal's orders. Ensure that the Traditions are kept. Protect the Invictus and its leadership."

/datum/outfit/job/hound_vtr
	name = "Hound"
	jobtype = /datum/job/vamp/vtr/hound_vtr

	ears = /obj/item/p25radio
	id = /obj/item/card/id/invictus
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench/armored
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/invictus
	backpack_contents = list(/obj/item/vampire_stake=1, /obj/item/vamp/creditcard=1, /obj/item/vamp/keys/hound=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag


/datum/outfit/job/hound/pre_equip(mob/living/carbon/human/H)
	..()

/obj/effect/landmark/start/vtr/hound_vtr
	name = "Hound"
	icon_state = "Hound"
