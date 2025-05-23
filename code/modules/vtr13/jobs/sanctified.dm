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

	allowed_species = list("Vampire", "Ghoul")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")
	duty = "You're a ghoul belonging to one of the Sanctified, or to the Lancea et Sanctum itself. Help the Sanctified with their work. Dispose of corpses in the crematorium. Find salvation in the blood."
	v_duty = "You're one of the Sacntified, the clergy of the Lancea et Sanctum. Bear up the Lance and keep the Chapel. Keep the kine faithful. Advise your fellow Kindred on matters of faith and morality. Discretely dispose of any unfortunate lapses in judgement."
	known_contacts = list("Seneschal", "Keeper of Elysium", "Sheriff")
	my_contact_is_important = TRUE

/datum/outfit/job/sanctified
	name = "Sanctified"
	jobtype = /datum/job/vamp/vtr/sanctified

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/sanctified
	l_pocket = /obj/item/vamp/phone/sanctified
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/sanctified
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/vamp/creditcard=1)

/datum/outfit/job/sanctified/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes

/obj/effect/landmark/start/vtr/sanctified
	name = "Sanctified"
	icon_state = "Clerk"
