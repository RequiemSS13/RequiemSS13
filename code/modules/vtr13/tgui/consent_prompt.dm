/**
 * Creates a TGUI alert window and returns the user's response. BUT WITH A DISCLAIMER FOR DOMINATE
 *
 * This proc should be used to create alerts that the caller will wait for a response from.
 * Arguments:
 * * user - The user to show the alert to.
 * * message - The content of the alert, shown in the body of the TGUI window.
 * * title - The of the alert modal, shown on the top of the TGUI window.
 * * buttons - The options that can be chosen by the user, each string is assigned a button on the UI.
 * * timeout - The timeout of the alert, after which the modal will close and qdel itself. Set to zero for no timeout.
 */
/proc/consent_prompt(mob/user, message, title, disclaimer, the_command)
	if (!user)
		user = usr
	if (!istype(user))
		if (istype(user, /client))
			var/client/client = user
			user = client.mob
		else
			return
	var/datum/consent_tgui_modal/alert = new(user, message, title, disclaimer, the_command)
	alert.ui_interact(user)
	alert.wait()
	if (alert)
		. = alert.choice
		qdel(alert)


/**
 * # tgui_modal
 *
 * Datum used for instantiating and using a TGUI-controlled modal that prompts the user with
 * a message and has buttons for responses.
 */
/datum/consent_tgui_modal
	/// The title of the TGUI window
	var/title
	/// The textual body of the TGUI window
	var/message
	/// The disclaimer we are giving the consent form
	var/disclaimer
	/// The button that the user has pressed, null if no selection has been made
	var/choice
	/// Boolean field describing if the tgui_modal was closed by the user.
	var/closed
	///The command being given.
	var/command

/datum/consent_tgui_modal/New(mob/user, message, title, disclaimer, command)
	src.title = title
	src.message = message
	src.disclaimer = disclaimer
	src.command = command

/datum/consent_tgui_modal/Destroy(force, ...)
	SStgui.close_uis(src)
	. = ..()

/**
 * Waits for a user's response to the tgui_modal's prompt before returning. Returns early if
 * the window was closed by the user.
 */
/datum/consent_tgui_modal/proc/wait()
	while (!choice && !closed)
		stoplag(1)

/datum/consent_tgui_modal/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "DominateConsentModal")
		ui.open()

/datum/consent_tgui_modal/ui_close(mob/user)
	. = ..()
	closed = TRUE

/datum/consent_tgui_modal/ui_state(mob/user)
	return GLOB.always_state

/datum/consent_tgui_modal/ui_data(mob/user)
	. = list(
		"title" = title,
		"message" = message,
		"disclaimer" = disclaimer,
		"command" = command
	)
/datum/consent_tgui_modal/ui_act(action, list/params)
	. = ..()
	if (.)
		return
	switch(action)
		if("consent")
			choice = TRUE
			SStgui.close_uis(src)
			return TRUE
		if("reject")
			choice = FALSE
			SStgui.close_uis(src)
			return TRUE