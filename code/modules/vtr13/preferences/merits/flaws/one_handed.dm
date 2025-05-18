/datum/merit/flaw/one_hand
	name = "One Handed"
	desc = "You've lost an arm, and it is not coming back."
	dots = -2
	gain_text = "<span class='warning'>You don't feel one of your arms.</span>"
	lose_text = "<span class='notice'>You feel both of your arms again.</span>"
	custom_setting_required = TRUE
	custom_setting_types = "missing_arm"

/datum/merit/flaw/one_hand/post_add()
	if(!custom_settings["missing_arm"])
		CRASH("Somehow didn't get this custom setting set.")
	var/mob/living/carbon/human/H = merit_holder
	var/obj/item/bodypart/arm
	if(custom_settings["missing_arm"] == "Left")
		arm = H.get_bodypart(BODY_ZONE_L_ARM)
	else
		arm = H.get_bodypart(BODY_ZONE_R_ARM)
	arm.drop_limb()
	qdel(arm)