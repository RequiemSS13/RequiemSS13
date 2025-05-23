/datum/job/vamp/vtr/acolyte
	title = "Acolyte"
	department_head = list("Hierophant")
	faction = "Vampire"
	total_positions = 20
	spawn_positions = 20
	supervisors = "the Hierophant"
	selection_color = "#00ff15"

	outfit = /datum/outfit/job/acolyte

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	
	exp_type = EXP_TYPE_CRONE
	exp_type_department = EXP_TYPE_CRONE

	display_order = JOB_DISPLAY_ORDER_ACOLYTE

	duty = "You're a ghoul sworn to one of the Crones, or to the Circle itself. Help them with their rituals. Manage the Queen Lilith. Try not to get eaten."
	v_duty = "You're a member of the Circle of the Crone. Assist the Hierophant in carrying out any rituals. Manage the Queen Lilith. Spread wonder and terror at the monster you have become."

	allowed_species = list("Vampire", "Ghoul")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")
	known_contacts = list("Hierophant")

/datum/outfit/job/acolyte
	name = "Acolyte"
	jobtype = /datum/job/vamp/vtr/acolyte

	id = /obj/item/card/id/acolyte
	glasses = /obj/item/clothing/glasses/vampire/perception
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform = /obj/item/clothing/under/vampire/archivist
	r_pocket = /obj/item/vamp/keys/acolyte
	l_pocket = /obj/item/vamp/phone/acolyte
	backpack_contents = list(/obj/item/cockclock=1, /obj/item/flashlight=1, /obj/item/arcane_tome=1, /obj/item/vamp/creditcard=1, /obj/item/melee/vampirearms/katana/kosa=1)

/datum/outfit/job/acolyte/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes

/obj/effect/landmark/start/vtr/acolyte
	name = "Acolyte"
	icon_state = "Archivist"
