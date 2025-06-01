//Changes how a mob appears on the hud
//I removed this from the life proc because it has enough going on?
//You can't see intent changes anymore for humans, sorry not sorry
//Update manually on player embrace/ghouling
/mob/living/carbon/proc/update_auspex_hud_vtr()
	var/image/holder = hud_list[GLAND_HUD]
	var/icon/I = icon(icon, icon_state, dir)
	holder.pixel_y = I.Height() - world.icon_size
	holder.icon_state = "aura"

	if (client || isnpc(src))
		holder.color = "#0000ff"

	if (iskindred(src))
		//pale aura for vampires
		holder.color = "#ffffff"
		//only Baali can get antifrenzy through selling their soul, so this gives them the unholy halo
		if (antifrenzy)
			holder.icon = 'icons/effects/32x64.dmi'

	if(iscathayan(src))
		var/mob/living/carbon/human/H = src
		if(!H.check_kuei_jin_alive())
			holder.color = "#ffffff"

	if (isgarou(src) || iswerewolf(src))
		//garou have bright auras due to their spiritual potence
		holder.icon_state = "aura_bright"

	if (isghoul(src))
		//Pale spots in the aura, had to be done manually since holder.color will show only a type of color
		holder.overlays = null
		holder.color = null
		holder.icon_state = "aura_ghoul"

	if(mind?.holy_role >= HOLY_ROLE_PRIEST)
		holder.color = "#ffe12f"
		holder.icon_state = "aura"