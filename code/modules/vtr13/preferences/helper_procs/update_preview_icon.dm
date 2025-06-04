/datum/preferences/proc/update_preview_icon(show_loadout = FALSE)
	if(!parent) // If we don't have anyone to show, don't waste our time making a preview
		return
	// Determine what job is marked as 'High' priority, and dress them up as such.
	var/datum/job/previewJob
	var/highest_pref = 0
	for(var/job in job_preferences)
		if(job_preferences[job] > highest_pref)
			previewJob = SSjob.GetJob(job)
			highest_pref = job_preferences[job]
		if(job == SSjob.overflow_role)
			if(job_preferences[SSjob.overflow_role] == JP_LOW)
				previewJob = SSjob.GetJob(job)
				highest_pref = job_preferences[job]

	if(previewJob)
		// Silicons only need a very basic preview since there is no customization for them.
		if(istype(previewJob,/datum/job/ai))
			parent.show_character_previews(image('icons/mob/ai.dmi', icon_state = resolve_ai_icon("ai"), dir = SOUTH))
			return
		if(istype(previewJob,/datum/job/cyborg))
			parent.show_character_previews(image('icons/mob/robots.dmi', icon_state = "robot", dir = SOUTH))
			return

	// Set up the dummy for its photoshoot
	var/mob/living/carbon/human/dummy/mannequin = generate_or_wait_for_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)
	var/mutable_appearance/MAMA = mutable_appearance('icons/wod13/64x32.dmi', "slot", layer = SPACE_LAYER)
	MAMA.pixel_x = -16
	mannequin.add_overlay(MAMA)
	copy_to(mannequin, 1, TRUE, TRUE, loadout = show_loadout)
	if(all_merits.Find("Childe of Orlok"))
		mannequin.unique_body_sprite = "nosferatu"
	else
		mannequin.unique_body_sprite = null
	mannequin.update_body()
	mannequin.update_body_parts()
	mannequin.update_icon()

	if(previewJob)
		mannequin.job = previewJob.title
		previewJob.equip(mannequin, TRUE, preference_source = parent)

	COMPILE_OVERLAYS(mannequin)
	parent.show_character_previews(new /mutable_appearance(mannequin))
	unset_busy_human_dummy(DUMMY_HUMAN_SLOT_PREFERENCES)