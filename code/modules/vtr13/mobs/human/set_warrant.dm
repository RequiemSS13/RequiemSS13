/mob/living/carbon/human/proc/set_warrant(fail_check = TRUE, fail_text, sound = 'code/modules/wod13/sounds/suspect.ogg')
	if(!src.warrant && !src.ignores_warrant && fail_check)
		SEND_SOUND(src, sound('code/modules/wod13/sounds/suspect.ogg', 0, 0, 75))
		to_chat(src, "<span class='userdanger'><b>WARRANT ISSUED</b></span>")
		src.warrant = TRUE
	else if (!fail_check && fail_text)
		SEND_SOUND(src, sound('code/modules/wod13/sounds/sus.ogg', 0, 0, 75))
		to_chat(src, "<span class='userdanger'><b>[fail_text]</b></span>")
