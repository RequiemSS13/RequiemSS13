/datum/merit_setting/missing_arm
	name = "missing_arm"
	parent_merit = /datum/merit/flaw/one_hand
	var/missing_arm_options = list("Right","Left")

/datum/merit_setting/missing_arm/populate_new_custom_value(mob/user)
	return tgui_alert(user, "Which arm is missing?", "Custom Flaw Settings", missing_arm_options)
