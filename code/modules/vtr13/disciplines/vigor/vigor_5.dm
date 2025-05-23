/datum/discipline_power/vtr/vigor/five
	name = "Vigor 5"
	desc = "The people could worship you as a god if you showed them this."

	level = 5

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 2 TURNS

	var/datum/component/tackler

	grouped_powers = list(
		/datum/discipline_power/vtr/vigor/one,
		/datum/discipline_power/vtr/vigor/two,
		/datum/discipline_power/vtr/vigor/three,
		/datum/discipline_power/vtr/vigor/four
	)

/datum/discipline_power/vtr/vigor/five/activate()
	. = ..()
	owner.dna.species.punchdamagelow += 40
	owner.dna.species.punchdamagehigh += 40
	owner.dna.species.meleemod += 2
	owner.dna.species.attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'
	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 7, speed = 1, skill_mod = 0, min_distance = 0)

/datum/discipline_power/vtr/vigor/five/deactivate()
	. = ..()
	owner.dna.species.punchdamagelow -= 40
	owner.dna.species.punchdamagehigh -= 40
	owner.dna.species.meleemod -= 2
	owner.dna.species.attack_sound = initial(owner.dna.species.attack_sound)
	qdel(tackler)