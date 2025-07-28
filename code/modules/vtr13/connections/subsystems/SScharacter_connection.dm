/*
	Subsystem for handling character connections.
	All character connection stuff should try to use this subsystem and its
	multitude of procs as an intermediary.
*/
SUBSYSTEM_DEF(character_connection)
	name = "Character Connections"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_ATOMS

	//list of /datum/character_connection_type datums
	var/list/connection_type_list = list()

	var/list/endorsement_connection_list = list()

	var/list/boon_connection_list = list()

	//List of connection types that do not need to be loaded into our global list
	var/list/exception_types = list(
		/datum/character_connection_type,
		/datum/character_connection_type/endorsement,
		/datum/character_connection_type/boon)

/datum/controller/subsystem/character_connection/Initialize()
	for(var/character_connection_type in (typesof(/datum/character_connection_type) - exception_types))
		var/datum/character_connection_type/connection_type = new character_connection_type()
		if(connection_type_list["[connection_type.name]"])
			CRASH("Two connection_type_list classes of the same name exist on [connection_type.name]! Not allowed!")
		connection_type_list["[connection_type.name]"] = connection_type

		//custom handling for endorsement populaton
		if(istype(connection_type, /datum/character_connection_type/endorsement))
			var/datum/character_connection_type/endorsement/endorsement_connection = connection_type

			if(endorsement_connection.required_faction)
				if(!endorsement_connection_list["[endorsement_connection.required_faction]"])
					endorsement_connection_list["[endorsement_connection.required_faction]"] = list()
				endorsement_connection_list["[endorsement_connection.required_faction]"]["[endorsement_connection.name]"] = endorsement_connection
			else
				if(!endorsement_connection_list["Other"])
					endorsement_connection_list["Other"] = list()
				endorsement_connection_list["Other"]["[endorsement_connection.name]"] = endorsement_connection

		//custom handling for boon population
		else if(istype(connection_type, /datum/character_connection_type/boon))
			var/datum/character_connection_type/boon/boon_connection = connection_type
			boon_connection_list["[boon_connection.name]"] = boon_connection

	return ..()

/datum/controller/subsystem/character_connection/proc/get_character_connection_type(name)
	return connection_type_list[name]

/datum/controller/subsystem/character_connection/proc/add_connection(connection_type_name, mob/living/player_a, mob/living/player_b, ...)
	var/datum/character_connection_type/connection_type = get_character_connection_type(connection_type_name)
	if(!connection_type)
		CRASH("Tried to create a connection of type [connection_type_name] and it wasn't loaded!")

	var/response = connection_type.add_connection(arglist(args.Copy(2)))

	if(player_a.mind)
		player_a.mind.character_connections = SScharacter_connection.get_character_connections(player_a.ckey, player_a.real_name)

	if(player_b.mind)
		player_b.mind.character_connections = SScharacter_connection.get_character_connections(player_b.ckey, player_b.real_name)

	return response


/datum/controller/subsystem/character_connection/proc/setup_character_connection_verbs(mob/living/carbon/human/new_player)
	if(iskindred(new_player))
		//handle faction head endorsements
		if(new_player.vamp_rank >= VAMP_RANK_NEONATE && new_player.vtr_faction?.name && endorsement_connection_list[new_player.vtr_faction.name])
			add_verb(new_player, /datum/controller/subsystem/character_connection/verb/request_endorsement)
			add_verb(new_player, /datum/controller/subsystem/character_connection/verb/offer_endorsement)
		add_verb(new_player, /datum/controller/subsystem/character_connection/verb/request_boon)
		add_verb(new_player, /datum/controller/subsystem/character_connection/verb/offer_boon)