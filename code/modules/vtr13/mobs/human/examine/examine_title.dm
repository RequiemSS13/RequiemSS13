
/mob/living/carbon/human/proc/examine_title(mob/user)
	var/obscure_name
	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE


	var/shown_adjective = custom_desc
	var/shown_descriptor = custom_noun

	if(!is_face_visible())
		shown_adjective = "a shrouded"

	return "This is <EM>[!obscure_name ? name : "Unknown"]</EM>, [shown_adjective] [shown_descriptor]!"
