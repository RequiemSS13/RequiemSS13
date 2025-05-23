/obj/effect/decal/summon_marker
	name = "Summon Location"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/image/summon_image
	var/list/clients = list()
	var/mob/living/target

/obj/effect/decal/summon_marker/New(loc, mob/living/summoner, mob/living/target)
	..()

/obj/effect/decal/summon_marker/Initialize(loc, mob/living/summoner, mob/living/target)
	. = ..()

	if(!summoner?.client || !target?.client)
		return INITIALIZE_HINT_QDEL

	summon_image = image('icons/effects/cult_effects.dmi', src, "shield-cult", TURF_DECAL_LAYER)
	summoner.client.images |= summon_image
	target.client.images |= summon_image

	clients += summoner.client
	clients += target.client

	src.target = target

/obj/effect/decal/summon_marker/Destroy(force)
	for(var/client/client in clients)
		client.images -= summon_image
	. = ..()
