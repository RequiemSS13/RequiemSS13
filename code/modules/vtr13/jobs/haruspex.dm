/datum/job/vamp/vtr/haruspex
	title = "Haruspex"
	department_head = list("Hierophant")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Hierophant"
	selection_color = "#00ff15"

	outfit = /datum/outfit/job/haruspex

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	
	exp_type = EXP_TYPE_CRONE
	exp_type_department = EXP_TYPE_CRONE

	minimum_vamp_rank = VAMP_RANK_NEONATE

	display_order = JOB_DISPLAY_ORDER_HARUSPEX

	endorsement_required = TRUE
	is_deputy = TRUE

	v_duty = "You're a respected member of the Circle of the Crone, granted power to lead by the Hierophant. Assist the Hierophant in carrying out any rituals. Manage the Queen Lilith. Spread wonder and terror at the monster you have become."

	allowed_species = list("Vampire")
	known_contacts = list("Hierophant")

/datum/outfit/job/haruspex
	name = "Haruspex"
	jobtype = /datum/job/vamp/vtr/haruspex

	id = /obj/item/card/id/haruspex
	uniform = /obj/item/clothing/under/vampire/emo
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/acolyte
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/vamp/keys/hierophant=1)

/obj/effect/landmark/start/vtr/haruspex
	name = "Haruspex"
	icon_state = "Archivist"
