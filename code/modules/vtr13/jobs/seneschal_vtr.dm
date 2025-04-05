/datum/job/vamp/vtr/seneschal_vtr
	title = "Seneschal"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Justicar")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Prince (allegedly)"
	selection_color = "#006eff"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 180
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_CAMARILLIA

	outfit = /datum/outfit/job/seneschal_vtr

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS

	display_order = JOB_DISPLAY_ORDER_SENESCHAL_VTR

	minimal_generation = 10	//Uncomment when players get exp enough
	minimal_masquerade = 5
	allowed_species = list("Vampire")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

	my_contact_is_important = TRUE
	known_contacts = list(
		"Sheriff",
		"Keeper of Elysium",
		"Carthian Representative",
		"Bishop",
		"hierophant",
		"Voivode"
	)

	v_duty = "You are the Seneschal, the right hand of the Prince. Rule over the Invictus in his name. Work with the Sheriff to keep the Traditions secure. Work with the leaders of the other covenants to keep the masses in line."
	experience_addition = 25

/datum/outfit/job/seneschal_vtr
	name = "Seneschal"
	jobtype = /datum/job/vamp/vtr/seneschal_vtr

	ears = /obj/item/p25radio
	id = /obj/item/card/id/seneschal_vtr
	glasses = /obj/item/clothing/glasses/vampire/sun
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform =  /obj/item/clothing/under/vampire/prince
	suit = /obj/item/clothing/suit/vampire/trench/alt
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/seneschal_vtr
	r_pocket = /obj/item/vamp/keys/seneschal_vtr
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/phone_book=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/masquerade_contract=1, /obj/item/vamp/creditcard/prince=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/seneschal_vtr/pre_equip(mob/living/carbon/human/H)
	..()
	H.ignores_warrant = TRUE

/obj/effect/landmark/start/vtr/seneschal_vtr
	name = "Seneschal"
	icon_state = "Prince"
