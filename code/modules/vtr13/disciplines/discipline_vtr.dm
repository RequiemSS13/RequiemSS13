/datum/discipline_power/vtr/proc/violate_masquerade(mob/living/carbon/human/source, mob/attacker, range = 7, affects_source = FALSE)
	set waitfor = FALSE
	if(owner && owner.CheckEyewitness(source, attacker, range, affects_source))
		owner.AdjustMasquerade(-1)

/datum/discipline_power/vtr/proc/prevent_other_powers(datum/source, datum/target)
	SIGNAL_HANDLER
	to_chat(owner, span_warning("You cannot use other disciplines right now!"))
	return POWER_PREVENT_ACTIVATE


/datum/discipline_power/vtr/proc/apply_discipline_affliction_overlay(mob/living/carbon/target, icon_state, pixel_z_offset, end_after)
	if(!target)
		return FALSE
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dominate_overlay = mutable_appearance('icons/wod13/icons.dmi', icon_state, -MUTATIONS_LAYER)
	dominate_overlay.pixel_z = pixel_z_offset
	target.overlays_standing[MUTATIONS_LAYER] = dominate_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	if(end_after)
		addtimer(CALLBACK(src, PROC_REF(overlay_end),target), end_after)

/datum/discipline_power/vtr/proc/overlay_end(mob/living/carbon/target)
	if(!target)
		return FALSE
	target.remove_overlay(MUTATIONS_LAYER)
	return TRUE


/datum/discipline_power/vtr/proc/consent_ping(mob/living/target)
	if(!target)
		return
	SEND_SOUND(target, sound('code/modules/wod13/sounds/general_good.ogg', volume = 50))