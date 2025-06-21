/obj/item/clothing/suit/vampire/vtr
	icon = 'icons/vtr13/obj/clothing/suits.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'
	onflooricon = 'icons/vtr13/obj/clothing/onfloor.dmi'

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

/obj/item/clothing/suit/hooded/hoodie
	name = "hoodie"
	desc = "A simple hoodie."
	icon_state = "hoodie"
	icon = 'icons/vtr13/obj/clothing/suits.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'
	onflooricon = 'icons/vtr13/obj/clothing/onfloor.dmi'
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
	onflooricon = 'icons/vtr13/obj/clothing/onfloor.dmi'
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
	name = "intruder pim hoodie hood"
	desc = "A hood of your favourite cartoon character-- you know, the green dog from the thing?"
	icon_state = "hoodie_zim_hood"