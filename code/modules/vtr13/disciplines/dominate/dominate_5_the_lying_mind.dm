/datum/discipline_power/vtr/dominate/the_lying_mind
	name = "The Lying Mind"
	desc = "Change a victim's memories."

	level = 5
	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_PLAYER|TARGET_LIVING|TARGET_SELF

	cooldown_length = 5 MINUTES
	range = 7
	vitae_cost = 3
	var/max_retry_recursion = 15
	var/guidelines = "On a successful roll, The Lying Mind allows you to make arbitrary edits to your target's memories, permanently. Your command can be as long as you like within the character limit, and may alter, remove, or create any number of memories. The Lying Mind cannot alter a character's emotions or relationships, only their memories of them. Their player decides how to interpret your alterations- please use clear, direct language for best effect. Their player can choose to reject your alteration for any reason- please ensure your alterations are not boring, uncomfortable, or against the rules. The text of your alterations are readable by staff. Please keep our consent guidelines in mind while using this power."
	var/player_consent = "If you consent to the alteration below, your character's memories will be permanently altered as described. You decide how to interpret the alterations, and how to roleplay their effects going forward. It does not directly alter your character's emotional state or emotional reactions to certain people or situations. Please only consent to this alteration if you are comfortable doing so and believe it would make for a more engaging roleplaying experience. If you do not consent to this alteration, it will appear as though it were a failed roll. You do not have to justify rejecting this alteration to anyone, including staff. Consenting to this command does not remove your ability to revoke consent later (whether in this round or after it) for any reason."
	var/current_command
	var/power_in_use = FALSE

/datum/discipline_power/vtr/dominate/the_lying_mind/pre_activation_check_no_spend(atom/target)
	if(power_in_use)
		to_chat(owner, span_warning("You are already attempting to dominate someone!"))
		return FALSE
	power_in_use = TRUE
	current_command = dominate_tgui_input_text(owner, guidelines, "Write an alteration to [target]'s memories:", "Dominate", null, MAX_MESSAGE_LEN, FALSE, FALSE)
	power_in_use = FALSE
	if(!current_command)
		to_chat(owner, span_warning("You think better of dominating [target]."))
		return FALSE

	return TRUE

/datum/discipline_power/vtr/dominate/the_lying_mind/pre_activation_checks(mob/living/carbon/human/target)
	to_chat(owner, span_warning("You attempt to command [target] to do your bidding."))

	log_admin("[owner] attempted to use Dominate [level] on [target]. Alteration: '[current_command]'")
	owner.dir = get_dir(owner, target)

	if(get_dir(target, owner) != target.dir && owner != target)
		to_chat(owner, span_warning("[target] must be facing you!"))
		return FALSE
	var/trait_bonus = (HAS_TRAIT(target, TRAIT_INDOMITABLE)?TRAIT_INDOMITABLE_MOD:0) + (HAS_TRAIT(target, TRAIT_SUSCEPTIBLE)?TRAIT_SUSCEPTIBLE_MOD:0)
	if(!SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_charisma() + discipline.level,
		dice_b = target.get_composure() + target.get_potency() + trait_bonus,
		alert_atom = target,
		show_player_a = FALSE,
		show_player_b = FALSE))
		current_command = null
		to_chat(owner, span_warning("[target] resists your command!"))
		do_cooldown(TRUE)
		owner.update_action_buttons()
		return FALSE
	return TRUE

/datum/discipline_power/vtr/dominate/the_lying_mind/activate(mob/living/carbon/human/target)
	. = ..()

	consent_ping(target)

	var/the_command = current_command
	current_command = null
	if(!consent_prompt(target, "[owner] is trying to rewrite your memories! Their changes:", "Memory Alteration Consent Form", player_consent, the_command))
		log_admin("[target] rejected consent for Dominate [level] from [owner]. Command: '[the_command]'")
		to_chat(target, span_notice("You do not consent to domination."))
		return
	to_chat(target, span_notice("You consent to domination. Consent may be retracted at any time."))
	log_admin("[target] was affected by Dominate [level] from [owner]. Command: '[the_command]'")

	playsound(target, 'code/modules/wod13/sounds/dominate.ogg', 100, FALSE)
	to_chat(target, span_userdanger("Your mind has been altered: [the_command]"))

	apply_discipline_affliction_overlay(target, "dominate", 2, 5 SECONDS)
