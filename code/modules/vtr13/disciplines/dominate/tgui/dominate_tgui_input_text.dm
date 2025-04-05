/**
 * Creates a TGUI window with a text input. But with a DISCLAIMER FOR DOMINATE. Returns the user's response.
 *
 * This proc should be used to create windows for text entry that the caller will wait for a response from.
 * If tgui fancy chat is turned off: Will return a normal input. If max_length is specified, will return
 * stripped_multiline_input.
 *
 * Arguments:
 * * user - The user to show the text input to.
 * * guidelines - The guidelines for the text input, shown in the body of the TGUI window.
 * * message - The content of the text input, shown in the body of the TGUI window.
 * * title - The title of the text input modal, shown on the top of the TGUI window.
 * * default - The default (or current) value, shown as a placeholder.
 * * max_length - Specifies a max length for input. MAX_MESSAGE_LEN is default (1024)
 * * multiline -  Bool that determines if the input box is much larger. Good for large messages, laws, etc.
 * * encode - Toggling this determines if input is filtered via html_encode. Setting this to FALSE gives raw input.
 */
/proc/dominate_tgui_input_text(mob/user, guidelines = "", message = "", title = "Text Input", default, max_length = MAX_MESSAGE_LEN, multiline = FALSE, encode = TRUE, word_count = 0)
	if (!user)
		user = usr
	if (!istype(user))
		if (istype(user, /client))
			var/client/client = user
			user = client.mob
		else
			return
	/// Client does NOT have tgui_fancy on: Returns regular input
	if(!user.client.prefs.tgui_input_mode)
		if(encode)
			if(multiline)
				return stripped_multiline_input(user, message, title, default, max_length)
			else
				return stripped_input(user, message, title, default, max_length)
		else
			return input(user, message, title, default) as text|null
	var/datum/dominate_tgui_input_text/text_input = new(user, guidelines, message, title, default, max_length, multiline, encode, word_count)
	text_input.ui_interact(user)
	text_input.wait()
	if (text_input)
		. = text_input.entry
		qdel(text_input)


/**
 * # tgui_input_text
 *
 * Datum used for instantiating and using a TGUI-controlled text input that prompts the user with
 * a message and has an input for text entry.
 */
/datum/dominate_tgui_input_text
	/// Boolean field describing if the tgui_input_text was closed by the user.
	var/closed
	/// The default (or current) value, shown as a default.
	var/default
	/// Whether the input should be stripped using html_encode
	var/encode
	/// The entry that the user has return_typed in.
	var/entry
	/// The maximum length for text entry
	var/max_length
	/// The prompt's disclaimer, if any, of the TGUI window.
	var/guidelines
	/// The prompt's body, if any, of the TGUI window.
	var/message
	/// Multiline input for larger input boxes.
	var/multiline
	/// The title of the TGUI window
	var/title
	//Max amount of individual words allowed in the command.
	var/word_count
	///The error that displays when you muck up the input like a chump
	var/too_many_words_message = ""



/datum/dominate_tgui_input_text/New(mob/user, guidelines, message, title, default, max_length, multiline, encode, word_count)
	src.default = default
	src.encode = encode
	src.max_length = max_length
	src.guidelines = guidelines
	src.word_count = word_count
	src.message = message
	src.multiline = multiline
	src.title = title
/datum/dominate_tgui_input_text/Destroy(force, ...)
	SStgui.close_uis(src)
	. = ..()

/**
 * Waits for a user's response to the tgui_input_text's prompt before returning. Returns early if
 * the window was closed by the user.
 */
/datum/dominate_tgui_input_text/proc/wait()
	while (!entry && !closed && !QDELETED(src))
		stoplag(1)

/datum/dominate_tgui_input_text/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DominateTextInputModal")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/dominate_tgui_input_text/ui_close(mob/user)
	. = ..()
	closed = TRUE

/datum/dominate_tgui_input_text/ui_state(mob/user)
	return GLOB.always_state

/datum/dominate_tgui_input_text/ui_static_data(mob/user)
	. = list(
		"max_length" = max_length,
		"guidelines" = guidelines,
		"message" = message,
		"multiline" = multiline,
		"placeholder" = default, // You cannot use default as a const
		"preferences" = list(),
		"title" = title
	)
	.["preferences"]["large_buttons"] = user.client.prefs.tgui_large_buttons
	.["preferences"]["swapped_buttons"] = user.client.prefs.tgui_swapped_buttons

/datum/dominate_tgui_input_text/ui_data(mob/user)
	. = list()
	if(word_count && too_many_words_message)
		.["too_many_words_message"] = too_many_words_message


/datum/dominate_tgui_input_text/ui_act(action, list/params)
	. = ..()
	if (.)
		return
	switch(action)
		if("submit")
			if(max_length)
				if(length(params["entry"]) > max_length)
					return FALSE
				if(encode && (length(html_encode(params["entry"])) > max_length))
					to_chat(usr, span_notice("Input uses special characters, thus reducing the maximum length."))
			if(!length(params["entry"]))
				set_entry(null)
				SStgui.close_uis(src)
				return TRUE
			

			if(word_count)
				var/text_entry = trimtext(params["entry"])
				var/spaces_found = 0
				var/last_found_space = 1
				do {
					last_found_space = findtext(text_entry, " ", last_found_space)
					if(last_found_space)
						spaces_found++
						last_found_space++
				}
				while(last_found_space)
				if(spaces_found > word_count - 1)
					too_many_words_message = "Error: Use [word_count] words or less."
					return TRUE
			set_entry(params["entry"])
			SStgui.close_uis(src)
			return TRUE
		if("cancel")
			set_entry(null)
			SStgui.close_uis(src)
			return TRUE

/datum/dominate_tgui_input_text/proc/set_entry(entry)
	var/converted_entry = encode ? html_encode(entry) : entry
	src.entry = trim(converted_entry, max_length)