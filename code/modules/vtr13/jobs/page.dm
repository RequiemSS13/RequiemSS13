/datum/job/vamp/vtr/page
	title = "Page"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Seneschal")
	head_announce = list(RADIO_CHANNEL_SUPPLY, RADIO_CHANNEL_SERVICE)
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Seneschal"
	selection_color = "#00ffff"
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 180
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS

	outfit = /datum/outfit/job/page

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS
	minimum_vamp_rank = VAMP_RANK_NEONATE
	display_order = JOB_DISPLAY_ORDER_PAGE

	my_contact_is_important = TRUE
	allowed_species = list("Vampire")
	known_contacts = list("Seneschal","Keeper of Elysium", "Carthian Representative", "Bishop", "Hierophant", "Voivode")

	v_duty = "You're a page for the Invictus leadership; a prestigious and important but also basically powerless position. Field phone calls for the Seneschal and the Sherrif. Try and parlay your access into actual political clout."

	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

/datum/outfit/job/page
	name = "Page"
	jobtype = /datum/job/vamp/vtr/page

	ears = /obj/item/p25radio
	id = /obj/item/card/id/page
	uniform = /obj/item/clothing/under/vampire/clerk
	shoes = /obj/item/clothing/shoes/vampire/brown
	head = /obj/item/clothing/head/pagecap
	l_pocket = /obj/item/vamp/phone/page
	r_pocket = /obj/item/vamp/keys/page
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/seneschal=1)

/datum/outfit/job/page/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/clerk/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/vtr/page
	name = "Page"
	icon_state = "Clerk"
