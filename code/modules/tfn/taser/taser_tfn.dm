/obj/item/gun/energy/taser/twoshot
	name = "V26 taser"
	desc = "A less-than-lethal stun gun. Fires an electrode pair that will impale and electrocute noncompliant suspects. Holds two rechargable cartridges."
	icon = 'icons/tfn/items/taser.dmi'
	icon_state = "taser_wod"
	inhand_icon_state = null
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/expensive)
	charge_sections = 2
	ammo_x_offset = 3

/obj/item/ammo_casing/energy/electrode/expensive
	projectile_type = /obj/projectile/energy/electrode
	select_name = "stun"
	fire_sound = 'sound/tfn/tasershock.ogg'
	e_cost = 500
	harmful = FALSE