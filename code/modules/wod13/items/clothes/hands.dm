//GLOVES

//GLOVES

//GLOVES

/obj/item/clothing/gloves/vampire
	icon = 'icons/wod13/clothing.dmi'
	worn_icon = 'icons/wod13/worn.dmi'
	onflooricon = 'icons/wod13/onfloor.dmi'
	inhand_icon_state = "fingerless"
	undyeable = TRUE
	body_worn = TRUE

/obj/item/clothing/gloves/vampire/leather
	name = "leather gloves"
	desc = "Short leather gloves."
	icon_state = "leather"
	transfer_prints = TRUE
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	resistance_flags = NONE
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 30)

/obj/item/clothing/gloves/vampire/work
	name = "work gloves"
	desc = "Provides fire protection for working in extreme environments."
	icon_state = "work"
	permeability_coefficient = 0.9
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 10, BIO = 0, RAD = 0, FIRE = 70, ACID = 30)

/obj/item/clothing/gloves/vampire/investigator
	name = "investigator gloves"
	desc = "Standard issue FBI workgloves tailored for investigators. Made out of latex outer lining and padded for acid and fire protection."
	icon_state = "work"
	permeability_coefficient = 0.5
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	armor = list(MELEE = 30, BULLET = 20, LASER = 5, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 70, ACID = 70)

/obj/item/clothing/gloves/vampire/cleaning
	name = "cleaning gloves"
	desc = "Provides acid protection."
	icon_state = "cleaning"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 70)

/obj/item/clothing/gloves/vampire/latex
	name = "latex gloves"
	desc = "Provides acid protection."
	icon_state = "latex"
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 70)


