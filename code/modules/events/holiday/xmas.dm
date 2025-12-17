/obj/item/toy/xmas_cracker
	name = "xmas cracker"
	icon = 'icons/obj/christmas.dmi'
	icon_state = "cracker"
	desc = "Directions for use: Requires two people, one to pull each end."
	var/cracked = 0

/obj/item/toy/xmas_cracker/attack(mob/target, mob/user)
	if( !cracked && ishuman(target) && (target.stat == CONSCIOUS) && !target.get_active_held_item() )
		target.visible_message("<span class='notice'>[user] and [target] pop \an [src]! *pop*</span>", "<span class='notice'>You pull \an [src] with [target]! *pop*</span>", "<span class='hear'>You hear a pop.</span>")
		var/obj/item/paper/Joke = new /obj/item/paper(user.loc)
		Joke.name = "[pick("awful","terrible","unfunny")] joke"
		Joke.add_raw_text(pick("What did one snowman say to the other?\n\n<i>'Is it me or can you smell carrots?'</i>",
			"Why couldn't the snowman get laid?\n\n<i>He was frigid!</i>",
			"Where are santa's helpers educated?\n\n<i>Nowhere, they're ELF-taught.</i>",
			"What happened to the man who stole advent calanders?\n\n<i>He got 25 days.</i>",
			"What does Santa get when he gets stuck in a chimney?\n\n<i>Claus-trophobia.</i>",
			"Where do you find chili beans?\n\n<i>The north pole.</i>",
			"What do you get from eating tree decorations?\n\n<i>Tinsilitis!</i>",
			"What do snowmen wear on their heads?\n\n<i>Ice caps!</i>",
			"Why doesn't Santa have any children?\n\n<i>Because he only comes down the chimney.</i>"))
		new /obj/item/clothing/head/festive(target.loc)
		user.update_icons()
		cracked = 1
		icon_state = "cracker1"
		var/obj/item/toy/xmas_cracker/other_half = new /obj/item/toy/xmas_cracker(target)
		other_half.cracked = 1
		other_half.icon_state = "cracker2"
		target.put_in_active_hand(other_half)
		playsound(user, 'sound/effects/snap.ogg', 50, TRUE)
		return 1
	return ..()

/obj/item/clothing/head/festive
	name = "festive paper hat"
	icon_state = "xmashat"
	desc = "A crappy paper hat that you are REQUIRED to wear."
	flags_inv = 0
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	dog_fashion = /datum/dog_fashion/head/festive

/obj/effect/spawner/xmastree
	name = "christmas tree spawner"
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "x2"
	layer = FLY_LAYER

	var/festive_tree = /obj/structure/flora/tree/pine/xmas
	var/christmas_tree = /obj/structure/flora/tree/pine/xmas/presents

/obj/effect/spawner/xmastree/Initialize()
	..()
	if((CHRISTMAS in SSevents.holidays) && christmas_tree)
		new christmas_tree(get_turf(src))
	else if((FESTIVE_SEASON in SSevents.holidays) && festive_tree)
		new festive_tree(get_turf(src))

	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/xmastree/rdrod
	name = "festivus pole spawner"
	festive_tree = /obj/structure/festivus
	christmas_tree = null

/datum/round_event_control/santa
	name = "Visit by Santa"
	holidayID = CHRISTMAS
	typepath = /datum/round_event/santa
	weight = 20
	max_occurrences = 1
	earliest_start = 30 MINUTES

/datum/round_event/santa
	var/mob/living/carbon/human/santa //who is our santa?

/datum/round_event/santa/announce(fake)
	priority_announce("Santa is coming to town!", "Unknown Transmission")

/datum/round_event/santa/start()
	var/list/candidates = pollGhostCandidates("Santa is coming to town! Do you want to be Santa?", poll_time=150)
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		santa = new /mob/living/carbon/human(pick(GLOB.blobstart))
		santa.key = C.key

		var/datum/antagonist/santa/A = new
		santa.mind.add_antag_datum(A)

//new VTR things

/obj/structure/christmas/doorwreath
	name = "wreaths"
	desc = "Some festive wreaths."
	icon = 'icons/obj/christmas.dmi'
	icon_state = "doorwreath"

/obj/structure/christmas/xmaslights //string lights, but they don't actually emit light
	name = "christmas lights"
	desc = "Some festive lights."
	icon = 'icons/obj/christmas.dmi'
	icon_state = "xmaslights"

/obj/structure/christmas/xmaslights_lit //these are mostly for outdoor use
	name = "christmas lights"
	desc = "Some festive lights."
	icon = 'icons/obj/christmas.dmi'
	icon_state = "xmaslights_lit"
	plane = EMISSIVE_PLANE
	layer = LIGHTING_LAYER
	blend_mode = BLEND_ADD

/obj/structure/christmas/festive_tree
	name = "\"christmas tree\""
	desc = "A rather pathetic \"christmas tree\". Is this the best they could do?"
	icon = 'icons/obj/christmas.dmi'
	icon_state = "festive_tree"

/obj/structure/christmas/xmas_sticker01
	name = "festive decals"
	desc = "Festive decals that spell out 'MERRY'."
	icon = 'icons/obj/christmas.dmi'
	icon_state = "xmas_sticker01"

/obj/structure/christmas/xmas_sticker02
	name = "festive decals"
	desc = "Festive decals that spell out 'X-MAS'."
	icon = 'icons/obj/christmas.dmi'
	icon_state = "xmas_sticker02"

/obj/structure/christmas/xmas_sticker03
	name = "festive decals"
	desc = "Festive decals depicting some snow-topped trees. Pretend you live somewhere that snows!"
	icon = 'icons/obj/christmas.dmi'
	icon_state = "xmas_sticker03"

/obj/structure/christmas/xmas_sticker04
	name = "festive decals"
	desc = "Festive decals depicting Santa and three of his reindeer, including that red-nosed one."
	icon = 'icons/obj/christmas.dmi'
	icon_state = "xmas_sticker04"

/obj/item/toy/talking/owl/owl_vtr
	name = "owl figure"
	desc = "A figure of an owl."
	w_class = WEIGHT_CLASS_SMALL

/obj/structure/christmas/giftpile
	name = "gift pile"
	desc = "A pile of gifts."
	icon = 'icons/obj/christmas.dmi'
	icon_state = "giftpile"

//vtrgift and all associated things is basically just a_gift w/o the spaceman shit in it

/obj/item/a_gift/vtrgift
	name = "gift"
	desc = "PRESENTS!!!! eek!"
	icon = 'icons/obj/christmas.dmi'
	icon_state = "gift1"

var/obj/item/contains_type

/obj/item/a_gift/vtrgift/Initialize()
	. = ..()
	pixel_x = rand(-10,10)
	pixel_y = rand(-10,10)
	icon_state = "gift[rand(1,3)]"

	contains_type = get_gift_type_vtr()

/obj/item/a_gift/vtrgift/proc/get_gift_type_vtr()
	var/gift_type_list_vtr = list(/obj/item/storage/wallet,
		/obj/item/storage/photo_album,
		/obj/item/storage/box/snappops,
		/obj/item/storage/crayons,
		/obj/item/storage/belt/champion,
		/obj/item/soap/deluxe,
		/obj/item/pen/invisible,
		/obj/item/lipstick/random,
		/obj/item/grown/corncob,
		/obj/item/bikehorn,
		/obj/item/toy/beach_ball,
		/obj/item/toy/beach_ball/holoball,
		/obj/item/instrument/violin,
		/obj/item/instrument/guitar,
		/obj/item/storage/belt/utility/full,
		/obj/item/clothing/neck/tie/horrible,
		/obj/item/clothing/suit/toggle/vtr/leather,
		/obj/item/clothing/suit/vampire/vtr/greatcoat,
		/obj/item/clothing/suit/snowman,
		/obj/item/clothing/head/snowman,
		/obj/item/stack/sheet/mineral/coal,
		/obj/item/toy/gun,
		/obj/item/toy/sword,
		/obj/item/dualsaber/toy,
		/obj/item/toy/katana,
		/obj/item/toy/snowball,
		/obj/item/toy/toy_dagger,
		/obj/item/toy/cattoy,
		/obj/item/toy/seashell,
		/obj/item/toy/braintoy,
		/obj/item/toy/talking/owl/owl_vtr,
		/obj/item/gun/ballistic/automatic/toy/pistol, //foam guns
		/obj/item/gun/ballistic/shotgun/toy,
		/obj/item/gun/ballistic/shotgun/toy/crossbow,
		/obj/item/toy/plush/lizardplushie, //might be too spacey but i think it's fine
		/obj/item/toy/plush/lizardplushie/space,
		/obj/item/toy/plush/snakeplushie,
		/obj/item/toy/plush/slimeplushie,
		/obj/item/toy/plush/beeplushie,
		/obj/item/toy/plush/moth,
		/obj/item/clothing/head/santa, //santa gear. teehee
		/obj/item/clothing/suit/vampire/coat/winter/alt
		)

	gift_type_list_vtr += subtypesof(/obj/item/clothing/head/collectable) - (list(/obj/item/clothing/head/collectable/slime, /obj/item/clothing/head/collectable/hos, /obj/item/clothing/head/collectable/hop)) //removing spaceman shit

	var/gift_type_vtr = pick(gift_type_list_vtr)

	return gift_type_vtr