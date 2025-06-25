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

/datum/job/vamp/vtr/taxi_vtr/after_spawn(mob/living/H, mob/M, latejoin = FALSE)
	..()
	H.taxist = TRUE

/datum/outfit/job/taxi_vtr
	name = "Taxi Driver"
	jobtype = /datum/job/vamp/vtr/taxi_vtr
	uniform = /obj/item/clothing/under/vampire/sport
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/melee/vampirearms/tire=1, /obj/item/vamp/keys/taxi_vtr=1)

/obj/effect/landmark/start/vtr/taxi_vtr
	name = "Taxi Driver"
