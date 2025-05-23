/mob/living/carbon/human/proc/examine_flavortext_window(mob/user)
	if (is_face_visible())
		return span_notice("[copytext_char(flavor_text, 1, 110)]... <a href='byond://?src=[REF(src)];view_flavortext=1'>\[Look closer?\]</a>")
	else
		return span_notice("<a href='byond://?src=[REF(src)];view_flavortext=1'>\[Examine closely...\]</a>")