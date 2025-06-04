/obj/item/melee/vampirearms/knife/silver
	name = "knife"
	desc = "This weapon has been plated in silver. Fancy."
	icon = 'icons/wod13/weapons.dmi'
	icon_state = "knife"

/obj/item/melee/vampirearms/knife/silver/Initialize()
	. = ..()
	AddElement(/datum/element/silvered)