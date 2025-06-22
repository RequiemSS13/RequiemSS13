/datum/job/vamp/vtr/doctor_vtr
	title = "Doctor"
	department_head = list("Clinic Director")
	faction = "Vampire"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Clinic Director"
	selection_color = "#80D0F4"

	exp_type_department = EXP_TYPE_CLINIC


	outfit = /datum/outfit/job/doctor_vtr

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	allowed_species = list("Vampire", "Ghoul", "Human")
	display_order = JOB_DISPLAY_ORDER_DOCTOR_VTR
	bounty_types = CIV_JOB_MED

	v_duty = "Help your fellow kindred in all matters medicine related. Sell blood. Keep your human colleagues ignorant."
	duty = "First, do no harm. Heal the sick and the injured. Try and keep your blood supplies well-stocked; you go through it shockingly fast."
	experience_addition = 15

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
	backpack_contents = list(/obj/item/vamp/creditcard/doctor=1, /obj/item/storage/firstaid/medical=1, /obj/item/vamp/keys/doctor_vtr=1)

/obj/effect/landmark/start/vtr/doctor_vtr
	name = "Doctor"
	icon_state = "Doctor"
