/datum/job/vamp/vtr/police_sergeant_vtr
	title = "Police Sergeant"
	department_head = list("Police Department")
	faction = "Vampire"
	total_positions = 2
	spawn_positions = 2
	supervisors = " the SFPD Chief"
	selection_color = "#7e7e7e"

	outfit = /datum/outfit/job/police_sergeant_vtr


	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_POLICE_SERGEANT_VTR
	exp_type_department = EXP_TYPE_POLICE

	allowed_species = list("Human")

	duty = "Enforce the law. Keep the officers in line. Follow what the Chief says."
	my_contact_is_important = FALSE
	known_contacts = list("Police Chief")

/datum/outfit/job/police_sergeant_vtr
	name = "Police Sergeant"
	jobtype = /datum/job/vamp/vtr/police_sergeant_vtr

	ears = /obj/item/p25radio/police/supervisor
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police/sergeant
	belt = /obj/item/storage/belt/holster/detective/vampire/officer
	gloves = /obj/item/cockclock
	id = /obj/item/card/id/police/sergeant //sticking with wod13 version as it integrates with npc code
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/sergeant_vtr
	backpack_contents = list(/obj/item/vamp/creditcard/police=1, /obj/item/ammo_box/vampire/c9mm = 1, /obj/item/restraints/handcuffs = 1,/obj/item/melee/classic_baton/vampire = 1, /obj/item/storage/firstaid/ifak = 1, /obj/item/gun/energy/taser/twoshot = 1)

/datum/outfit/job/police_sergeant_vtr/post_equip(mob/living/carbon/human/H)
	..()
	H.ignores_warrant = TRUE

/obj/effect/landmark/start/vtr/police_sergeant_vtr
	name = "Police Sergeant"