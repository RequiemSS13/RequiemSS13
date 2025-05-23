/datum/job/vamp/vtr/police_officer_vtr
	title = "Police Officer"
	department_head = list("Police Department")
	faction = "Vampire"
	total_positions = 5
	spawn_positions = 5
	supervisors = " the SFPD Chief and your Sergeant."
	selection_color = "#7e7e7e"

	outfit = /datum/outfit/job/police_officer_vtr

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_POLICE_VTR
	exp_type_department = EXP_TYPE_POLICE

	allowed_species = list("Ghoul", "Human")
	species_slots = list("Ghoul" = 1)

	duty = "Enforce the Law."
	my_contact_is_important = FALSE
	known_contacts = list("Police Chief")
	alt_titles = list(
		"Police Cadet",
		"Senior Police Officer",
	)

/datum/outfit/job/police_officer_vtr
	name = "Police Officer"
	jobtype = /datum/job/vamp/vtr/police_officer_vtr

	ears = /obj/item/p25radio/police
	uniform = /obj/item/clothing/under/vampire/police
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest/police
	belt = /obj/item/storage/belt/holster/detective/vampire/police
	gloves = /obj/item/cockclock
	id = /obj/item/card/id/police //sticking with wod13 version as it integrates with npc code
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/police_vtr
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/ammo_box/vampire/c9mm = 1, /obj/item/restraints/handcuffs = 1,/obj/item/melee/classic_baton/vampire = 1, /obj/item/storage/firstaid/ifak = 1, /obj/item/gun/energy/taser/twoshot = 1)

/datum/outfit/job/police_officer_vtr/post_equip(mob/living/carbon/human/H)
	..()
	H.ignores_warrant = TRUE

/obj/effect/landmark/start/vtr/police_officer_vtr
	name = "Police Officer"
