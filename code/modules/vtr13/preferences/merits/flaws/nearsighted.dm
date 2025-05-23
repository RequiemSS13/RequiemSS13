/datum/merit/flaw/badvision
	name = "Nearsighted"
	desc = "Your eye illness somehow did not become cured after the Embrace, and you need to wear perception glasses."
	dots = -1
	gain_text = "<span class='danger'>Things far away from you start looking blurry.</span>"
	lose_text = "<span class='notice'>You start seeing faraway things normally again.</span>"

/datum/merit/flaw/badvision/add()
	merit_holder.become_nearsighted(ROUNDSTART_TRAIT)

/datum/merit/flaw/badvision/on_spawn()
	var/mob/living/carbon/human/H = merit_holder
	var/obj/item/clothing/glasses/vampire/perception/glasses = new(get_turf(H))
	if(!H.equip_to_slot_if_possible(glasses, ITEM_SLOT_EYES, bypass_equip_delay_self = TRUE))
		H.put_in_hands(glasses)
