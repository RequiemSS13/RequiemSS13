
/mob/living/carbon/human/proc/examine_title(mob/user)
	var/obscure_name
	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE


	var/shown_adjective = adjective
	var/shown_descriptor = descriptor

	if(!is_face_visible())
		shown_adjective = "a shrouded"

	var/cleanliness_note = ""
	if(get_composure() <= 1)
		cleanliness_note = " [p_they(TRUE)] seems disheveled."
	if(get_composure() >= 5)
		cleanliness_note = " [p_they(TRUE)] [p_are()] immaculately well put-together."

	return "This is <EM>[!obscure_name ? name : "Unknown"]</EM>, [shown_descriptor] [shown_adjective]![cleanliness_note]"
