/datum/job/vamp/vtr/taxi_vtr
	title = "Taxi Driver"
	department_head = list("Justicar")
	faction = "Vampire"
	total_positions = 3
	spawn_positions = 3
	supervisors = " the Traditions"
	selection_color = "#e3e3e3"

	outfit = /datum/outfit/job/taxi_vtr

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_TAXI_VTR
	
	exp_type_department = EXP_TYPE_SERVICES

	allowed_species = list("Vampire", "Ghoul", "Human")

	v_duty = "Drive people in the city."
	duty = "Drive people in the city."

	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")

/datum/job/vamp/vtr/taxi_vtr/after_spawn(mob/living/H, mob/M, latejoin = FALSE)
	..()
	H.taxist = TRUE

/datum/outfit/job/taxi_vtr
	name = "Taxi Driver"
	jobtype = /datum/job/vamp/vtr/taxi_vtr

	id = /obj/item/cockclock
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/taxi_vtr
	backpack_contents = list(/obj/item/flashlight=1, /obj/item/vamp/creditcard=1, /obj/item/melee/vampirearms/tire=1)

/datum/outfit/job/taxi_vtr/pre_equip(mob/living/carbon/human/H)
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
		if(H.gender == MALE)
			shoes = /obj/item/clothing/shoes/vampire
			uniform = /obj/item/clothing/under/vampire/sport
		else
			shoes = /obj/item/clothing/shoes/vampire/heels
			uniform = /obj/item/clothing/under/vampire/red

/obj/effect/landmark/start/vtr/taxi_vtr
	name = "Taxi Driver"
