/datum/job/vamp/vtr
	var/minimum_vamp_rank = 0	//minimum vampire rank for a position
	var/endorsement_required = FALSE	//does this job work with the endorsement system

/datum/job/vamp/vtr/after_spawn(mob/living/H, mob/M, latejoin = FALSE)
	. = ..()
	var/list/gear_leftovers

	var/mob/living/carbon/human/spawnee = H

	if(M.client && (M.client.prefs.equipped_gear && length(M.client.prefs.equipped_gear)))
		for(var/gear in M.client.prefs.equipped_gear)
			var/datum/gear/G = SSloadout.gear_datums[gear]
			if(G)
				var/permitted = FALSE

				if(G.allowed_roles && H.mind && (H.mind.assigned_role in G.allowed_roles))
					permitted = TRUE
				else if(!G.allowed_roles)
					permitted = TRUE
				else
					permitted = FALSE

				if(G.splat_blacklist && (spawnee.dna.species.id in G.splat_blacklist))
					permitted = FALSE

				if(G.splat_whitelist && !(spawnee.dna.species.id in G.splat_whitelist))
					permitted = FALSE

				if(!permitted)
					to_chat(M, span_warning("Your current species or role does not permit you to spawn with [gear]!"))
					continue
				if(G.slot)
					var/item = G.spawn_item(null, H)
					if(!H.equip_to_slot_or_del(item, G.slot, TRUE))
						LAZYADD(gear_leftovers, G)
				else
					LAZYADD(gear_leftovers, G)
			else
				M.client.prefs.equipped_gear -= gear

	if(length(gear_leftovers))
		for(var/datum/gear/G in gear_leftovers)
			var/item = G.spawn_item(null, H)
			var/atom/placed_in = spawnee.equip_to_slot_if_possible(item, disable_warning = TRUE)

			if(istype(placed_in))
				if(isturf(placed_in))
					to_chat(M, span_notice("Placing [G.display_name] on [placed_in]!"))
				else
					to_chat(M, span_notice("Placing [G.display_name] in [placed_in.name]]"))
				continue

			if(H.put_in_hands(item))
				to_chat(M, span_notice("Placing [G.display_name] in your hands!"))
				continue

			if(H.equip_to_slot_if_possible(item, ITEM_SLOT_BACKPACK, TRUE))
				to_chat(M, span_notice("Placing [G.display_name] in your backpack!"))
				continue

			to_chat(M, span_danger("Failed to locate a storage object on your mob, either you spawned with no hands free and no backpack or this is a bug."))
			qdel(item)
	qdel(gear_leftovers)