/datum/job/vamp/vtr/clergy
	title = "Clergy"
	department_head = list("Bishop")
	faction = "Vampire"
	total_positions = 20
	spawn_positions = 20
	supervisors = " the Bishop"
	selection_color = "#cab866"

	outfit = /datum/outfit/job/clergy

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_CLERGY

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_LANCEA

	allowed_species = list("Human")

	minimal_generation = 13

	duty = "you are a human priest in a very human house of god, no evil - such as vampires or bad descriptions elge has not gotten to - could ever taint this place"
	minimal_masquerade = 0
	known_contacts = list("Seneschal", "Keeper of Elysium", "Sheriff")
	my_contact_is_important = TRUE

/datum/outfit/job/clergy
	name = "Clergy"
	jobtype = /datum/job/vamp/vtr/clergy

	uniform = /obj/item/clothing/under/vampire/graveyard
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/card/id/sanctified
	l_pocket = /obj/item/vamp/phone/sanctified
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/clergy
	back = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/passport=1, /obj/item/vamp/creditcard=1)

/datum/outfit/job/clergy/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes

/obj/effect/landmark/start/vtr/clergy
	name = "Clergy"
	icon_state = "Clerk"
