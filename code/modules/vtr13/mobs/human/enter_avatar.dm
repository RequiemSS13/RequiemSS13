/mob/living/carbon/human/proc/enter_avatar()
	RETURN_TYPE(/mob/dead/observer/avatar)

	stop_sound_channel(CHANNEL_HEARTBEAT)
	var/mob/dead/observer/avatar/auspex_avatar = new(src)

	SStgui.on_transfer(src, auspex_avatar)
	auspex_avatar.icon = src.icon
	auspex_avatar.overlays = src.overlays
	auspex_avatar.key = key
	auspex_avatar.client.init_verbs()
	auspex_avatar.client = src.client
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_GHOSTEARS
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_GHOSTWHISPER
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_GHOSTSIGHT
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_GHOSTRADIO
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_GHOSTPDA
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_GHOSTLAWS
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_LOGIN_LOGOUT
	auspex_avatar.client.prefs.chat_toggles &= ~CHAT_DEAD

	auspex_avatar.overlay_fullscreen("film_grain", /atom/movable/screen/fullscreen/film_grain, rand(1, 9))

	return auspex_avatar
