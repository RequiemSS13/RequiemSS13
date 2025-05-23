
/datum/job/vamp/vtr/bishop
	title = "Bishop"
	department_head = list("God")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Testament of Longinus and your own guilty conscience."
	selection_color = "#fff700"

	outfit = /datum/outfit/job/bishop

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_LANCEA
	
	endorsement_required = TRUE

	display_order = JOB_DISPLAY_ORDER_BISHOP

	minimum_vamp_rank = VAMP_RANK_ANCILLAE

	allowed_species = list("Vampire")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

	v_duty = "You are the Sanctified Bishop, leader of the local chapter of the Lancea et Sanctum. Bear up the Lance and keep the Chapel. Direct your Sanctified to scour the wicked and protect the good. Ensure the Kindred do not fall into monstrosity."

	known_contacts = list("Seneschal", "Keeper of Elysium", "Sheriff")
	my_contact_is_important = TRUE

/datum/outfit/job/bishop
	name = "Bishop"
	jobtype = /datum/job/vamp/vtr/bishop

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/hunter
	l_pocket = /obj/item/vamp/phone/bishop
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/bishop
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/vamp/creditcard/head=1)

///datum/outfit/job/bishop/pre_equip(mob/living/carbon/human/H)
//	..()
//	H.mind.holy_role = HOLY_ROLE_PRIEST
//	H.resistant_to_disciplines = TRUE
//	to_chat(H, "<span class='alertsyndie'>Your faith in God is made of iron. None could shake it, and even in the darkest moments it holds you up.</span>")

/obj/effect/landmark/start/vtr/bishop
	name = "Bishop"
	icon_state = "Clerk"
