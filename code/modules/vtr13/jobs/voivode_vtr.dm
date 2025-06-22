/datum/job/vamp/vtr/voivode_vtr
	title = "Voivode"
	department_head = list("Seneschal")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Brides of Dracula, probably"
	selection_color = "#790656"

	outfit = /datum/outfit/job/voivode_vtr

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_VOIVODE_VTR

	endorsement_required = TRUE

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_ORDO

	allowed_species = list("Vampire")

	minimum_vamp_rank = VAMP_RANK_ANCILLAE

	v_duty = "You are the Voivode, leader of the local Ordo Dracul. Conduct research into the occult and arcane. Manage your research library, its librarian, and your Sworn. Ensure that the Seneschal does not interfere with your work."

	my_contact_is_important = TRUE
	known_contacts = list("Seneschal", "Keeper of Elysium", "Sheriff")



/datum/outfit/job/voivode_vtr
	name = "Voivode"
	jobtype = /datum/job/vamp/vtr/voivode_vtr
	id = /obj/item/card/id/voivode_vtr
	uniform = /obj/item/clothing/under/vampire/voivode
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/vamp/creditcard/head=1, /obj/item/vamp/keys/voivode_vtr=1)

/obj/effect/landmark/start/vtr/voivode_vtr
	name = "Voivode"
