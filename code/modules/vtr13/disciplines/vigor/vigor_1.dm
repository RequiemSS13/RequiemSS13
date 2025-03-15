/datum/discipline_power/vtr/vigor/one
	name = "Vigor 1"
	desc = "Enhance your muscles. Never hit softly."

	level = 1

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = DURATION_TURN

	var/datum/component/tackler

	grouped_powers = list(
		/datum/discipline_power/vtr/vigor/two,
		/datum/discipline_power/vtr/vigor/three,
		/datum/discipline_power/vtr/vigor/four,
		/datum/discipline_power/vtr/vigor/five
	)

/datum/discipline_power/vtr/vigor/one/activate()
	. = ..()
	owner.dna.species.punchdamagelow += 8
	owner.dna.species.punchdamagehigh += 8
	owner.dna.species.meleemod += 0.4
	owner.dna.species.attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'
	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 3, speed = 1, skill_mod = 0, min_distance = 0)

/datum/discipline_power/vtr/vigor/one/deactivate()
	. = ..()
	owner.dna.species.punchdamagelow -= 8
	owner.dna.species.punchdamagehigh -= 8
	owner.dna.species.meleemod -= 0.4
	owner.dna.species.attack_sound = initial(owner.dna.species.attack_sound)
	qdel(tackler)