/datum/data/retail_product
	var/equipment_name = "generic"
	var/equipment_path = null
	var/cost = 0
	var/stock = -1
	var/icon_dimension

/datum/data/retail_product/New(name, path, cost, stock = -1)
	src.equipment_name = name
	src.equipment_path = path
	src.cost = cost
	src.stock = stock

	var/atom/item = equipment_path
	if(!item)
		CRASH("Retail product equipment path of [equipment_path] is not a valid path!")
	var/icon_file = initial(item.icon)
	var/icon_state = initial(item.icon_state)
	var/icon/temp_icon = icon(icon_file, icon_state, SOUTH)
	icon_dimension = "[temp_icon.Width()]x[temp_icon.Height()]"
	qdel(temp_icon)
