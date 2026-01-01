
/datum/job/vamp/vtr/citizen_vtr
	title = "Pedestrian"
	faction = "Vampire"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Economy"
	selection_color = "#e3e3e3"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/citizen_vtr
	paycheck = PAYCHECK_ASSISTANT // Get a job. Job reassignment changes your paycheck now. Get over it.
	paycheck_department = ACCOUNT_CIV

	display_order = JOB_DISPLAY_ORDER_CITIZEN_VTR

	exp_type_department = EXP_TYPE_SERVICES

	allowed_species = list("Vampire", "Ghoul", "Human")

	v_duty = "You're just an ordinary vampire trying to keep it together. Keep the Masquerade and try and stay out of trouble... or not."
	duty = "You're just an ordinary person, with something keeping you up through the night. Keep your head on a swivel and try to stay out of trouble... or not."
	minimal_masquerade = 0
	alt_titles = list(
		"Private Investigator",
		"Private Security",
		"Tourist",
		"Visitor",
		"Entertainer",
		"Entrepreneur",
		"Contractor",
		"Fixer",
		"Lawyer",
		"Attorney",
		"Paralegal",
	)

/datum/outfit/job/citizen_vtr
	name = "Pedestrian"
	id = /obj/item/card/id/generic
	jobtype = /datum/job/vamp/vtr/citizen_vtr
	l_pocket = /obj/item/vamp/phone
	uniform = /obj/item/clothing/under/vampire/emo
	shoes = /obj/item/clothing/shoes/vampire
	backpack_contents = list(/obj/item/travel_brochure=1, /obj/item/vamp/creditcard=1)


/obj/effect/landmark/start/vtr/citizen_vtr
	name = "Pedestrian"
	icon_state = "Assistant"
