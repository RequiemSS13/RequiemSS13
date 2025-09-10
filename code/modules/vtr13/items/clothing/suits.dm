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

/obj/item/clothing/suit/vampire/vtr/shawl_white
	name = "white shawl"
	desc = "A long silk shawl, to be draped over the arms."
	icon_state = "shawl_white"

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

/obj/item/clothing/suit/toggle/vtr/leather
	name = "black leather jacket"
	desc = "True clothing for any punk."
	icon_state = "leather_jacket"

/obj/item/clothing/suit/toggle/vtr/leather_brown
	name = "brown leather jacket"
	desc = "True clothing for any biker."
	icon_state = "brown_jacket"

/obj/item/clothing/suit/toggle/vtr/leather_sleeveless
	name = "black leather vest"
	desc = "True clothing for any punk."
	icon_state = "leather_jacket_sleeveless"

/obj/item/clothing/suit/toggle/vtr/leather_brown_sleeveless
	name = "brown leather vest"
	desc = "True clothing for any biker."
	icon_state = "brown_jacket_sleeveless"

/obj/item/clothing/suit/toggle/vtr/hoodie_grey
	name = "grey zipper hoodie"
	desc = "A simple grey hoodie."
	icon_state = "grey_hoodie"

/obj/item/clothing/suit/toggle/vtr/hoodie_black
	name = "black zipper hoodie"
	desc = "A simple black hoodie."
	icon_state = "black_hoodie"

/obj/item/clothing/suit/toggle/vtr/hoodie_red
	name = "red zipper hoodie"
	desc = "A simple red hoodie."
	icon_state = "red_hoodie"

/obj/item/clothing/suit/toggle/vtr/hoodie_blue
	name = "blue zipper hoodie"
	desc = "A simple blue hoodie."
	icon_state = "blue_hoodie"

/obj/item/clothing/suit/toggle/vtr/hoodie_orange
	name = "orange zipper hoodie"
	desc = "A simple orange hoodie."
	icon_state = "orange_hoodie"

/obj/item/clothing/suit/toggle/vtr/hoodie_pink
	name = "pink zipper hoodie"
	desc = "A simple pink hoodie."
	icon_state = "pink_hoodie"

/obj/item/clothing/suit/toggle/vtr/trackjacket
	name = "black track jacket"
	desc = "A light, breathable athletic jacket."
	icon_state = "trackjacket"

/obj/item/clothing/suit/toggle/vtr/trackjacketblue
	name = "blue track jacket"
	desc = "A light, breathable athletic jacket."
	icon_state = "trackjacketblue"

/obj/item/clothing/suit/toggle/vtr/trackjacketgreen
	name = "green track jacket"
	desc = "A light, breathable athletic jacket."
	icon_state = "trackjacketgreen"

/obj/item/clothing/suit/toggle/vtr/trackjacketred
	name = "red track jacket"
	desc = "A light, breathable athletic jacket."
	icon_state = "trackjacketred"

/obj/item/clothing/suit/toggle/vtr/trackjacketwhite
	name = "white track jacket"
	desc = "A light, breathable athletic jacket."
	icon_state = "trackjacketwhite"

/obj/item/clothing/suit/toggle/vtr/yellow_dep_jacket
	name = "yellow fur-lined jacket"
	desc = "A warm wool-lined jacket."
	icon_state = "engi_dep_jacket"

/obj/item/clothing/suit/toggle/vtr/red_dep_jacket
	name = "red fur-lined jacket"
	desc = "A warm wool-lined jacket."
	icon_state = "sec_dep_jacket"

/obj/item/clothing/suit/toggle/vtr/white_dep_jacket
	name = "white fur-lined jacket"
	desc = "A warm wool-lined jacket."
	icon_state = "med_dep_jacket"

/obj/item/clothing/suit/toggle/vtr/brown_dep_jacket
	name = "brown fur-lined jacket"
	desc = "A warm wool-lined jacket."
	icon_state = "supply_dep_jacket"

/obj/item/clothing/suit/toggle/vtr/grey_dep_jacket
	name = "grey fur-lined jacket"
	desc = "A warm wool-lined jacket."
	icon_state = "grey_dep_jacket"

/obj/item/clothing/suit/toggle/vtr/blue_dep_jacket
	name = "blue fur-lined jacket"
	desc = "A warm wool-lined jacket."
	icon_state = "blue_dep_jacket"

/obj/item/clothing/suit/toggle/vtr/bomber
	name = "bomber jacket"
	desc = "A classic leather and wool jacket popular in WW2."
	icon_state = "bomber"

/obj/item/clothing/suit/toggle/vtr/retro_bomber
	name = "asymmetical aviator jacket"
	desc = "A classic leather and wool jacket in the style of early aviators."
	icon_state = "retro_bomber"


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

//Letterman jackets

/obj/item/clothing/suit/vampire/vtr/letterman_c
	name = "letterman jacket, UCLA"
	desc = "A blue and gold UCLA varsity jacket."
	icon_state = "letterman_c"

/obj/item/clothing/suit/vampire/vtr/letterman_black
	name = "black letterman jacket"
	desc = "A letterman jacket in a moody black and white."
	icon_state = "varsity"

/obj/item/clothing/suit/vampire/vtr/letterman_purple
	name = "purple letterman jacket"
	desc = "A letterman jacket in a deep purple."
	icon_state = "varsity_purple"

//Military jacket

/obj/item/clothing/suit/vampire/vtr/military_white
	name = "white military jacket"
	desc = "A white canvas jacket styled after classic American military garb. Feels sturdy, yet comfortable."
	icon_state = "militaryjacket_white"

/obj/item/clothing/suit/vampire/vtr/military_tan
	name = "tan military jacket"
	desc = "A tan canvas jacket styled after classic American military garb. Feels sturdy, yet comfortable."
	icon_state = "militaryjacket_tan"

/obj/item/clothing/suit/vampire/vtr/military_navy
	name = "navy military jacket"
	desc = "A navy canvas jacket styled after classic American military garb. Feels sturdy, yet comfortable."
	icon_state = "militaryjacket_navy"

/obj/item/clothing/suit/vampire/vtr/military_grey
	name = "grey military jacket"
	desc = "A grey canvas jacket styled after classic American military garb. Feels sturdy, yet comfortable."
	icon_state = "militaryjacket_grey"

/obj/item/clothing/suit/vampire/vtr/military_black
	name = "black military jacket"
	desc = "A black canvas jacket styled after classic American military garb. Feels sturdy, yet comfortable."
	icon_state = "militaryjacket_black"


/obj/item/clothing/suit/hooded/hoodie/parka_yellow
	name = "yellow parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "yellowpark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_yellow

/obj/item/clothing/head/hooded/hood_hood/parka_yellow
	name = "yellow parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "yellowpark_hood"

/obj/item/clothing/suit/hooded/hoodie/parka_red
	name = "red parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "redpark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_red

/obj/item/clothing/head/hooded/hood_hood/parka_red
	name = "red parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "redpark_hood"

/obj/item/clothing/suit/hooded/hoodie/parka_purple
	name = "purple parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "purplepark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_purple

/obj/item/clothing/head/hooded/hood_hood/parka_purple
	name = "purple parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "purplepark_hood"

/obj/item/clothing/suit/hooded/hoodie/parka_green
	name = "green parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "greenpark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_green

/obj/item/clothing/head/hooded/hood_hood/parka_green
	name = "green parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "greenpark_hood"

/obj/item/clothing/suit/hooded/hoodie/parka_blue
	name = "blue parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "bluepark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_blue

/obj/item/clothing/head/hooded/hood_hood/parka_blue
	name = "blue parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "bluepark_hood"

/obj/item/clothing/suit/hooded/hoodie/parka_vintage
	name = "vintage parka"
	desc = "A heavy fur-lined winter coat, for all the snow in LA."
	icon_state = "vintagepark"
	hoodtype = /obj/item/clothing/head/hooded/hood_hood/parka_vintage

/obj/item/clothing/head/hooded/hood_hood/parka_vintage
	name = "vintage parka hood"
	desc = "A heavy fur-lined hood, for all the snow in LA."
	icon_state = "vintagepark_hood"

