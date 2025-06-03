/*
	Handles all related code for turning a human, 
	ghoul or revenant into a vampire. Will return
	TRUE if the Embrace Occurred, and FALSE if
	the embrace did not occur.
*/
/mob/living/carbon/human/proc/handle_embrace(mob/living/carbon/human/sire)
	if(!mind)
		to_chat(sire, "<span class='warning'>You need [src]'s mind to Embrace!</span>")
		return FALSE

	if((src.timeofdeath + 5 MINUTES) < world.time || HAS_TRAIT(sire, TRAIT_HALF_DAMNED_CURSE))
		to_chat(sire, "<span class='notice'>[src] doesn't respond to your Vitae.</span>")
		return FALSE
	
	sire.visible_message(
		span_warning("[sire] tries to feed [src] with their own blood!"), 
		span_notice("You started to feed [src] with your own blood."))

	if(!revive(full_heal = TRUE, admin_revive = TRUE))
		to_chat(sire, span_warning("[src] does not respond to the BLOOD."))
		return

	message_admins("[ADMIN_LOOKUPFLW(sire)] is Embracing [ADMIN_LOOKUPFLW(src)]!")

	grab_ghost(force = TRUE)
	to_chat(src, span_userdanger("You rise with a start, you're alive! Or not... You feel your soul going somewhere, as you realize you are embraced by a vampire..."))

	add_potency_mod(1, "Embrace")
	set_species(/datum/species/kindred)
	clane = new sire.clane.type()
	clane.on_gain(src)
	clane.post_gain(src)
	update_body()
	maxbloodpool = 10

	if(!iskindred(src))
		to_chat(sire, span_notice("[src] is totally <b>DEAD</b>!"))
		return FALSE
	
	INVOKE_ASYNC(src, PROC_REF(embrace_save_prompt), sire)
	
	return TRUE

/mob/living/carbon/human/proc/embrace_save_prompt(mob/living/carbon/human/sire)
	var/response_v = input(src, "Do you wish to keep being a vampire on your save slot?") in list("Yes", "No")
	if(response_v == "Yes")
		var/datum/preferences/prefs = client.prefs
		prefs.pref_species.id = "kindred"
		prefs.pref_species.name = "Vampire"
		prefs.clane = clane
		prefs.vamp_rank = VAMP_RANK_FLEDGLING
		prefs.discipline_types.Cut()
		prefs.discipline_levels.Cut()
		remove_potency_mod("Embrace")
		set_potency(1)
		for (var/i in 1 to length(prefs.clane.clane_disciplines))
			prefs.discipline_types += prefs.clane.clane_disciplines[i]
			prefs.discipline_levels.Add(0)
		SScharacter_connection.add_connection(CONNECTION_EMBRACE, src, sire)
		prefs.save_character()
	