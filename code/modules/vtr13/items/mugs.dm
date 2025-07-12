/obj/item/reagent_containers/food/drinks/mug
	name = "mug"
	desc = "A plain white coffee mug."
	icon = 'icons/vtr13/obj/drinks_mugs.dmi'
	icon_state = "coffeecup"
	inhand_icon_state = "coffee"
	spillable = TRUE
	var/filled_overlay = "mug_filled"

/obj/item/reagent_containers/food/drinks/mug/update_overlays()
	. = ..()
	var/mutable_appearance/fill_overlay = mutable_appearance(icon, filled_overlay)
	if(reagents.total_volume > 0)
		fill_overlay.color = mix_color_from_reagents(reagents.reagent_list)
		. += fill_overlay
	else
		. -= fill_overlay

/obj/item/reagent_containers/food/drinks/mug/bloody
	desc = "A novelty black coffee cup with spilling blood printed on the side."
	icon_state = "coffeecup_blood"

/obj/item/reagent_containers/food/drinks/mug/twotone
	desc = "A coffee cup advertising a new brand of medication."
	icon_state = "coffeecup_twotone"

/obj/item/reagent_containers/food/drinks/mug/media
	desc = "A coffee cup with the logo of a local TV station."
	icon_state = "coffeecup_media"

/obj/item/reagent_containers/food/drinks/mug/police
	desc = "A coffee cup with the emblem of the local police department."
	icon_state = "coffeecup_gov"

/obj/item/reagent_containers/food/drinks/mug/band
	desc = "A coffee cup branded with the name of a rock band."
	icon_state = "coffeecup_wulf"

/obj/item/reagent_containers/food/drinks/mug/purp
	desc = "Insist on your cup of stars."
	icon_state = "coffeecup_almp"

/obj/item/reagent_containers/food/drinks/mug/redstar
	desc = "A coffee cup with a red star emblazoned on the side."
	icon_state = "coffeecup_redstar"

/obj/item/reagent_containers/food/drinks/mug/black
	desc = "A coffee cup in black and red. So gothic."
	icon_state = "coffeecup_black"

/obj/item/reagent_containers/food/drinks/mug/heart
	desc = "A coffee cup reading 'I <3 LA'."
	icon_state = "coffeecup_heart"

/obj/item/reagent_containers/food/drinks/mug/one
	desc = "A coffee cup reading '#1 Boss'."
	icon_state = "coffeecup_one"

/obj/item/reagent_containers/food/drinks/mug/monkey
	desc = "A coffee cup with a picture of a monkey, he's wearing a bow-tie!"
	icon_state = "coffeecup_puni"

/obj/item/reagent_containers/food/drinks/mug/rainbow
	desc = "A rainbow-striped coffee cup."
	icon_state = "coffeecup_rainbow"

/obj/item/reagent_containers/food/drinks/mug/metal
	desc = "A metal travel mug."
	icon_state = "coffeecup_metal"

/obj/item/reagent_containers/food/drinks/mug/zim
	desc = "A mug with your favourite cartoon character-- you know, the green dog from the thing?"
	icon_state = "coffeecup_zim"

/obj/item/reagent_containers/food/drinks/mug/green
	desc = "A green coffee mug."
	icon_state = "coffeecup_green"
	inhand_icon_state = "space_mountain_wind"

/obj/item/reagent_containers/food/drinks/mug/blue
	desc = "A blue coffee mug."
	icon_state = "coffeecup_blue"

/obj/item/reagent_containers/food/drinks/mug/darkgreen
	desc = "A dark green coffee mug."
	icon_state = "coffeecup_corp"

/obj/item/reagent_containers/food/drinks/mug/pharma
	desc = "A coffee mug advertising some pharmaceutical company."
	icon_state = "coffeecup_pharma"

/obj/item/reagent_containers/food/drinks/mug/sports
	desc = "A coffee mug with the logo of a college sports team."
	icon_state = "coffeecup_g"

/obj/item/reagent_containers/food/drinks/mug/retail
	desc = "A coffee mug advertising a major retailer."
	icon_state = "coffeecup_retail"

/obj/item/reagent_containers/food/drinks/mug/snake
	desc = "A green coffee mug with a white snake logo."
	icon_state = "coffeecup_snake"

/obj/item/reagent_containers/food/drinks/mug/flame
	desc = "An orange coffee mug with the logo of an oil company."
	icon_state = "coffeecup_flame"
	inhand_icon_state = "starkist"

/obj/item/reagent_containers/food/drinks/mug/night
	desc = "An black mug with a night-time scene on the side."
	icon_state = "coffeecup_night"

/obj/item/reagent_containers/food/drinks/mug/day
	desc = "An bright yellow cup with a picture of the sun on the side."
	icon_state = "coffeecup_sun"
	inhand_icon_state = "sodawater"

/obj/item/reagent_containers/food/drinks/mug/cup
	name = "cup"
	desc = "A plain white coffee cup."
	icon_state = "cup"

	filled_overlay = "cup_filled"
	inhand_icon_state = "coffee"

//Pre-filled types

/obj/item/reagent_containers/food/drinks/mug/tea
	name = "Earl Grey tea"
	desc = "A black tea with subtle notes of bergamot. Very relaxing."
	list_reagents = list(/datum/reagent/consumable/tea = 30)

/obj/item/reagent_containers/food/drinks/mug/coco
	name = "Dutch hot coco"
	desc = "Clearly made from a packet, but sweet nonetheless."
	list_reagents = list(/datum/reagent/consumable/hot_coco = 15, /datum/reagent/consumable/sugar = 5)
	foodtype = SUGAR
	resistance_flags = FREEZE_PROOF
	custom_price = PAYCHECK_ASSISTANT * 1.2
