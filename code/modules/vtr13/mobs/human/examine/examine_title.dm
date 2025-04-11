
/mob/living/carbon/human/proc/examine_title(mob/user)
	var/obscure_name
	if(isliving(user))
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_PROSOPAGNOSIA))
			obscure_name = TRUE

	var/my_gender = "male"
	if(gender == MALE)
		switch(age)
			if(16 to 24)
				my_gender = "guy"
			if(24 to INFINITY)
				my_gender = "man"
	if(gender == FEMALE)
		my_gender = "female"
		switch(age)
			if(16 to 24)
				my_gender = "lady"
			if(24 to INFINITY)
				my_gender = "woman"
	
	var/social_descriptor = "godlike"
	if(is_face_visible())
		social_descriptor = "shrouded"
	else
		switch(get_total_social())
			if(1)
				social_descriptor = "unappealing"
			if(2)
				social_descriptor = "average"
			if(3)
				social_descriptor = "charming"
			if(4)
				social_descriptor = (gender == MALE)?"handsome" : "beautiful"
			if(5)
				social_descriptor = "gorgeous"
	
	var/physical_descriptor = "inhuman"
	switch(get_total_physique())
		if(1)
			physical_descriptor = "unathletic"
		if(2)
			physical_descriptor = "average"
		if(3)
			physical_descriptor = "toned"
		if(4)
			physical_descriptor = "muscular"
		if(5)
			physical_descriptor = "hulking"

	var/total_descriptor
	if(social_descriptor == physical_descriptor)
		total_descriptor = physical_descriptor
	else
		total_descriptor = "[social_descriptor], [physical_descriptor]"

	return "This is <EM>[!obscure_name ? name : "Unknown"]</EM>, \a [total_descriptor] [my_gender]!"
