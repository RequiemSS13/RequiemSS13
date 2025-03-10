/datum/job/vamp/vtr/courtier
	title = "Courtier"
	department_head = list("Seneschal")
	faction = "Vampire"
	total_positions = 20
	spawn_positions = 20
	supervisors = " the Senechal, the Sheriff, and the Keeper of Elysium"
	selection_color = "#00ffff"

	outfit = /datum/outfit/job/courtier

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_COURTIER

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS

	allowed_species = list("Vampire", "Ghoul")
	minimal_generation = 13

	duty = "You're a ghoul sworn to a member of the Invictus, or to the covenant as a whole. Help out the Invictus with whatever they need. Make sure your actions reflect well on them. Try not to run out of vitae."
	v_duty = "You're a minor functionary or hanger-on in the Invictus. Help the covenant to improve your social status. Try and curry favor with your elders. Lick boots until you get to wear them."
	experience_addition = 10
	minimal_masquerade = 0
	my_contact_is_important = FALSE

/datum/outfit/job/courtier/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes
	else
		uniform = /obj/item/clothing/under/vampire/emo
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
		else
			shoes = /obj/item/clothing/shoes/vampire/heels

/datum/outfit/job/courtier
	name = "Courtier"
	jobtype = /datum/job/vamp/vtr/courtier
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	id = /obj/item/cockclock
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/flashlight
	l_hand = /obj/item/vamp/keys/invictus
	backpack_contents = list(/obj/item/passport=1, /obj/item/vamp/creditcard=1, /obj/item/clothing/mask/vampire/balaclava =1, /obj/item/gun/ballistic/automatic/vampire/beretta=2,/obj/item/ammo_box/magazine/semi9mm=2, /obj/item/melee/vampirearms/knife)

/obj/effect/landmark/start/vtr/courtier
	name = "Courtier"
	icon_state = "Hound"
