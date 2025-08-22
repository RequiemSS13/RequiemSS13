/datum/job/vamp/vtr/claw
	title = "Claw"
	department_head = list("Voivode")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Voivode"
	selection_color = "#df1ca4"

	outfit = /datum/outfit/job/claw

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_CLAW

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_ORDO
	minimum_vamp_rank = VAMP_RANK_NEONATE

	allowed_species = list("Vampire")
	known_contacts = list("Voivode")

	endorsement_required = TRUE
	is_deputy = TRUE

	v_duty = "You are the talon of the Voivode, their prized researcher... Or test subject. Help your covenant conduct their research into the occult and paranormal. Observe and catalogue everything of note in the city. Master the coils and transcend the limitations of the vampiric condition."


/datum/outfit/job/claw
	name = "Claw"
	jobtype = /datum/job/vamp/vtr/claw
	id = /obj/item/card/id/claw
	uniform = /obj/item/clothing/under/vampire/emo
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/sworn
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/vamp/keys/voivode_vtr=1)

/obj/effect/landmark/start/vtr/claw
	name = "Claw"
