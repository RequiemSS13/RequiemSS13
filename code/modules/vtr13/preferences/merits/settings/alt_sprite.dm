/datum/merit_setting/alt_sprite
	name = "alt_sprite"
	parent_merit = /datum/merit/bane/childe_of_orlok
	var/sprite_options = list("Classic", "Otherworldly", "Rotten", "Very Rotten", "Extremely Rotten")

/datum/merit_setting/alt_sprite/populate_new_custom_value(mob/user)
	var/response = tgui_input_list(user, "What grim visage has the curse bestowed on you?", "Custom Merit Settings", sprite_options, "Classic")
	if(response)
		return response

