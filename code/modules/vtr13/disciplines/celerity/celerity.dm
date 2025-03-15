/datum/discipline/vtr/celerity
	name = "Celerity"
	desc = "Boosts your speed. Violates Masquerade."
	icon_state = "celerity"
	power_type = /datum/discipline_power/vtr/celerity

/datum/discipline_power/vtr/celerity
	name = "Celerity power name"
	desc = "Celerity power description"

	activate_sound = 'code/modules/wod13/sounds/celerity_activate.ogg'
	deactivate_sound = 'code/modules/wod13/sounds/celerity_deactivate.ogg'

/datum/discipline_power/vtr/celerity/proc/celerity_visual(datum/discipline_power/celerity/source, atom/newloc, dir)
	SIGNAL_HANDLER
	var/obj/effect/celerity/C = new(owner.loc)
	C.name = owner.name
	C.appearance = owner.appearance
	C.dir = owner.dir
	animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), alpha = 0, time = 0.5 SECONDS)
	violate_masquerade(owner, owner)


/obj/effect/celerity
	name = "Afterimage"
	desc = "..."
	anchored = TRUE

/obj/effect/celerity/Initialize()
	. = ..()
	addtimer(CALLBACK(src, PROC_REF(delete_self)), 0.5 SECONDS)

/obj/effect/celerity/proc/delete_self()
	qdel(src)
