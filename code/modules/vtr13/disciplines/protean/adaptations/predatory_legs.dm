/datum/movespeed_modifier/vtr/predatory_legs
	multiplicative_slowdown = -0.5

/datum/adaptation/predatory/legs
	name = "Digitigrade Legs"
	var/mutable_appearance/acc_overlay
	var/old_overlay

/datum/adaptation/predatory/legs/activate(mob/living/carbon/human/owner)
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	owner.visible_message(span_alert("[owner]'s shins make a horrid noise as they snap in two and elongate! Their legs become digitigrade and covered in thick fur!"))

	owner.remove_overlay(MARKS_LAYER)
	if(owner.overlays_standing[MARKS_LAYER])
		old_overlay = owner.overlays_standing[MARKS_LAYER]
	acc_overlay = mutable_appearance('icons/wod13/icons.dmi', "beast_legs", -MARKS_LAYER)
	owner.overlays_standing[MARKS_LAYER] = acc_overlay
	owner.apply_overlay(MARKS_LAYER)
	owner.update_body()
	owner.update_icon()
	

	ADD_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_3_TRAIT)
	ADD_TRAIT(owner, TRAIT_QUICK_JUMP, PROTEAN_1_ADAPTATION_TRAIT)
	owner.add_movespeed_modifier(/datum/movespeed_modifier/vtr/predatory_legs)
	
/datum/adaptation/predatory/legs/deactivate(mob/living/carbon/human/owner)
	playsound(get_turf(owner), 'sound/effects/dismember.ogg', 100, TRUE, -6)
	owner.visible_message(span_alert("[owner]'s legs return to a normal form."))
	owner.remove_overlay(MARKS_LAYER)
	if(old_overlay)
		owner.overlays_standing[MARKS_LAYER] = old_overlay
		owner.apply_overlay(MARKS_LAYER)
	owner.update_body()
	owner.update_icon()
	
	REMOVE_TRAIT(owner, TRAIT_NONMASQUERADE, PROTEAN_3_TRAIT)
	REMOVE_TRAIT(owner, TRAIT_QUICK_JUMP, PROTEAN_1_ADAPTATION_TRAIT)
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/vtr/predatory_legs)
