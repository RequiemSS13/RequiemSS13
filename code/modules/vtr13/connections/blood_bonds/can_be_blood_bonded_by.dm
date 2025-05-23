/datum/character_connection_type/blood_bond/proc/can_be_blood_bonded_by(mob/living/thrall, mob/living/domitor)

	if(!thrall || !thrall.mind)
		return FALSE

	if(!domitor || !domitor.mind)
		to_chat(domitor, "<span class='warning'>You are mindless???????</span>")
		return FALSE

	if(!iskindred(domitor))
		to_chat(domitor, "<span class='warning'>You are not a vampire????</span>")
		return FALSE

	//is the thrall already in a level three blood bond?
	if(!SScharacter_connection.check_level_three_blood_bonds(thrall))
		to_chat(thrall, "<span class='warning'>Your deep devotion to your Regent prevents a blood bond from forming.</span>")
		return FALSE

	if(SScharacter_connection.check_mutual_blood_bonds_made_this_round(thrall, domitor))
		to_chat(domitor, "<span class='warning'>You have already forged a blood bond with [thrall] this night.</span>")
		return FALSE

	return TRUE
