/datum/job/vamp/vtr/sworn
	title = "Sworn"
	department_head = list("Voivode")
	faction = "Vampire"
	total_positions = 10
	spawn_positions = 10
	supervisors = "the Voivode"
	selection_color = "#df1ca4"

	outfit = /datum/outfit/job/sworn

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_SWORN

	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_ORDO

	allowed_species = list("Vampire", "Ghoul")
	allowed_bloodlines = list("Ventrue", "Daeva", "Mekhet", "Nosferatu", "Gangrel")
	known_contacts = list("Hierophant")

	duty = "You are a ghoul bound to one of the Ordo Dracul, or to the Ordo as a whole. Assist them in their research. Keep their secrets secure. Try not to become a test subject."
	v_duty = "You are one of the Sworn of the Mysteries, a member of the Ordo Dracul. Help your Voivode conduct their research into the occult and paranormal. Observe and catalogue everything of note in the city. Master the coils and transcend the limitations of the vampiric condition."
	minimal_masquerade = 0
	experience_addition = 10


/datum/outfit/job/sworn
	name = "Sworn"
	jobtype = /datum/job/vamp/vtr/sworn
	id = /obj/item/cockclock
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/suit
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/sworn
	r_pocket = /obj/item/vamp/keys/sworn
	backpack_contents = list(/obj/item/passport=1, /obj/item/flashlight=1, /obj/item/vamp/creditcard=1)

/datum/outfit/job/sworn/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.clane)
		if(H.gender == MALE)
			if(H.clane.male_clothes)
				uniform = H.clane.male_clothes
		else
			if(H.clane.female_clothes)
				uniform = H.clane.female_clothes

/obj/effect/landmark/start/vtr/sworn
	name = "Sworn"
