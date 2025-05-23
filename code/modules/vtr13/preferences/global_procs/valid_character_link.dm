/proc/valid_character_link(mob/user, value, silent = FALSE)
	var/static/link_regex = regex("www.f-list.net|docs.google.com|toyhou.se|refsheet.net")
	var/static/valid_endpoints = list(".neocities.org", ".neocities.org/", ".carrd.co", ".carrd.co/", ".crd.co", ".crd.co/", ".drr.ac", ".drr.ac/", ".ju.mp", ".ju.mp/", ".uwu.ai", ".uwu.ai/")

	if(!length(value))
		return FALSE

	var/find_index = findtext(value, "https://")
	if(find_index != 1)
		if(!silent)
			to_chat(user, span_warning("Your link must be https!"))
		return FALSE


	var/first_period = findtext(value, ".")
	if(!first_period)
		to_chat(user, span_warning("Invalid Link!"))
		return FALSE

	// extension will always be the last entry
	var/ended_with_valid_link = TRUE
	var/substring_to_search = copytext(value, first_period)
	if(!(substring_to_search in valid_endpoints))
		ended_with_valid_link = FALSE

	var/started_with_valid_link = TRUE
	find_index = findtext(value, link_regex)
	if(find_index != 9)
		started_with_valid_link = FALSE

	if(!ended_with_valid_link && !started_with_valid_link)
		if(!silent)
			to_chat(usr, span_warning("The image must be hosted on one of the following sites: 'www.f-list.net, docs.google.com, neocities.org, carrd.co'. Try not to include any subpages in the URL."))
		return FALSE
	return TRUE