/datum/discipline_power/vtr/vigor/four
	name = "Vigor 4"
	desc = "Become an unyielding machine for as long as your Vitae lasts."

	level = 4

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = DURATION_TURN

	var/datum/component/tackler

	grouped_powers = list(
		/datum/discipline_power/vtr/vigor/one,
		/datum/discipline_power/vtr/vigor/two,
		/datum/discipline_power/vtr/vigor/three,
		/datum/discipline_power/vtr/vigor/five
	)

/datum/discipline_power/vtr/vigor/four/activate()
	. = ..()
	owner.dna.species.punchdamagelow += 32
	owner.dna.species.punchdamagehigh += 32
	owner.dna.species.meleemod += 1.6
	owner.dna.species.attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'
	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 6, speed = 1, skill_mod = 0, min_distance = 0)

/datum/discipline_power/vtr/vigor/four/deactivate()
	. = ..()
	owner.dna.species.punchdamagelow -= 32
	owner.dna.species.punchdamagehigh -= 32
	owner.dna.species.meleemod -= 1.6
	owner.dna.species.attack_sound = initial(owner.dna.species.attack_sound)
	qdel(tackler)