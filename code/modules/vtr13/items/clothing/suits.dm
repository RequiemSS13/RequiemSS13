/obj/item/clothing/suit/vampire/vtr
	icon = 'icons/vtr13/obj/clothing/suits.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'
	lefthand_file = 'icons/vtr13/obj/clothing/inhand_left/suit_left.dmi'
	righthand_file = 'icons/vtr13/obj/clothing/inhand_right/suit_right.dmi'

/obj/item/clothing/suit/vampire/vtr/nun
	name = "nun robe"
	desc = "Finally, an outfit nobody can sexualize."
	icon_state = "nun"
	inhand_icon_state = "nun"
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/suit/vampire/vtr/coat/leopard
	name = "leopard coat"
	desc = "This'll give PETA something to cry about."
	icon_state = "leopard_coat"

/obj/item/clothing/suit/vampire/vtr/greatcoat
	name = "greatcoat"
	desc = "A heavy greatcoat."
	icon_state = "gentlecoat"
	inhand_icon_state = "black_coat"

/obj/item/clothing/suit/vampire/vtr/det_trench
	name = "classic trenchcoat"
	desc = "A rugged brown trenchcoat for the less-than-modern investigator."
	icon_state = "detective"
	inhand_icon_state = "detective"

/obj/item/clothing/suit/vampire/vtr/det_trench_grey
	name = "grey trenchcoat"
	desc = "A long grey trenchcoat for the less-than-modern investigator."
	icon_state = "detective2"
	inhand_icon_state = "detective2"

/obj/item/clothing/suit/vampire/vtr/charcoalsuit
	name = "charcoal suit jacket"
	desc = "A charcoal suit jacket."
	icon_state = "suitjacket_charcoal"
	inhand_icon_state = "suit_black"

/obj/item/clothing/suit/vampire/vtr/navysuit
	name = "navy suit jacket"
	desc = "A navy suit jacket."
	icon_state = "suitjacket_navy"
	inhand_icon_state = "suit_navy"

/obj/item/clothing/suit/vampire/vtr/burgundysuit
	name = "burgundy suit jacket"
	desc = "A burgundy suit jacket."
	icon_state = "suitjacket_burgundy"
	inhand_icon_state = "suit_red"

/obj/item/clothing/suit/vampire/vtr/checkeredsuit
	name = "checkered suit jacket"
	desc = "A checkered suit jacket."
	icon_state = "suitjacket_checkered"
	inhand_icon_state = "suit_grey"

/obj/item/clothing/suit/vampire/vtr/tansuit
	name = "tan suit jacket"
	desc = "A tan suit jacket."
	icon_state = "suitjacket_tan"
	inhand_icon_state = "suit_orange"

//HOODIES
/obj/item/clothing/suit/hooded/hoodie
	name = "hoodie"
	desc = "A simple hoodie."
	icon_state = "hoodie"
	icon = 'icons/vtr13/obj/clothing/suits.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'
	body_parts_covered = CHEST | GROIN | ARMS
	cold_protection = CHEST | GROIN | ARMS
	hoodtype = /obj/item/clothing/head/hooded/hood_hood
	body_worn = TRUE

/obj/item/clothing/head/hooded/hood_hood
	name = "hoodie hood"
	desc = "A hoodies hoodie hood."
	icon_state = "hoodie_hood"
	icon = 'icons/vtr13/obj/clothing/suits.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'
	body_parts_covered = HEAD
	cold_protection = HEAD
	flags_inv = HIDEHAIR | HIDEEARS
	body_worn = TRUE

/obj/item/clothing/suit/hooded/hoodie/hoodie_pim
	name = "scene character hoodie"
	desc = "A hoodie of your favourite cartoon character-- you know, the green dog from the thing?"
	icon_state = "hoodie_zim"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/hood_pim

/obj/item/clothing/head/hooded/hood_hood/hood_pim
	name = "scene character hoodie hood"
	desc = "A hood of your favourite cartoon character-- you know, the green dog from the thing?"
	icon_state = "hoodie_zim_hood"

//TOGGLEABLE JACKETS & COATS
/obj/item/clothing/suit/toggle/vtr
	icon = 'icons/vtr13/obj/clothing/suits.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'
	lefthand_file = 'icons/vtr13/obj/clothing/inhand_left/suit_left.dmi'
	righthand_file = 'icons/vtr13/obj/clothing/inhand_right/suit_right.dmi'

/obj/item/clothing/suit/toggle/vtr/suitjacket
	togglename = "buttons"

/obj/item/clothing/suit/toggle/vtr/suitjacket/blue
	name = "blue suit jacket"
	desc = "A blue suit jacket."
	icon_state = "suitjacket_blue"
	inhand_icon_state = "suit_blue"

/obj/item/clothing/suit/toggle/vtr/suitjacket/purple
	name = "purple suit jacket"
	desc = "A purple suit jacket. Quite the fashion statement."
	icon_state = "suitjacket_purp"
	inhand_icon_state = "suit_purple"

/obj/item/clothing/suit/toggle/vtr/suitjacket/black
	name = "black suit jacket"
	desc = "A black suit jacket."
	icon_state = "suitjacket_black"
	inhand_icon_state = "suit_black"

//FLANNELS
//these use a different system from other toggles bc they have three different things you can toggle
/obj/item/clothing/suit/vampire/vtr/flannel
	name = "grey flannel shirt"
	desc = "A comfy, grey flannel shirt. Unleash your inner hipster."
	icon_state = "flannel"
	inhand_icon_state = "black_coat"
	var/rolled = 0
	var/tucked = 0
	var/buttoned = 0

/obj/item/clothing/suit/vampire/vtr/flannel/verb/roll_sleeves()
	set name = "Roll Sleeves"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living))
		return
	if(usr.stat)
		return

	if(rolled == 0)
		rolled = 1
		body_parts_covered &= ~(ARMS)
		to_chat(usr, "<span class='notice'>You roll up the sleeves of your [src].</span>")
	else
		rolled = 0
		body_parts_covered = initial(body_parts_covered)
		to_chat(usr, "<span class='notice'>You roll down the sleeves of your [src].</span>")
	update_icon_state()
	usr.update_inv_wear_suit()

/obj/item/clothing/suit/vampire/vtr/flannel/verb/tuck()
	set name = "Toggle Shirt Tucking"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)||usr.stat)
		return

	if(tucked == 0)
		tucked = 1
		to_chat(usr, "<span class='notice'>You tuck in your your [src].</span>")
	else
		tucked = 0
		to_chat(usr, "<span class='notice'>You untuck your [src].</span>")
	update_icon_state()
	usr.update_inv_wear_suit()

/obj/item/clothing/suit/vampire/vtr/flannel/verb/button()
	set name = "Toggle Shirt Buttons"
	set category = "Object"
	set src in usr
	if(!istype(usr, /mob/living)||usr.stat)
		return

	if(buttoned == 0)
		buttoned = 1
		to_chat(usr, "<span class='notice'>You button your [src].</span>")
	else
		buttoned = 0
		to_chat(usr, "<span class='notice'>You unbutton your [src].</span>")
	update_icon_state()
	usr.update_inv_wear_suit()

/obj/item/clothing/suit/vampire/vtr/flannel/update_icon_state()
	icon_state = initial(icon_state)
	if(rolled)
		icon_state += "r"
	if(tucked)
		icon_state += "t"
	if(buttoned)
		icon_state += "b"

/obj/item/clothing/suit/vampire/vtr/flannel/red
	name = "red flannel shirt"
	desc = "A comfy, red flannel shirt.  Unleash your inner hipster."
	icon_state = "flannel_red"

/obj/item/clothing/suit/vampire/vtr/flannel/aqua
	name = "aqua flannel shirt"
	desc = "A comfy, aqua flannel shirt.  Unleash your inner hipster."
	icon_state = "flannel_aqua"

/obj/item/clothing/suit/vampire/vtr/flannel/brown
	name = "brown flannel shirt"
	desc = "A comfy, brown flannel shirt.  Unleash your inner hipster."
	icon_state = "flannel_brown"

/obj/item/clothing/suit/vampire/vtr/letterman_c
	name = "letterman jacket, UCLA"
	desc = "A blue and gold UCLA varsity jacket."
	icon_state = "letterman_c"
