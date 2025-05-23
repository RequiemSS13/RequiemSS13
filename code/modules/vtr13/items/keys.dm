//WHEN WE DO KEYS, FIGURE OUT WHAT GOES WHERE


/obj/item/vamp/keys/seneschal_vtr
	name = "Seneschal's keys"
	accesslocks = list(
		"courtier",
		"hound",
		"sheriff",
		"page",
		"bartender",
		"keeper",
		"janitor",
		"invictus_car",
		"seneschal"
	)
	color = "#006eff"

/obj/item/vamp/keys/sheriff_vtr
	name = "Sheriff's keys"
	accesslocks = list(
		"courtier",
		"hound",
		"sheriff",
		"invictus_car"
	)
	color = "#006eff"

/obj/item/vamp/keys/keeper
	name = "Keeper of Elysium's keys"
	accesslocks = list(
		"courtier",
		"bartender",
		"keeper"
	)
	color = "#006eff"

/obj/item/vamp/keys/bartender_vtr
	name = "Bartender's keys"
	accesslocks = list(
		"bartender"
	)
	color = "#00ffff"

/obj/item/vamp/keys/barista
	name = "Barista's keys"
	accesslocks = list(
		"barista"
	)
	color = "#00ffff"

/obj/item/vamp/keys/page
	name = "Page's Keys"
	accesslocks = list(
		"courtier",
		"page",
		"invictus_car"
	)
	color = "#00ffff"

/obj/item/vamp/keys/hound
	name = "Hound's Keys"
	accesslocks = list(
		"courtier",
		"hound",
		"invictus_car"
	)
	color = "#00ffff"

/obj/item/vamp/keys/courtier
	name = "Courtier's keys"
	accesslocks = list(
		"courtier"
	)
	color = "#00ffff"

/obj/item/vamp/keys/voivode_vtr
	name = "Voivode's Keys"
	accesslocks = list(
		"librarian",
		"sworn",
		"voivode"
	)
	color = "#790656"

/obj/item/vamp/keys/sworn
	name = "Sworn's Keys"
	accesslocks = list(
		"librarian",
		"sworn"
	)
	color = "#df1ca4"

/obj/item/vamp/keys/librarian_vtr
	name = "Librarians's Keys"
	accesslocks = list(
		"librarian"
	)
	color = "#f580d2"

/obj/item/vamp/keys/representative
	name = "Carthian Representative's Keys"
	accesslocks = list(
		"carthian_rep",
		"carthian"
	)
	color = "#85251d"

/obj/item/vamp/keys/carthian
	name = "Carthian's Keys"
	accesslocks = list(
		"carthian"
	)
	color = "#ff1904"


/obj/item/vamp/keys/bishop
	name = "Bishop's Keys"
	accesslocks = list(
		"clergy",
		"sanctified",
		"bishop"
	)
	color = "#fbff00"

/obj/item/vamp/keys/sanctified
	name = "Sanctified's Keys"
	accesslocks = list(
		"clergy",
		"sanctified"
	)
	color = "#cab866"

/obj/item/vamp/keys/clergy
	name = "Clergy's Keys"
	accesslocks = list(
		"clergy"
	)
	color = "#dfdcd1"

/obj/item/vamp/keys/hierophant
	name = "Hierophant's Keys"
	accesslocks = list(
		"heirophant",
		"acolyte"
	)
	color = "#19571e"

/obj/item/vamp/keys/acolyte
	name = "Acolyte's Keys"
	accesslocks = list(
		"acolyte"
	)
	color = "#00ff15"

/obj/item/vamp/keys/police_vtr
	name = "Police keys"
	accesslocks = list(
		"police"
	)

/obj/item/vamp/keys/sergeant_vtr
	name = "Sergeant Police keys"
	accesslocks = list(
		"police",
		"sergeant"
	)

/obj/item/vamp/keys/police_chief_vtr
	name = "Chief of Police keys"
	accesslocks = list(
		"police",
		"sergeant",
		"chief"
	)

/obj/item/vamp/keys/taxi_vtr
	name = "Taxi keys"
	accesslocks = list(
		"taxi"
	)
	color = "#fffb8b"

/obj/item/vamp/keys/janitor_vtr
	name = "Cleaning keys"
	accesslocks = list(
		"janitor"
	)

/obj/item/vamp/keys/doctor_vtr
	name = "Clinic keys"
	accesslocks = list(
		"clinic"
	)

/obj/item/vamp/keys/director_vtr
	name = "Clinic director keys"
	accesslocks = list(
		"clinic",
		"director"
	)

//ADMINSPAWN ONLY keys for stuff players don't have access to. DO NOT add these to job equipment
/obj/item/vamp/keys/shop_vtr
	name = "Shop master keys"
	desc = "You probably shouldn't have this."
	accesslocks = list(
		"shop"
	)

/obj/item/vamp/keys/apartments_vtr
	name = "Apartment master keys"
	desc = "You probably shouldn't have this."
	accesslocks = list(
		"apartment"
	)

/obj/item/vamp/keys/house_vtr
	name = "House master keys"
	desc = "You probably shouldn't have this."
	accesslocks = list(
		"house"
	)

/obj/item/vamp/keys/master_vtr //DEFINITELY DON'T ADD THIS TO JOB EQUIPMENT.
	name = "Long Beach master keys"
	desc = "You DEFINITELY shouldn't have this."
	accesslocks = list(
		"courtier",
		"hound",
		"sheriff",
		"page",
		"bartender",
		"keeper",
		"janitor",
		"invictus_car",
		"seneschal",
		"librarian",
		"sworn",
		"voivode",
		"carthian_rep",
		"carthian",
		"clergy",
		"sanctified",
		"bishop",
		"heirophant",
		"acolyte",
		"police",
		"sergeant",
		"chief",
		"taxi",
		"clinic",
		"director",
		"house",
		"apartment",
		"shop"
	)
