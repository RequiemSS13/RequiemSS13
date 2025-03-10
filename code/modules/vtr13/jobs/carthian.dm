
/datum/job/vamp/vtr/carthian
	title = "Carthian"
	department_head = list("Carthian Representative")
	faction = "Vampire"
	total_positions = 20
	spawn_positions = 20
	supervisors = "the Carthian Representative"
	selection_color = "#ff1904"

	outfit = /datum/outfit/job/carthian

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_CAR

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_CARTHIAN

	display_order = JOB_DISPLAY_ORDER_CARTHIAN
	bounty_types = CIV_JOB_RANDOM
	known_contacts = list("Carthian Representative")
	allowed_species = list("Vampire", "Ghoul")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

	duty = "You're a ghoul attached to a member of the Carthian Movement, or to the Movement itself. Protect the interests of the Carthian movement. Get peoples' cargo out of the van at the warehouse. Grumble about not being allowed to vote."
	v_duty = "You're a card-carrying member of the Carthian Movement. Vote on legislation. Keep the contraband flowing. Protect your fellow Carthians from the abuses of their elders."
	minimal_masquerade = 2
	experience_addition = 15

/datum/outfit/job/carthian
	name = "Carthian"
	jobtype = /datum/job/vamp/vtr/carthian

	id = /obj/item/card/id/carthian
	uniform = /obj/item/clothing/under/vampire/supply
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/vamp/phone/carthian
	r_pocket = /obj/item/vamp/keys/carthian
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	backpack_contents = list(/obj/item/passport=1, /obj/item/phone_book=1, /obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

/datum/outfit/job/carthian/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes

/obj/effect/landmark/start/vtr/carthian
	name = "Carthian"
	icon_state = "Supply Technician"
