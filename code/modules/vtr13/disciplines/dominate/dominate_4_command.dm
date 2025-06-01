/datum/discipline_power/vtr/dominate/command
	name = "Command"
	desc = "Quickly compel a victim to obey with a short verbal command."
	level = 4
	range = 7
	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING|TARGET_SELF
	cooldown_length = 20 SECONDS
	var/datum/action/select_command_button/select_command_button = null
	var/datum/dominate_act/selected_command

/datum/discipline_power/vtr/dominate/command/post_gain()
	selected_command = SSdominate_compulsion.compel_list["Think Twice!"]
	select_command_button = new(owner, src)
	select_command_button.Grant(owner)

/datum/discipline_power/vtr/dominate/command/activate(mob/living/target)
	. = ..()
	playsound(target, 'code/modules/wod13/sounds/dominate.ogg', 100, FALSE)
	owner.say(selected_command.phrase)
	var/trait_bonus = (HAS_TRAIT(target, TRAIT_INDOMITABLE)?TRAIT_INDOMITABLE_MOD:0) + (HAS_TRAIT(target, TRAIT_SUSCEPTIBLE)?TRAIT_SUSCEPTIBLE_MOD:0)
	if(!SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_charisma() + discipline.level,
		dice_b = target.get_composure() + target.get_potency() + trait_bonus,
		alert_atom = target,
		show_player_a = FALSE,
		show_player_b = FALSE))
		to_chat(owner, span_warning("[target] resists your command!"))
		return
	if(!selected_command.can_attach(target))
		return
	target.AddElement(/datum/element/compulsion, owner, selected_command)
