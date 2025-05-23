/datum/phonecontact/seneschal
	name = "Seneschal"

/datum/phonecontact/seneschal/check_global_contacts()
	if(number != GLOB.seneschalvtrnumber && name_check != GLOB.seneschalvtrname)
		number = GLOB.seneschalvtrnumber
		name = GLOB.seneschalvtrname + " - " + name
		return TRUE
	..()

/datum/phonecontact/keeper
	name = "Keeper of Elysium"

/datum/phonecontact/keeper/check_global_contacts()
	if(number != GLOB.keepernumber && name_check != GLOB.keepername)
		number = GLOB.keepernumber
		name = GLOB.keepername + " - " + name
		return TRUE
	..()

/datum/phonecontact/keeper/club_owner
	name = "Club Owner"

/datum/phonecontact/sheriff_vtr
	name = "Sheriff"

/datum/phonecontact/sheriff_vtr/check_global_contacts()
	if(number != GLOB.sheriffvtrnumber && name_check != GLOB.sheriffvtrname)
		number = GLOB.sheriffvtrnumber
		name = GLOB.sheriffvtrname + " - " + name
		return TRUE
	..()

/datum/phonecontact/representative
	name = "Carthian Representative"

/datum/phonecontact/representative/check_global_contacts()
	if(number != GLOB.representativenumber && name_check != GLOB.representativename)
		number = GLOB.representativenumber
		name = GLOB.representativename + " - " + name
		return TRUE
	..()

/datum/phonecontact/bishop
	name = "Bishop"

/datum/phonecontact/bishop/check_global_contacts()
	if(number != GLOB.bishopnumber && name_check != GLOB.bishopname)
		number = GLOB.bishopnumber
		name = GLOB.bishopname + " - " + name
		return TRUE
	..()

/datum/phonecontact/hierophant
	name = "Hierophant"

/datum/phonecontact/hierophant/check_global_contacts()
	if(number != GLOB.hierophantnumber && name_check != GLOB.hierophantname)
		number = GLOB.hierophantnumber
		name = GLOB.hierophantname + " - " + name
		return TRUE
	..()

/datum/phonecontact/voivode
	name = "Voivode"

/datum/phonecontact/voivode/check_global_contacts()
	if(number != GLOB.voivodenumber && name_check != GLOB.voivodename)
		number = GLOB.voivodenumber
		name = GLOB.voivodename + " - " + name
		return TRUE
	..()

/datum/phonecontact/voivode/dean
	name = "Dean"

/datum/phonecontact/page
	name = "Page"

/datum/phonecontact/page/check_global_contacts()
	if(number != GLOB.pagenumber && name_check != GLOB.pagename)
		number = GLOB.pagenumber
		name = GLOB.pagename + " - " + name
		return TRUE
	..()
