/datum/discipline_power/vtr/majesty/entrancement
	name = "Entrancement"
	desc = "Make a victim trust you implicitly, weakening them to your other powers."
	level = 2
	toggled = TRUE 	//Effect keeps going once on
	cooldown_length = 1 MINUTES
	duration_length = 30 MINUTES
	var/entrancement_range = 1
	var/list/players_affected
	var/player_consent = "If you consent to this power, you will be bound by loyalty and affection to the person using it as though they were a very close friend. This does not inherently compel you to do anything, and our consent rules continue to apply. If you do not consent to this command, it will appear as though a failed roll. You do not have to justify rejecting this command to anyone, including staff. Consenting to this command does not remove your ability to revoke consent later for any reason."

/datum/discipline_power/vtr/majesty/entrancement/post_gain()
	if(discipline.level >= 5)
		entrancement_range = 3
	else if(discipline.level >= 4)
		entrancement_range = 2

/datum/discipline_power/vtr/majesty/entrancement/activate()
	. = ..()
	for(var/mob/living/target in viewers(entrancement_range,owner) - owner)
		if(LAZYFIND(players_affected, target))
			continue

		to_chat(target, "[owner] becomes immensely fascinating.")
		if(!SSroll.opposed_roll(
			owner,
			target,
			dice_a = owner.get_total_charisma() + discipline.level,
			dice_b = target.get_total_composure() + target.blood_potency,
			alert_atom = target,
			show_player_a = FALSE,
			show_player_b = FALSE))
			continue

		consent_ping(target)
		if(!consent_prompt(target, "", "Majesty Consent Form", player_consent, "You begin to find [owner] captivating!"))
			log_admin("[owner] used Majesty [level] on [target], who did not consent.")
			continue

		to_chat(target, "<span class='userlove'>You feel like [owner] is a wonderful friend. You trust them completely and feel safe in their presence.</span>")

		ADD_TRAIT(target, TRAIT_CHARMED, owner)
		target.balloon_alert(owner, "<span style='color: #cc33ff;'>+ CHARMED</span>")
		target.balloon_alert(target, "<span style='color: #cc33ff;'>+ CHARMED</span>")

		log_admin("[owner] used Majesty [level] on [target].")

		LAZYADD(players_affected, target)
		target.playsound_local(owner, activate_sound, 50, FALSE)

		apply_discipline_affliction_overlay(target, "presence", 1, 5 SECONDS)

/datum/discipline_power/vtr/majesty/entrancement/deactivate()
	. = ..()
	for(var/mob/living/target in players_affected)
		to_chat(target, "<span class='userlove'>[owner] slowly begins to feel less perfect as your loyalty to them fades.</span>")
		players_affected -= target
		REMOVE_TRAIT(target, TRAIT_CHARMED, owner)
		target.balloon_alert(owner, "<span style='color: ##33cccc;'>- CHARMED</span>")
		target.balloon_alert(target, "<span style='color: ##33cccc;'>- CHARMED</span>")
