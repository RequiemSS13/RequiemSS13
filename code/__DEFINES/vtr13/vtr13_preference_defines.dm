//This is the lowest supported version, anything below this is completely obsolete and the entire savefile will be wiped.
#define SAVEFILE_VERSION_MIN	43

//This is the current version, anything below this will attempt to update (if it's not obsolete)
//	You do not need to raise this if you are adding new values that have sane defaults.
//	Only raise this value when changing the meaning/format/name/layout of an existing value
//	where you would want the updater procs below to run
#define SAVEFILE_VERSION_MAX	43

GLOBAL_LIST_EMPTY(preferences_datums)

//Tab definitions - KEEP SEQUENTIAL
#define PREFS_CHARACTER_SETTINGS_TAB 1
#define PREFS_MERITS_TAB 2
#define PREFS_ATTRIBUTES_TAB 3
#define PREFS_LOADOUT_TAB 4
#define PREFS_CONNECTIONS_TAB 5
#define PREFS_OCCUPATION_TAB 6
#define PREFS_GAME_PREFERENCES_TAB 7
#define PREFS_OOC_PREFERENCES_TAB 8
#define PREFS_KEYBINDINGS_TAB 9


#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='25%' border='1px solid white'>"
#define MAX_MUTANT_ROWS 4
#define ATTRIBUTE_BASE_LIMIT 5 //Highest level that a base attribute can be upgraded to. Bonus attributes can increase the actual amount past the limit.


#define VAMP_RANK_GHOUL 1
#define VAMP_RANK_HALF_DAMNED 2
#define VAMP_RANK_FLEDGLING 3
#define VAMP_RANK_NEONATE 4
#define VAMP_RANK_ANCILLAE 5
#define VAMP_RANK_ELDER 6

GLOBAL_LIST_INIT(vampire_rank_list, list(
	"Fledgling" = VAMP_RANK_FLEDGLING,
	"Neonate" = VAMP_RANK_NEONATE,
	"Ancillae" = VAMP_RANK_ANCILLAE,
	"Elder" = VAMP_RANK_ELDER))

GLOBAL_LIST_INIT(vampire_rank_names, list(
	VAMP_RANK_GHOUL = "Ghoul",
	VAMP_RANK_HALF_DAMNED = "Half-Damned",
	VAMP_RANK_FLEDGLING = "Fledgling",
	VAMP_RANK_NEONATE = "Neonate",
	VAMP_RANK_ANCILLAE = "Ancillae",
	VAMP_RANK_ELDER = "Elder"))

GLOBAL_LIST_INIT(vampire_rank_desc_list, list(
	VAMP_RANK_GHOUL = "The Vitae-addicted human servants of the Kindred known as Ghouls exist at the very bottom of the All-Night Society.",
	VAMP_RANK_HALF_DAMNED = "Revenants, the Half-Damned, the misbegotten bastard cousins of the Kindred, and have no place in the All-Night Society without Kindred patronage.",
	VAMP_RANK_FLEDGLING = "Recently-Embraced vampires are known as fledglings, and are considered social, political, and legal extensions of their sires for the first months of their unlives.",
	VAMP_RANK_NEONATE = "Neonates, who have been Kindred for less than fifty years, make up the majority of the All-Night Society. They are fully independent, but weaker than their elders and barred from high office outside of the Carthian Movement",
	VAMP_RANK_ANCILLAE = "Ancillae, who have been dead between fifty and one hundred years, are the backbone of Kindred politics. In Long Beach, they can hold all offices.",
	VAMP_RANK_ELDER = "Elders, dead for more than a century, shape the All-Night Society with their ambitions, but generally prefer to act through younger proxies. The highest stations in the city are theirs for the taking."))

#define CHARACTER_DOTS_DEFAULT 12
#define CHARACTER_DOTS_GHOUL 12
#define CHARACTER_DOTS_FLEDGLING 12
#define CHARACTER_DOTS_HALF_DAMNED 12
#define CHARACTER_DOTS_NEONATE 12
#define CHARACTER_DOTS_ANCILLAE 12
#define CHARACTER_DOTS_ELDER 12

#define DISCIPLINE_DOTS_DEFAULT 0
#define DISCIPLINE_DOTS_GHOUL 3
#define DISCIPLINE_DOTS_HALF_DAMNED 5
#define DISCIPLINE_DOTS_FLEDGLING 5
#define DISCIPLINE_DOTS_NEONATE 5
#define DISCIPLINE_DOTS_ANCILLAE 8
#define DISCIPLINE_DOTS_ELDER 11

#define PHYSIQUE_DESCRIPTION "Muscular strength and athletic ability."
#define STAMINA_DESCRIPTION "Constitution, endurance, fortitude, and physical robustness."
#define WITS_DESCRIPTION "Reflexes, intelligence, and fine motor skills."
#define RESOLVE_DESCRIPTION "Mental shrewdness, discernment, and willpower."
#define CHARISMA_DESCRIPTION "Social skills and presence."
#define COMPOSURE_DESCRIPTION "Emotional stability and self-control."
#define POTENCY_DESCRIPTION "The concentration of your vampiric blood."

GLOBAL_LIST_INIT(vampire_faction_list, list(
	"Invictus",
	"Lancea et Sanctum",
	"Ordo Dracul",
	"Circle of the Crone",
	"Carthian Movement",
	"Unaligned"))


#define PREFS_MERITS_SUB_TAB 1
#define PREFS_FLAWS_SUB_TAB 2
#define PREFS_BANES_SUB_TAB 3
#define PREFS_LANGUAGES_SUB_TAB 4

#define LOADOUT_MAX_SLOTS 8
#define LOADOUT_MAX_DOTS 10

#define LOADOUT_LOADED_DOT_BONUS 5
#define LOADOUT_LOADED_SLOT_BONUS 3