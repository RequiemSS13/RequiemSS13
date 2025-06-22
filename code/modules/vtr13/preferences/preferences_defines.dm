/datum/preferences
	var/client/parent
//---------Non Preference Vars---------
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 20
	var/current_tab = PREFS_CHARACTER_SETTINGS_TAB
	var/merit_sub_tab = PREFS_MERITS_TAB
	var/muted = 0
	var/last_ip
	var/last_id
	var/db_flags
	var/allow_midround_antag = 1
	var/slot_randomized					//keeps track of round-to-round randomization of the character slot, prevents overwriting
	var/list/skin_tone_presets = list(	//Preset skintones for character selection
		"Warm Light 1" = WARMLIGHT1,
		"Warm Light 2" = WARMLIGHT2,
		"Warm Light 3" = WARMLIGHT3,
		"Warm Medium 1" = WARMMED1,
		"Warm Medium 2" = WARMMED2,
		"Warm Medium 3" = WARMMED3,
		"Warm Dark 1" = WARMDARK1,
		"Warm Dark 2" = WARMDARK2,
		"Warm Dark 3" = WARMDARK3,
		"Neutral Light 1" = NEUTRALLIGHT1,
		"Neutral Light 2" = NEUTRALLIGHT2,
		"Neutral Light 3" = NEUTRALLIGHT3,
		"Neutral Medium 1" = NEUTRALMED1,
		"Neutral Medium 2" = NEUTRALMED2,
		"Neutral Medium 3" = NEUTRALMED3,
		"Neutral Dark 1" = NEUTRALDARK1,
		"Neutral Dark 2" = NEUTRALDARK2,
		"Neutral Dark 3" = NEUTRALDARK3,
		"Cool Light 1" = COOLLIGHT1,
		"Cool Light 2" = COOLLIGHT2,
		"Cool Light 3" = COOLLIGHT3,
		"Cool Medium 1" = COOLMED1,
		"Cool Medium 2" = COOLMED2,
		"Cool Medium 3" = COOLMED3,
		"Cool Dark 1" = COOLDARK1,
		"Cool Dark 2" = COOLDARK2,
		"Cool Dark 3" = COOLDARK3,
		"Unnatural Alabaster" = UNNATURALALABASTER,
		"Unnatural Smoke" = UNNATURALSMOKE,
		"Unnatural Ash" = UNNATURALASH,
		"Unnatural Light Green" = UNNATURALLGREEN,
		"Unnatural Dark Green" = UNNATURALDGREEN,
		"Unnatural Light Blue" = UNNATURALLBLUE,
		"Unnatural Dark Blue" = UNNATURALDBLUE)

	var/list/features = list(			//stuck around only by merit of DNA code needing it
		"mcolor" = "FFF",
		"ethcolor" = "9c3030",
		"tail_lizard" = "Smooth",
		"tail_human" = "None",
		"snout" = "Round", "horns" = "None",
		"ears" = "None", "wings" = "None",
		"frills" = "None", "spines" = "None",
		"body_markings" = "None",
		"legs" = "Normal Legs",
		"moth_wings" = "Plain",
		"moth_antennae" = "Plain",
		"moth_markings" = "None")

	var/list/randomise = list(			//randomizer list for bodyparts, lives by merit of being used for a single function
		RANDOM_UNDERWEAR = TRUE,
		RANDOM_UNDERWEAR_COLOR = TRUE,
		RANDOM_UNDERSHIRT = TRUE,
		RANDOM_SOCKS = TRUE,
		RANDOM_BACKPACK = TRUE,
		RANDOM_JUMPSUIT_STYLE = TRUE,
		RANDOM_HAIRSTYLE = TRUE,
		RANDOM_HAIR_COLOR = TRUE,
		RANDOM_FACIAL_HAIRSTYLE = TRUE,
		RANDOM_FACIAL_HAIR_COLOR = TRUE,
		RANDOM_SKIN_TONE = TRUE,
		RANDOM_EYE_COLOR = TRUE)
	var/phobia = "spiders"				//Stuck around by merit of me not wanting to get rid of phobia code
	var/hardcore_survival_score = 0		//Stores the amount of points for TG code stuff we need to get rid of eventually.

	var/list/all_quirks					//replaced by merits system, kept around because it's referenced by base quirk code, which I don't want to remove yet

	var/character_dots = 0				//Replacement for XP; calculated dynamically based on character choices
	var/discipline_dots = 0
	var/merit_dots = 0
	var/loadout_dots = 0

	var/show_loadout = TRUE
	var/gear_tab = "General"
	var/loadout_dots_max = 0

	var/loadout_slots = 0
	var/loadout_slots_max = 0

//---------In-Round-Only-Preferences---------
	var/action_buttons_screen_locs = list()	//sets up the locations of buttons on the screen. Resets each round

//---------GAME PREFERENCES---------
	var/asaycolor = "#ff4500"			//This won't change the color for current admins, only incoming ones.
	var/ooccolor = "#c43b23"
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	var/UI_style = null
	var/hotkeys = TRUE

	///Runechat preference. If true, certain messages will be displayed on the map, not ust on the chat area. Boolean.
	var/chat_on_map = TRUE
	///Limit preference on the size of the message. Requires chat_on_map to have effect.
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	///Whether non-mob messages will be displayed, such as machine vendor announcements. Requires chat_on_map to have effect. Boolean.
	var/see_chat_non_mob = TRUE
	///Whether emotes will be displayed on runechat. Requires chat_on_map to have effect. Boolean.
	var/see_rc_emotes = TRUE
	///If we want to broadcast deadchat connect/disconnect messages
	var/broadcast_login_logout = TRUE
	var/tgui_fancy = TRUE
	var/tgui_input_mode = TRUE // All the Input Boxes (Text,Number,List,Alert)
	var/tgui_large_buttons = TRUE
	var/tgui_swapped_buttons = FALSE
	var/tgui_lock = FALSE
	var/buttons_locked = FALSE
	var/windowflashing = TRUE
	//Antag preferences
	var/list/be_special = list()		//Special role selection

	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/toggles = TOGGLES_DEFAULT

	//ghost prefs
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/preferred_map = null
	var/list/ignoring = list()
	var/uses_glasses_colour = 0
	var/clientfps = -1
	var/parallax
	var/ambientocclusion = TRUE
	///Should we automatically fit the viewport?
	var/auto_fit_viewport = FALSE
	///Should we be in the widescreen mode set by the config?
	var/widescreenpref = TRUE
	///What size should pixels be displayed as? 0 is strech to fit
	var/pixel_size = 0
	///What scaling method should we use? Distort means nearest neighbor
	var/scaling_method = SCALING_METHOD_DISTORT
	var/list/menuoptions
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds
	var/pda_style = MONO
	var/pda_color = "#808000"
	var/list/key_bindings = list()
	///If we have a hearted commendations, we honor it every time the player loads preferences until this time has been passed
	var/hearted_until
	///Someone thought we were nice! We get a little heart in OOC until we join the server past the below time (we can keep it until the end of the round otherwise)
	var/hearted

//===========GENERAL===========
	var/datum/species/pref_species = new /datum/species/human()	//Mutant race
	var/info_known = INFO_KNOWN_UNKNOWN
	var/gender = MALE					//gender of character (well duh)
	var/real_name						//our character's name
	var/body_type 						// Agendered spessmen can choose whether to have a male or female bodytype
	var/age = 30						//biological age of character
	var/flavor_text
	var/ooc_notes
	var/headshot_link
	var/hair_color = "000"				//Hair color
	var/facial_hair_color = "000"		//Facial hair color
	var/hairstyle = "Bald"				//Hair type
	var/facial_hairstyle = "Shaved"		//Face hair type
	var/eye_color = "000"				//Eye color
	var/skin_tone = NEUTRALMED2			//Skin color
	var/underwear = "Nude"				//underwear type
	var/underwear_color = "000"			//underwear color
	var/undershirt = "Nude"				//undershirt type
	var/socks = "Nude"					//socks type
	var/backpack = DBACKPACK			//backpack type
	var/persistent_scars = TRUE			/// If we have persistent scars enabled
	var/reason_of_death = "None"

	var/joblessrole = BERANDOMJOB		//defaults to BERANDOMJOB for fewer assistants
	var/list/job_preferences = list()	//Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/alt_titles_preferences = list()



	//Merits list
	var/list/all_merits = list()
	var/list/merit_custom_settings = list()

	var/list/exp = list() //playtime tracker

	//STATS
	var/datum/attributes/stats = new()

	var/list/equipped_gear = list()

	var/ooc_bond_pref = "Ask"
	var/ooc_ghoul_pref = "Ask"
	var/ooc_embrace_pref = "Ask"
	var/ooc_escalation_pref = "No"
	var/ooc_link = ""

//===========GHOUL/VAMPS===========
	var/datum/vampireclane/clane
	var/humanity = 7
	var/diablerist = 0
	var/masquerade = 5
	var/clane_accessory

	///Datum types of the Disciplines this character knows.
	var/list/discipline_types = list()
	///Ranks of the Disciplines this character knows, corresponding to discipline_types.
	var/list/discipline_levels = list()

	//-----------NEW ITEMS-----------
	var/vamp_rank = VAMP_RANK_GHOUL		//rank in vampire society
	var/actual_age = 30					//true age of character
	var/datum/vampireclane/regent_clan
	var/datum/vtr_faction/vamp_faction
	var/tempted = 0						//Temptation from the beast

//===========WEREWOLVES===========
	var/datum/auspice/auspice = new /datum/auspice/ahroun()
	var/auspice_level = 1
	var/breed = "Homid"
	var/tribe = "Wendigo"
	var/werewolf_color = "black"
	var/werewolf_scar = 0
	var/werewolf_hair = 0
	var/werewolf_hair_color = "#000000"
	var/werewolf_eye_color = "#FFFFFF"
	var/werewolf_name

//===========Character Connections===========
	var/list/character_connections = list() //All character connections
	var/list/endorsement_roles_eligable = list() //head roles that a player qualifies for

/datum/preferences/New(client/C)
	parent = C
	UI_style = GLOB.available_ui_styles[1]
	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)

	//try to load preferences
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			calculate_dots()
			return

	//we couldn't load character data so just randomize the character appearance + name
	random_species()
	//let's create a random character then - rather than a fat, bald and naked man.
	random_character()
	calculate_dots()

	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	C?.set_macros()
	real_name = pref_species.random_name(gender,1)
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character()		//let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()

	return
