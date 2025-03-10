/datum/discipline_power/vtr/vigor/two
	name = "Vigor 2"
	desc = "Become powerful beyond your muscles. Wreck people and things."

	level = 2

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = DURATION_TURN

	var/datum/component/tackler

	grouped_powers = list(
		/datum/discipline_power/vtr/vigor/one,
		/datum/discipline_power/vtr/vigor/three,
		/datum/discipline_power/vtr/vigor/four,
		/datum/discipline_power/vtr/vigor/five
	)

/datum/discipline_power/vtr/vigor/two/activate()
	. = ..()
	owner.dna.species.punchdamagelow += 16
	owner.dna.species.punchdamagehigh += 16
	owner.dna.species.meleemod += 0.8
	owner.dna.species.attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'
	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 4, speed = 1, skill_mod = 0, min_distance = 0)

/datum/discipline_power/vtr/vigor/two/deactivate()
	. = ..()
	owner.dna.species.punchdamagelow -= 16
	owner.dna.species.punchdamagehigh -= 16
	owner.dna.species.meleemod -= 0.8
	owner.dna.species.attack_sound = initial(owner.dna.species.attack_sound)
	qdel(tackler)