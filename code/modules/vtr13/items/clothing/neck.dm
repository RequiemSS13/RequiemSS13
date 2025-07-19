/obj/item/clothing/neck/vtr
	icon = 'icons/vtr13/obj/clothing/neck.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'

/obj/item/clothing/neck/vtr/tie
	name = "black tie"
	desc = "A silk necktie."
	icon_state = "blacktie"

/obj/item/clothing/neck/vtr/tie/blue
	name = "blue tie"
	icon_state = "bluetie"

/obj/item/clothing/neck/vtr/tie/blueclip
	name = "blue tie with clip"
	desc = "A silk necktie with a gold clip."
	icon_state = "bluecliptie"

/obj/item/clothing/neck/vtr/tie/bluelong
	name = "long blue tie"
	icon_state = "bluelongtie"

/obj/item/clothing/neck/vtr/tie/red
	name = "red tie"
	icon_state = "redtie"

/obj/item/clothing/neck/vtr/tie/redclip
	name = "red tie with clip"
	desc = "A red necktie with a gold clip."
	icon_state = "redcliptie"

/obj/item/clothing/neck/vtr/tie/redlong
	name = "long red tie"
	icon_state = "redlongtie"

/obj/item/clothing/neck/vtr/tie/navy
	name = "navy tie"
	icon_state = "navytie"

/obj/item/clothing/neck/vtr/tie/yellow
	name = "yellow tie"
	icon_state = "yellowtie"

/obj/item/clothing/neck/vtr/tie/white
	name = "white tie"
	icon_state = "whitetie"

/obj/item/clothing/neck/vtr/tie/darkgreen
	name = "dark green tie"
	icon_state = "dgreentie"

/obj/item/clothing/neck/vtr/tie/horrible
	name = "horrible tie"
	desc = "A truly horrible necktie."
	icon_state = "horribletie"

/obj/item/clothing/neck/vtr/choker
	name = "black choker"
	desc = "A plain black choker, popular among goths."
	icon_state = "blackchoker"

/obj/item/clothing/neck/vtr/choker/silver
	name = "metallic choker"
	desc = "A silvery fabric choker. Scene chicks dig it."
	icon_state = "steelchoker"

/obj/item/clothing/neck/vtr/choker/collar
	name = "leather collar"
	desc = "A leather bondage collar with a steel o-ring."
	icon_state = "leathercollar"

/obj/item/clothing/neck/vtr/choker/collar/steel
	name = "silver-plated collar"
	desc = "A locking metal bondage collar plated in tarnish-resistant, hypoallergenic silver. Hardcore."
	icon_state = "steelcollar"

/obj/item/clothing/neck/vtr/choker/collar/steel/Initialize()
	. = ..()
	AddElement(/datum/element/silvered)

/obj/item/clothing/neck/vtr/choker/collar/leatherg
	name = "fancy leather collar"
	desc = "A leather bondage collar with a gold o-ring. A little classier than the alternatives."
	icon_state = "leathercollar_g"
