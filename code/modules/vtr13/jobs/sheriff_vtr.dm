/datum/job/vamp/vtr/sheriff_vtr
	title = "Sheriff"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Seneschal")
	head_announce = list(RADIO_CHANNEL_SECURITY)
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Seneschal"
	selection_color = "#006eff"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 300

	outfit = /datum/outfit/job/sheriff_vtr

	mind_traits = list(TRAIT_DONUT_LOVER)

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	endorsement_required = TRUE

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS

	display_order = JOB_DISPLAY_ORDER_SHERIFF_VTR
	bounty_types = CIV_JOB_SEC

	minimum_vamp_rank = VAMP_RANK_ANCILLAE
	allowed_species = list("Vampire")


	my_contact_is_important = TRUE
	known_contacts = list("Seneschal","Keeper of Elysium", "Page", "Carthian Representative", "Bishop", "Hierophant", "Voivode")

	v_duty = "Protect the Seneschal and the Masquerade. You are their sword."

/datum/outfit/job/sheriff_vtr
	name = "Sheriff"
	jobtype = /datum/job/vamp/vtr/sheriff_vtr

	ears = /obj/item/p25radio
	id = /obj/item/card/id/sheriff_vtr
	uniform = /obj/item/clothing/under/vampire/sheriff
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest
	gloves = /obj/item/clothing/gloves/vampire/leather
	l_pocket = /obj/item/vamp/phone/sheriff_vtr
	backpack_contents = list(/obj/item/vampire_stake=1, /obj/item/vamp/creditcard/head=1, /obj/item/vamp/keys/sheriff_vtr=1)

/datum/outfit/job/sheriff_vtr/pre_equip(mob/living/carbon/human/H)
	..()

/obj/effect/landmark/start/vtr/sheriff_vtr
	name = "Sheriff"
	icon_state = "Sheriff"
