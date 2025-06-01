/datum/discipline_power/vtr/nightmare/mortal_terror
	name = "Mortal Terror"
	desc = "Inflict such piquant horror into your victim that they suffer physical damage."

	level = 4

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SEE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 7
	cooldown_length = 1 MINUTES
	var/effect_time = 5 SECONDS
	var/base_damage = 15

	var/list/victims = list()

/datum/discipline_power/vtr/nightmare/mortal_terror/pre_activation_check_no_spend(mob/living/target)
	if(LAZYFIND(victims, target))
		to_chat(owner, span_warning("[target]'s has already been afflicted once tonight by your vision of true horror, and are steeled to it."))
		return FALSE
	return TRUE

/datum/discipline_power/vtr/nightmare/mortal_terror/activate(mob/living/carbon/human/target)
	. = ..()
	var/trait_bonus = (HAS_TRAIT(target, TRAIT_EMERSONIAN)?TRAIT_EMERSONIAN_MOD:0) + (HAS_TRAIT(target, TRAIT_PREGNABLE_MIND)?TRAIT_PREGNABLE_MIND_MOD:0)
	var/success_count = SSroll.opposed_roll(
		owner,
		target,
		dice_a = owner.get_wits() + discipline.level,
		dice_b = target.get_resolve() + target.get_potency() + trait_bonus,
		alert_atom = target,
		numerical = TRUE)

	target.playsound_local(get_turf(target), 'sound/magic/ethereal_enter.ogg', 100, FALSE)

	if(success_count <= 0)
		target.Jitter(5)
		to_chat(owner, span_warning("[target] resists the terror put onto them!"))
		to_chat(target, span_userdanger("You are faced with a dread beyond your reckoning, but push it away before it can take hold!"))
		return

	victims += target

	apply_discipline_affliction_overlay(target, "dementation", 1, 5 SECONDS)

	target.emote("scream")
	target.Jitter(60)

	if(success_count >= 2)
		ADD_TRAIT(target, TRAIT_BLIND, NIGHTMARE_5_TRAIT)
		target.update_blindness()
		addtimer(CALLBACK(src, PROC_REF(end_blindness), target), effect_time)

	if(success_count >= 3)
		addtimer(CALLBACK(src, PROC_REF(white_hair), target), effect_time)

	if(success_count >= 4 && (ishumanbasic(target) || isghoul(target)))
		var/datum/disease/heart_attack = new /datum/disease/heart_failure()
		target.ForceContractDisease(heart_attack, FALSE, TRUE)

	to_chat(target, span_userdanger("A vast fear rips through the thin skin of your mind, and every primal part of your mind screams in the base horror prey harbor for their predators."))
	target.adjustOrganLoss(ORGAN_SLOT_BRAIN, success_count * base_damage, 90)

/datum/discipline_power/vtr/nightmare/mortal_terror/proc/end_blindness(mob/living/carbon/human/target)
	REMOVE_TRAIT(target, TRAIT_BLIND, NIGHTMARE_5_TRAIT)
	target.update_blindness()

/datum/discipline_power/vtr/nightmare/mortal_terror/proc/white_hair(mob/living/carbon/human/target)
	to_chat(target, span_warning("The trauma of what you've experienced turns your hair stark white!"))
	target.hair_color = "#d8e9e6"
	target.update_body()
