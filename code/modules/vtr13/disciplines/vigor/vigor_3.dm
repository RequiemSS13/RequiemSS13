/datum/discipline_power/vtr/vigor/three
	name = "Vigor 3"
	desc = "Become a force of destruction. Lift and break the unliftable and the unbreakable."

	level = 3

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = DURATION_TURN

	var/datum/component/tackler

	grouped_powers = list(
		/datum/discipline_power/vtr/vigor/one,
		/datum/discipline_power/vtr/vigor/two,
		/datum/discipline_power/vtr/vigor/four,
		/datum/discipline_power/vtr/vigor/five
	)

/datum/discipline_power/vtr/vigor/three/activate()
	. = ..()
	owner.dna.species.punchdamagelow += 24
	owner.dna.species.punchdamagehigh += 24
	owner.dna.species.meleemod += 1.2
	owner.dna.species.attack_sound = 'code/modules/wod13/sounds/heavypunch.ogg'
	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 5, speed = 1, skill_mod = 0, min_distance = 0)

/datum/discipline_power/vtr/vigor/three/deactivate()
	. = ..()
	owner.dna.species.punchdamagelow -= 24
	owner.dna.species.punchdamagehigh -= 24
	owner.dna.species.meleemod -= 1.2
	owner.dna.species.attack_sound = initial(owner.dna.species.attack_sound)
	qdel(tackler)