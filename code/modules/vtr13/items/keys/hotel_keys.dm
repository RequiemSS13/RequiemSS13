//there's a bunch of hotel keys so they're in their own file
//each hotel key is for its own room so if we ever remap the keys all need to be redone, which sucks
/obj/item/vamp/keys/hotel_11
	name = "Room 11 Key"
	accesslocks = list("room11")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_12
	name = "Room 12 Key"
	accesslocks = list("room12")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_13
	name = "Room 13 Key"
	accesslocks = list("room13")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_14
	name = "Room 14 Key"
	accesslocks = list("room14")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_21
	name = "Room 21 Key"
	accesslocks = list("room21")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_22
	name = "Room 22 Key"
	accesslocks = list("room22")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_23
	name = "Room 23 Key"
	accesslocks = list("room23")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_24
	name = "Room 24 Key"
	accesslocks = list("room24")
	color = "#f7d760"

/obj/item/vamp/keys/hotel_25
	name = "Room 25 Key"
	accesslocks = list("room25")
	color = "#f7d760"

//hotel masterkey - currently admin spawn only because there's no good way to make this hard to steal
/obj/item/vamp/keys/hotel_master
	name = "Hotel Master Key"
	accesslocks = list(
		"room11",
		"room12",
		"room13",
		"room14",
		"room21",
		"room22",
		"room23",
		"room24",
		"room25"
		)
	color = "#f7d760"
