/datum/job/vamp/vtr/judge
	title = "Judge"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Seneschal")
	head_announce = list(RADIO_CHANNEL_SUPPLY, RADIO_CHANNEL_SERVICE)
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "The Seneschal"
	selection_color = "#00ffff"
	req_admin_notify = 1

	outfit = /datum/outfit/job/judge

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_INVICTUS
	minimum_vamp_rank = VAMP_RANK_ANCILLAE
	display_order = JOB_DISPLAY_ORDER_JUDGE

	my_contact_is_important = TRUE

	endorsement_required = TRUE
	is_deputy = TRUE

	allowed_species = list("Vampire")
	known_contacts = list("Seneschal", "Page", "Keeper of Elysium", "Carthian Representative", "Bishop", "Hierophant", "Voivode")

	v_duty = "You are the right hand of the Prince's right hand - the Seneschal. You have been granted the right to hold vampire court in the Seneschal's stead, and conduct the duties that he would."


/datum/outfit/job/judge
	name = "Judge"
	jobtype = /datum/job/vamp/vtr/judge

	id = /obj/item/card/id/judge
	uniform = /obj/item/clothing/under/vampire/clerk
	shoes = /obj/item/clothing/shoes/vampire/brown
	l_pocket = /obj/item/vamp/phone/page
	backpack_contents = list(/obj/item/phone_book=1, /obj/item/vamp/creditcard/invictus=1, /obj/item/vamp/keys/seneschal_vtr=1)

/obj/effect/landmark/start/vtr/judge
	name = "Judge"
	icon_state = "Clerk"
