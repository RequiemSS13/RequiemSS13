/mob/living/simple_animal
	var/capable_of_speech = FALSE


/mob/living/simple_animal/pet/say(message, bubble_type,list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(capable_of_speech)
		. = ..()
	return

/mob/living/simple_animal/hostile/say(message, bubble_type,list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(capable_of_speech)
		. = ..()
	return