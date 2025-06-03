/datum/vampireclane/vtr/nosferatu
	name = "Nosferatu"
	desc = "The Nosferatu, each marred in unnatural ways by the Embrace, command terror and fear."
	curse = "It is obvious to anyone who looks at you that you are unnatural and offsettling. Ordinary humans barely tolerate your presence."
	clane_disciplines = list(
		/datum/discipline/vtr/vigor,
		/datum/discipline/vtr/obfuscate,
		/datum/discipline/vtr/nightmare
	)

	accessories = list("nosferatu_ears", "beast_legs", "beast_tail", "beast_tail_and_legs", "none")
	current_accessory = "none"
	accessories_layers = list("nosferatu_ears" = UPPER_EARS_LAYER, "beast_legs" = UNICORN_LAYER, "beast_tail" = UNICORN_LAYER, "beast_tail_and_legs" = UNICORN_LAYER, "none" = UNICORN_LAYER)
	bane_trait = TRAIT_LONELY_CURSE