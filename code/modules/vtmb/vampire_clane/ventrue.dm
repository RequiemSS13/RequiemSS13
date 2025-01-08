/datum/vampireclane/ventrue
	name = "Ventrue"
	desc = "The Ventrue are not called the Clan of Kings for nothing. Carefully choosing their progeny from mortals familiar with power, wealth, and influence, the Ventrue style themselves the aristocrats of the vampire world. Their members are expected to assume command wherever possible, and they’re willing to endure storms for the sake of leading from the front."
	curse = "Low-rank and animal blood is disgusting."
	clane_disciplines = list(
		/datum/discipline/dominate = 1,
		/datum/discipline/fortitude = 2,
		/datum/discipline/presence = 3
	)
	male_clothes = /obj/item/clothing/under/vampire/ventrue
	female_clothes = /obj/item/clothing/under/vampire/ventrue/female

/datum/discipline/dominate/post_gain(mob/living/carbon/human/H)
	if(level >= 1)
		var/obj/effect/proc_holder/spell/voice_of_god/S = new(H)
		H.mind.AddSpell(S)

//why does this exist twice? v. cringe - Hex
/datum/action/dominate
	name = "Dominate"
	desc = "Dominate over other living or un-living beings."
	button_icon_state = "dominate"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/cool_down = 0

/datum/action/dominate/Trigger()
	. = ..()
	if((cool_down + 5 SECONDS) >= world.time)
		return
	var/mob/living/carbon/human/player = owner
	if(HAS_TRAIT(player, TRAIT_MUTE))
		to_chat(player, "<span class='warning'>You find yourself unable to speak!</span>")
		return
	var/new_say = input(owner, "Choose the phrase to dominate:") as text|null
	if(new_say)
		for(var/mob/living/carbon/human/victim in ohearers(7, src))
			if(H)
				if(H.can_hear())
					var/mypower = player.vamp_age_rank-2+player.social
					var/theirpower = victim.vamp_age_rank-2+victim.mentality
					if(theirpower <= mypower)
						victim.cure_trauma_type(/datum/brain_trauma/severe/hypnotic_trigger, TRAUMA_RESILIENCE_BASIC)
						victim.gain_trauma(new /datum/brain_trauma/severe/hypnotic_trigger(new_say), TRAUMA_RESILIENCE_BASIC)
						victim.do_jitter_animation(30)
		owner.say("[new_say]")
