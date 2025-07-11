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

	duty = "You're a ghoul sworn to a member of the Invictus, or to the covenant as a whole. Help out the Invictus with whatever they need. Make sure your actions reflect well on them. Try not to run out of vitae."
	v_duty = "You're a minor functionary or hanger-on in the Invictus. Help the covenant to improve your social status. Try and curry favor with your elders. Lick boots until you get to wear them."
	experience_addition = 10
	my_contact_is_important = FALSE

/datum/outfit/job/courtier
	name = "Courtier"
	jobtype = /datum/job/vamp/vtr/courtier
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	l_pocket = /obj/item/vamp/phone
	id = /obj/item/card/id/page
	backpack_contents = list(/obj/item/vamp/creditcard=1, /obj/item/vamp/keys/courtier=1)

/obj/effect/landmark/start/vtr/courtier
	name = "Courtier"
	icon_state = "Hound"
