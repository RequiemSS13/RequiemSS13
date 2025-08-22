/datum/job/vamp/vtr/host
	title = "Host"
	department_head = list("Keeper of Elysium")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Keeper of Elysium"
	selection_color = "#00ffff"

	outfit = /datum/outfit/job/host

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	exp_type_department = EXP_TYPE_INVICTUS
	display_order = JOB_DISPLAY_ORDER_HOST

	minimum_vamp_rank = VAMP_RANK_NEONATE

	endorsement_required = TRUE
	is_deputy = TRUE

	allowed_species = list("Vampire")
	v_duty = "You're a Host at Elysium, an extension of the Keeper's Will. Pour drinks and keep the blood flowing."

/datum/outfit/job/host
	name = "Host"
	jobtype = /datum/job/vamp/vtr/host
	ears = /obj/item/p25radio
	id = /obj/item/card/id/bartender_vtr
	uniform = /obj/item/clothing/under/vampire/emo
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/bartender_vtr
	backpack_contents = list(/obj/item/vamp/keys/keeper=1, /obj/item/vamp/creditcard=1)

/datum/outfit/job/host/pre_equip(mob/living/carbon/human/H)
	..()

/obj/effect/landmark/start/vtr/host
	name = "Host"
