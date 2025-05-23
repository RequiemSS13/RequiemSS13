/datum/job/vamp/vtr/bartender_vtr
	title = "Bartender"
	department_head = list("Keeper of Elysium")
	faction = "Vampire"
	total_positions = 4
	spawn_positions = 4
	supervisors = "the Keeper of Elysium"
	selection_color = "#00ffff"

	outfit = /datum/outfit/job/bartender_vtr

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	exp_type_department = EXP_TYPE_INVICTUS
	display_order = JOB_DISPLAY_ORDER_BARTENDER_VTR

	allowed_species = list("Vampire", "Ghoul", "Human")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

	v_duty = "You're a bartender at Elysium. Pour drinks for the Kine. Help the Keeper keep the blood flowing. Play something good on the jukebox."
	duty = "You're a bartender at the local nightclub. Pour drinks for working stiffs. Help out your boss if they ask. Don't go into the VIP area upstairs. Don't ask too many questions. Play something good on the jukebox."
	my_contact_is_important = TRUE
	known_contacts = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

/datum/outfit/job/bartender_vtr
	name = "Bartender"
	jobtype = /datum/job/vamp/vtr/bartender_vtr

	id = /obj/item/card/id/bartender_vtr
	uniform = /obj/item/clothing/under/vampire/emo
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/bartender_vtr
	r_pocket = /obj/item/cockclock
	backpack_contents = list(/obj/item/vamp/keys/bartender_vtr=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

/datum/outfit/job/bartender_vtr/pre_equip(mob/living/carbon/human/H)
	..()

/obj/effect/landmark/start/vtr/bartender_vtr
	name = "Bartender"
