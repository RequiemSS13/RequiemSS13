/datum/job/vamp/vtr/representative
	title = "Carthian Representative"
	department_head = list("The People")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "Democracy - and the Seneschal (for now)."
	selection_color = "#85251d"
	outfit = /datum/outfit/job/representative

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_CARTHIAN

	endorsement_required = TRUE

	display_order = JOB_DISPLAY_ORDER_REPRESENTATIVE
	bounty_types = CIV_JOB_RANDOM
	
	my_contact_is_important = TRUE
	minimum_vamp_rank = VAMP_RANK_NEONATE

	v_duty = "You're the (hopefully) duly elected representative of the local Carthian movement. Make sure the Invictus respect your interests and the will of the assembly. Keep the Carthian supply network flowing and money coming in. Push your vision of the future out onto the city."
	allowed_species = list("Vampire")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")
	known_contacts = list("Seneschal", "Keeper of Elysium", "Sheriff")

/datum/outfit/job/representative
	name = "Carthian Representative"
	jobtype = /datum/job/vamp/vtr/representative

	id = /obj/item/card/id/representative
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/brown
	glasses = /obj/item/clothing/glasses/vampire/sun
	l_pocket = /obj/item/vamp/phone/representative
	r_pocket = /obj/item/vamp/keys/representative
	backpack_contents = list(/obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/rich=1)

/datum/outfit/job/representative/pre_equip(mob/living/carbon/human/H)
	..()

/obj/effect/landmark/start/vtr/representative
	name = "Carthian Representative"
	icon_state = "Supply Technician"
