/obj/item/vamp/creditcard
	name = "debit card"
	desc = "Used to access bank money."
	icon = 'icons/wod13/items.dmi'
	icon_state = "card1"
	inhand_icon_state = "card1"
	lefthand_file = 'icons/wod13/lefthand.dmi'
	righthand_file = 'icons/wod13/righthand.dmi'
	item_flags = NOBLUDGEON
	flags_1 = HEAR_1
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/owner = ""
	var/datum/vtr_bank_account/account
	var/code
	var/balance = 0
	var/has_checked = FALSE

/obj/item/vamp/creditcard/police

/obj/item/vamp/creditcard/police_chief

/obj/item/vamp/creditcard/invictus
	icon_state = "card2"
	inhand_icon_state = "card2"

/obj/item/vamp/creditcard/doctor
	icon_state = "card2"
	inhand_icon_state = "card2"

/obj/item/vamp/creditcard/clinic_director
	icon_state = "card3"
	inhand_icon_state = "card3"

/obj/item/vamp/creditcard/head
	icon_state = "card2"
	inhand_icon_state = "card2"

/obj/item/vamp/creditcard/seneschal
	icon_state = "card3"
	inhand_icon_state = "card3"

/obj/item/vamp/creditcard/New(mob/user)
	..()
	if(!account || code == "")
		account = new /datum/vtr_bank_account()
	if(user)
		owner = user.ckey

	if(HAS_TRAIT(user, TRAIT_DESTITUTE))
		account.balance = rand(0, 100)
	else if(istype(src, /obj/item/vamp/creditcard/police))
		account.balance = rand(800, 1200)
	else if(istype(src, /obj/item/vamp/creditcard/police_chief))
		account.balance = rand(1000, 1500)
	else if(istype(src, /obj/item/vamp/creditcard/doctor))
		account.balance = rand(1600, 2600)
	else if(istype(src, /obj/item/vamp/creditcard/clinic_director))
		account.balance = rand(2500, 3500)
	else if(istype(src, /obj/item/vamp/creditcard/head))
		account.balance = rand(2000, 3000)
	else if(istype(src, /obj/item/vamp/creditcard/invictus))
		account.balance = rand(1500, 2500)
	else if(istype(src, /obj/item/vamp/creditcard/seneschal))
		account.balance = rand(9000, 11000)
	else
		account.balance = rand(600, 1000)

	if(HAS_TRAIT(user, TRAIT_WEALTHY))
		account.balance = round(account.balance * 1.5)