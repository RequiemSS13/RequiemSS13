
/datum/movespeed_modifier/slowpoke
	multiplicative_slowdown = 1

/datum/merit/flaw/slowpoke
	name = "Slowpoke"
	desc = "You move slower."
	dots = -3
	gain_text = "<span class='warning'>You feel slo-o-o-o-o-o-o-o-o-o-o-o-ow.</span>"
	lose_text = "<span class='notice'>You can feel a normal speed again.</span>"

/datum/merit/flaw/on_spawn()
	var/mob/living/carbon/H = merit_holder
	H.add_movespeed_modifier(/datum/movespeed_modifier/slowpoke)