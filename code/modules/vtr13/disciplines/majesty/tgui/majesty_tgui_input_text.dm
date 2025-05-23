//We crib off of the Dominate input text for this.
/datum/discipline_power/vtr/proc/majesty_tgui_input_text(mob/user, guidelines = "", message = "", title = "Text Input", default, max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = TRUE, word_count = 0)
	return dominate_tgui_input_text(user, guidelines, message, title, default, max_length, multiline, encode, word_count)

