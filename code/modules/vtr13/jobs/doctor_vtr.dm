/datum/job/vamp/vtr/doctor_vtr
	title = "Doctor"
	department_head = list("Clinic Director")
	faction = "Vampire"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#80D0F4"

	exp_type_department = EXP_TYPE_CLINIC


	outfit = /datum/outfit/job/doctor_vtr

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	allowed_species = list("Vampire", "Ghoul", "Human")
	display_order = JOB_DISPLAY_ORDER_DOCTOR_VTR
	bounty_types = CIV_JOB_MED

	v_duty = "Help your fellow kindred in all matters medicine related. Sell blood. Keep your human colleagues ignorant."
	duty = "Collect blood by helping mortals at the Clinic."
	experience_addition = 15
	allowed_bloodlines =  list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")
	known_contacts = list("Clinic Director")
	alt_titles = list(
		"Medical Student",
		"Intern",
		"Nurse",
		"Resident",
		"General Practitioner",
		"Surgeon",
		"Physician",
		"Paramedic",
		"EMT",
	)

/datum/outfit/job/doctor_vtr
	name = "Doctor"
	jobtype = /datum/job/vamp/vtr/doctor_vtr

	ears = /obj/item/p25radio
	id = /obj/item/card/id/clinic
	uniform = /obj/item/clothing/under/vampire/nurse
	shoes = /obj/item/clothing/shoes/vampire/white
	suit =  /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/latex
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/doctor_vtr
	backpack_contents = list(/obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard/doctor=1, /obj/item/storage/firstaid/medical=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	skillchips = list(/obj/item/skillchip/quickcarry)

/obj/effect/landmark/start/vtr/doctor_vtr
	name = "Doctor"
	icon_state = "Doctor"
