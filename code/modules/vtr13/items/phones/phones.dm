/obj/item/vamp/phone/seneschal_vtr
	exchange_num = 666

/obj/item/vamp/phone/seneschal_vtr/Initialize()
	..()
	GLOB.seneschalvtrnumber = number
	GLOB.seneschalvtrname = owner
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/keeper/keeper = new()
	contacts += keeper
	var/datum/phonecontact/representative/representative = new()
	contacts += representative
	var/datum/phonecontact/bishop/bishop = new()
	contacts += bishop
	var/datum/phonecontact/hierophant/hierophant = new()
	contacts += hierophant
	var/datum/phonecontact/voivode/voivode = new()
	contacts += voivode
	var/datum/phonecontact/page/page = new()
	contacts += page


/obj/item/vamp/phone/page
	exchange_num = 666

/obj/item/vamp/phone/page/Initialize()
	..()
	var/datum/phonecontact/seneschal/seneschal = new()
	contacts += seneschal
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/keeper/keeper = new()
	contacts += keeper
	var/datum/phonecontact/representative/representative = new()
	contacts += representative
	var/datum/phonecontact/bishop/bishop = new()
	contacts += bishop
	var/datum/phonecontact/hierophant/hierophant = new()
	contacts += hierophant
	var/datum/phonecontact/voivode/voivode = new()
	contacts += voivode


/obj/item/vamp/phone/sheriff_vtr
	exchange_num = 666

/obj/item/vamp/phone/sheriff_vtr/Initialize()
	..()
	GLOB.sheriffvtrnumber = number
	GLOB.sheriffvtrname = owner
	var/datum/phonecontact/seneschal/seneschal = new()
	contacts += seneschal
	var/datum/phonecontact/keeper/keeper = new()
	contacts += keeper
	var/datum/phonecontact/representative/representative = new()
	contacts += representative
	var/datum/phonecontact/bishop/bishop = new()
	contacts += bishop
	var/datum/phonecontact/hierophant/hierophant = new()
	contacts += hierophant
	var/datum/phonecontact/voivode/voivode = new()
	contacts += voivode
	var/datum/phonecontact/page/page = new()
	contacts += page


/obj/item/vamp/phone/keeper
	exchange_num = 666

/obj/item/vamp/phone/keeper/Initialize()
	..()
	GLOB.keepernumber = number
	GLOB.keepername = owner
	var/datum/phonecontact/seneschal/seneschal = new()
	contacts += seneschal
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/page/page = new()
	contacts += page


/obj/item/vamp/phone/bartender_vtr
	exchange_num = 664

/obj/item/vamp/phone/bartender_vtr/Initialize()
	..()
	var/datum/phonecontact/keeper/club_owner/club_owner = new()
	contacts += club_owner

/obj/item/vamp/phone/barista
	exchange_num = 151

/obj/item/vamp/phone/representative
	exchange_num = 666


/obj/item/vamp/phone/representative/Initialize()
	..()
	GLOB.representativenumber = number
	GLOB.representativename = owner
	var/datum/phonecontact/seneschal/seneschal = new()
	contacts += seneschal
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/page/page = new()
	contacts += page


/obj/item/vamp/phone/bishop
	exchange_num = 666

/obj/item/vamp/phone/bishop/Initialize()
	..()
	GLOB.bishopnumber = number
	GLOB.bishopname = owner
	var/datum/phonecontact/seneschal/seneschal = new()
	contacts += seneschal
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/page/page = new()
	contacts += page

/obj/item/vamp/phone/hierophant
	exchange_num = 666

/obj/item/vamp/phone/hierophant/Initialize()
	..()
	GLOB.hierophantnumber = number
	GLOB.hierophantname = owner
	var/datum/phonecontact/seneschal/seneschal = new()
	contacts += seneschal
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/page/page = new()
	contacts += page

/obj/item/vamp/phone/voivode
	exchange_num = 666

/obj/item/vamp/phone/voivode/Initialize()
	..()
	GLOB.voivodenumber = number
	GLOB.voivodename = owner
	var/datum/phonecontact/seneschal/seneschal = new()
	contacts += seneschal
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/page/page = new()
	contacts += page

/obj/item/vamp/phone/invictus
	exchange_num = 820

/obj/item/vamp/phone/invictus/Initialize()
	..()
	var/datum/phonecontact/sheriff_vtr/sheriff = new()
	contacts += sheriff
	var/datum/phonecontact/page/page = new()
	contacts += page

/obj/item/vamp/phone/carthian
	exchange_num = 858

/obj/item/vamp/phone/carthian/Initialize()
	..()
	var/datum/phonecontact/representative/representative = new()
	contacts += representative

/obj/item/vamp/phone/sanctified
	exchange_num = 832

/obj/item/vamp/phone/sanctified/Initialize()
	..()
	var/datum/phonecontact/bishop/bishop = new()
	contacts += bishop

/obj/item/vamp/phone/acolyte
	exchange_num = 840

/obj/item/vamp/phone/acolyte/Initialize()
	..()
	var/datum/phonecontact/hierophant/hierophant = new()
	contacts += hierophant

/obj/item/vamp/phone/sworn
	exchange_num = 884

/obj/item/vamp/phone/sworn/Initialize()
	..()
	var/datum/phonecontact/voivode/voivode = new()
	contacts += voivode

/obj/item/vamp/phone/librarian_vtr
	exchange_num = 883

/obj/item/vamp/phone/librarian_vtr/Initialize()
	..()
	var/datum/phonecontact/voivode/dean/dean = new()
	contacts += dean