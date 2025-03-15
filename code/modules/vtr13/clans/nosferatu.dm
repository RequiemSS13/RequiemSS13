/datum/vampireclane/vtr/nosferatu
	name = "Nosferatu"
	desc = "The Nosferatu wear their curse on the outside. Elgeon wears her curse on the inside."
	curse = "Masquerade-violating appearance."
	clane_disciplines = list(
		/datum/discipline/vtr/vigor,
		/datum/discipline/vtr/obfuscate
	)

	male_clothes = /obj/item/clothing/under/vampire/nosferatu
	female_clothes = /obj/item/clothing/under/vampire/nosferatu/female

	accessories = list("nosferatu_ears", "beast_legs", "beast_tail", "beast_tail_and_legs", "none")
	current_accessory = "none"
	accessories_layers = list("nosferatu_ears" = UPPER_EARS_LAYER, "beast_legs" = UNICORN_LAYER, "beast_tail" = UNICORN_LAYER, "beast_tail_and_legs" = UNICORN_LAYER, "none" = UNICORN_LAYER)