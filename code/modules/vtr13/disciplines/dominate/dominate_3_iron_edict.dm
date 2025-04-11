/datum/discipline_power/vtr/dominate/iron_edict
	name = "Iron Edict"
	desc = "Force your victim to do your bidding, with a complex command."

	level = 3

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_PLAYER|TARGET_LIVING|TARGET_SELF

	cooldown_length = 5 MINUTES
	range = 7
	vitae_cost = 3
	var/max_retry_recursion = 15
	var/guidelines = "On a successful roll, Iron Edict compels your target to follow a single command until it is completed, the night ends, or they are injured. Your command can be as long as you like within the character limit, and may be detailed and complex, but should be a single command. Their player decides how they interpret your command and when it is complete- please use clear, direct language for best effect. Their player can choose to reject your command for any reason- please ensure your command is not boring, uncomfortable, or against the rules. You cannot alter memories with this power, though you can force your target to act as though their memories were different. The text of your command is readable by staff. Please keep our consent guidelines in mind while using this power."
	var/player_consent = "If you consent to the command below, your character will be compelled to obey it until they are injured or the command is complete. You decide how to interpret the command and when it is complete. Please only consent to this command if you are comfortable doing so and believe it would make for a more engaging roleplaying experience. If you do not consent to this command, it will appear as though it were a failed roll. You do not have to justify rejecting this command to anyone, including staff. Consenting to this command does not remove your ability to revoke consent later for any reason."
	var/current_command
	var/power_in_use = FALSE
	var/char_limit_multiplier = 50

/datum/discipline_power/vtr/dominate/iron_edict/pre_activation_check_no_spend(atom/target)
	if(power_in_use)
		to_chat(owner, span_warning("You are already attempting to dominate someone!"))
		return FALSE
	power_in_use = TRUE
	var/char_limit = char_limit_multiplier * discipline.level
	current_command = dominate_tgui_input_text(owner, guidelines, "Write a command ([char_limit] character limit):", "Command", null, char_limit, FALSE, FALSE)
	power_in_use = FALSE
	if(!current_command)
		to_chat(owner, span_warning("You think better of dominating [target]."))
		return FALSE
	
	return TRUE

/datum/discipline_power/vtr/dominate/iron_edict/pre_activation_checks(mob/living/target)
	to_chat(owner, span_warning("You attempt to command [target] to do your bidding."))

	log_admin("[owner] attempted to use Dominate [level] on [target]. Command: '[current_command]'")

	owner.say(current_command)
	owner.dir = get_dir(owner, target)

	if(get_dir(target, owner) != target.dir && owner != target)
		to_chat(owner, span_warning("[target] must be facing you!"))
		return FALSE

	if(!SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_total_social() + discipline.level,
		dice_b = target.get_total_social() + target.get_total_blood(), 
		alert_atom = target,
		show_player_a = FALSE,
		show_player_b = FALSE))
		current_command = null
		to_chat(owner, span_warning("[target] resists your command!"))
		do_cooldown(TRUE)
		owner.update_action_buttons()
		return FALSE
	
	return TRUE

/datum/discipline_power/vtr/dominate/iron_edict/activate(mob/living/carbon/human/target)
	. = ..()

	
	consent_ping(target)

	var/the_command = current_command
	current_command = null
	if(!consent_prompt(target, "[owner] is trying to dominate you!", "Dominate Consent Form", player_consent, the_command))
		log_admin("[target] rejected consent for Dominate [level] from [owner]. Command: '[the_command]'")
		to_chat(target, span_notice("You do not consent to domination."))
		return
	to_chat(target, span_notice("You consent to domination. Consent may be retracted at any time."))
	log_admin("[target] was affected by Dominate [level] from [owner]. Command: '[the_command]'")

	playsound(target, 'code/modules/wod13/sounds/dominate.ogg', 100, FALSE)
	
	to_chat(target, span_userdanger("You are compelled to obey the following command: [the_command]"))
	
	apply_discipline_affliction_overlay(target, "dominate", 2, 5 SECONDS)