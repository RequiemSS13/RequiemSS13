
/mob/living/carbon/human/proc/vamp_bite()
	//the code below is directly imported from onyxcombat.dm's /atom/movable/screen/drinkblood/Click() proc	
	src.update_blood_hud()
	if(world.time < src.last_drinkblood_use+30)
		return
	if(world.time < src.last_drinkblood_click+10)
		return
	src.last_drinkblood_click = world.time
	if(src.grab_state > GRAB_PASSIVE)
		if(ishuman(src.pulling))
			var/mob/living/carbon/human/PB = src.pulling
			if(isghoul(src))
				if(!iskindred(PB))
					SEND_SOUND(src, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(src, "<span class='warning'>Eww, that is <b>GROSS</b>.</span>")
					return
			if(!isghoul(src) && !iskindred(src))
				SEND_SOUND(src, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>Eww, that is <b>GROSS</b>.</span>")
				return
			if(PB.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>This creature is <b>DEAD</b>.</span>")
				return
			if(PB.bloodpool <= 0 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>There is no <b>BLOOD</b> in this creature.</span>")
				return
			if(iskindred(src))
				PB.emote("groan")
			if(isghoul(src))
				PB.emote("scream")
			PB.add_bite_animation()
		if(isliving(src.pulling))
			if(!iskindred(src))
				SEND_SOUND(src, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>Eww, that is <b>GROSS</b>.</span>")
				return
			var/mob/living/LV = src.pulling
			if(LV.bloodpool <= 0 && (!iskindred(src.pulling) || !iskindred(src)))
				SEND_SOUND(src, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>There is no <b>BLOOD</b> in this creature.</span>")
				return
			if(LV.stat == DEAD && !HAS_TRAIT(src, TRAIT_GULLET))
				SEND_SOUND(src, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>This creature is <b>DEAD</b>.</span>")
				return
			var/skipface = (src.wear_mask && (src.wear_mask.flags_inv & HIDEFACE)) || (src.head && (src.head.flags_inv & HIDEFACE))
			if(!skipface)
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					playsound(src, 'code/modules/wod13/sounds/drinkblood1.ogg', 50, TRUE)
					LV.visible_message("<span class='warning'><b>[src] bites [LV]'s neck!</b></span>", "<span class='warning'><b>[src] bites your neck!</b></span>")
				if(!HAS_TRAIT(src, TRAIT_BLOODY_LOVER))
					if(src.CheckEyewitness(LV, src, 7, FALSE))
						src.AdjustMasquerade(-1)
				else
					playsound(src, 'code/modules/wod13/sounds/kiss.ogg', 50, TRUE)
					LV.visible_message("<span class='italics'><b>[src] kisses [LV]!</b></span>", "<span class='userlove'><b>[src] kisses you!</b></span>")
				src.drinksomeblood(LV, TRUE)