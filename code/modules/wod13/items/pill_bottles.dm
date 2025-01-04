
/obj/item/storage/pill_bottle/estrogen
	name = "estrogen pill bottle"
	desc = "There are boobs on the top."

/obj/item/storage/pill_bottle/estrogen/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/epinephrine(src)

/obj/item/storage/pill_bottle/ephedrine
	name = "ephedrine pill bottle"
	desc = "There is opium attention sign on the top."

/obj/item/storage/pill_bottle/ephedrine/PopulateContents()
	for(var/i in 1 to 10)
		new /obj/item/reagent_containers/pill/ephedrine(src)

/obj/item/reagent_containers/pill/ephedrine
	name = "ephedrine pill"
	desc = "Used to stabilize patients."
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/medicine/ephedrine = 15)
	rename_with_volume = TRUE

/obj/item/storage/pill_bottle/antibirth
	name = "antibirth pill bottle"
	desc = "There is crossed sex icon on the top."

/obj/item/storage/pill_bottle/antibirth/PopulateContents()
	for(var/i in 1 to 5)
		new /obj/item/reagent_containers/pill/iron(src)
