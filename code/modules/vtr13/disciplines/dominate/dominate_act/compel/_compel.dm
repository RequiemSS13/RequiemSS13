//a list of this datum's children is collected in SSdominate_compulsion
/datum/dominate_act/compel
	phrase = "PLACEHOLDER COMPEL"
	activate_verb = "compel verb"

/datum/dominate_act/compel/apply_message(mob/living/target)
	to_chat(target, span_danger("You feel compelled to [activate_verb]."))