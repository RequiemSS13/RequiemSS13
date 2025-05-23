/datum/job/vamp/vtr/librarian_vtr
	title = "Librarian"
	department_head = list("Voivode")
	faction = "Vampire"
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Voivode"
	selection_color = "#f580d2"

	outfit = /datum/outfit/job/librarian_vtr

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_LIBRARIAN_VTR

	exp_type_department = EXP_TYPE_SERVICES

	allowed_species = list("Human")
	known_contacts = list("Hierophant")
	duty = "You're a librarian at the local 24/7 research library. Help patrons with their queries. Keep the library tidy. Don't ask too many of your own questions."


/datum/outfit/job/librarian_vtr
	name = "Librarian"
	jobtype = /datum/job/vamp/vtr/sworn
	id = /obj/item/cockclock
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/librarian_vtr
	r_pocket = /obj/item/vamp/keys/librarian_vtr
	backpack_contents = list(/obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

/datum/outfit/job/librarian_vtr/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes

/obj/effect/landmark/start/vtr/librarian_vtr
	name = "Librarian"
