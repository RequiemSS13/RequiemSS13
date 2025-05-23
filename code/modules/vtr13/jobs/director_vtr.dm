/datum/job/vamp/vtr/director_vtr
	title = "Clinic Director"
	department_head = list("Seneschal")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#80D0F4"
	
	exp_type_department = EXP_TYPE_CLINIC

	outfit = /datum/outfit/job/director_vtr

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_MED

	allowed_species = list("Human")
	display_order = JOB_DISPLAY_ORDER_DIRECTOR_VTR
	bounty_types = CIV_JOB_MED

	duty = "Keep Saint John's clinic up and running. Collect blood by helping fellow citizens at the Clinic."
	experience_addition = 15

/datum/outfit/job/director_vtr
	name = "Clinic Director"
	jobtype = /datum/job/vamp/vtr/director_vtr

	ears = /obj/item/p25radio
	id = /obj/item/card/id/clinic/director
	uniform = /obj/item/clothing/under/vampire/nurse
	shoes = /obj/item/clothing/shoes/vampire/white
	suit =  /obj/item/clothing/suit/vampire/labcoat/director
	gloves = /obj/item/clothing/gloves/vampire/latex
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/director_vtr
	backpack_contents = list(/obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1, /obj/item/storage/firstaid/medical=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	skillchips = list(/obj/item/skillchip/quickcarry)

/obj/effect/landmark/start/vtr/director_vtr
	name = "Director"
	icon_state = "Doctor"
