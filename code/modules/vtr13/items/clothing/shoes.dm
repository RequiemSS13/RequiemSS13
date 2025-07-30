/obj/item/clothing/shoes
	var/shoes_under_pants = FALSE

/obj/item/clothing/shoes/AltClick(mob/user)
	if(!ishuman(user) || !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		return ..()
	var/mob/living/carbon/human/wearer = user
	if(wearer?.shoes && src == wearer.shoes && wearer.w_uniform)
		wearer.shoes.shoes_under_pants = !wearer.shoes.shoes_under_pants
		wearer.update_inv_shoes()


/obj/item/clothing/shoes/vampire/vtr
	name = "generic vamp shoes"
	icon = 'icons/vtr13/obj/clothing/shoes.dmi'
	worn_icon = 'icons/vtr13/obj/clothing/worn.dmi'

/obj/item/clothing/shoes/vampire/vtr/blackfur
	name = "black fur boots"
	desc = "A furry pair of black and white boots"
	icon_state = "furboots_black"

/obj/item/clothing/shoes/vampire/vtr/brownfur
	name = "brown fur boots"
	desc = "A furry pair of brown boots"
	icon_state = "furboots_brown"

/obj/item/clothing/shoes/vampire/vtr/pumped
	name = "knee-high sneakers"
	desc = "These are the pumped up kicks you are looking for."
	icon_state = "pumped_up_kicks"

/obj/item/clothing/shoes/vampire/vtr/flats
	name = "black flats"
	desc = "A pair of women's flats."
	icon_state = "flatsblack"

/obj/item/clothing/shoes/vampire/vtr/flats/brown
	name = "brown flats"
	icon_state = "flatsbrown"

/obj/item/clothing/shoes/vampire/vtr/flats/white
	name = "white flats"
	icon_state = "flatswhite"

/obj/item/clothing/shoes/vampire/vtr/flats/red
	name = "red flats"
	icon_state = "flatsred"

/obj/item/clothing/shoes/vampire/vtr/flats/orange
	name = "orange flats"
	icon_state = "flatsorange"

/obj/item/clothing/shoes/vampire/vtr/flats/purple
	name = "purple flats"
	icon_state = "flatspurple"

/obj/item/clothing/shoes/vampire/vtr/flats/blue
	name = "blue flats"
	icon_state = "flatsblue"

/obj/item/clothing/shoes/vampire/vtr/sneakers_blue
	name = "blue sneakers"
	desc = "A pair of blue sneakers."
	icon_state = "sneakers_blue"
