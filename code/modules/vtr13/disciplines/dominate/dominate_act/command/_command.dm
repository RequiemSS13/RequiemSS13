//a list of this datum's children is collected in SSdominate_compulsion
/datum/dominate_act/command
	phrase = "PLACEHOLDER COMMAND"
	activate_verb = "command verb"

/datum/dominate_act/command/apply_message(mob/living/target)
	to_chat(target, span_danger("You feel forced to [activate_verb]."))