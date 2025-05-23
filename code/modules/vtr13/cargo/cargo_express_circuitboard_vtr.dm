/obj/item/circuitboard/computer/cargo/express_vtr
	name = "Express Supply Console (Computer Board)"
	build_path = /obj/machinery/computer/cargo/express

/obj/item/circuitboard/computer/cargo/express_vtr/emag_act(mob/living/user)
	if(!(obj_flags & EMAGGED))
		contraband = TRUE
		obj_flags |= EMAGGED
		to_chat(user, "<span class='notice'>You change the routing protocols, allowing the Truck to deliver anywhere in the city.</span>")
