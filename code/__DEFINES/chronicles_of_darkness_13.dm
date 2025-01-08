#define AGE_GHOUL 1
#define AGE_NEONATE 2
#define AGE_ANCILLA 3
#define AGE_ELDER 4
#define AGE_METHUSELAH 5

GLOBAL_LIST_INIT( vamp_age_rank_name_list, list(
	"Ghoul", //ghoul
	"Neonate", //neonate
	"Ancilla",
	"Elder",
	"Methuselah"
))


//CHANGE THESE TO FINE TUNE STARTING XP AND BLOOD POOL MAX
#define BASE_XP_METHUSELAH 999
#define BASE_XP_ELDER 100
#define BASE_XP_ANCILLA 70
#define BASE_XP_NEONATE 50

//list index corresponds to vamp_age_rank numbers
GLOBAL_LIST_INIT(vamp_base_xp_list, list(
	BASE_XP_NEONATE, //ghoul
	BASE_XP_NEONATE, //neonate
	BASE_XP_ANCILLA,
	BASE_XP_ELDER,
	BASE_XP_METHUSELAH
))



#define MAX_BLOODPOOL_METHUSELAH 75
#define MAX_BLOODPOOL_ELDER 15
#define MAX_BLOODPOOL_ANCILLA 12
#define MAX_BLOODPOOL_NEONATE 10
#define MAX_BLOODPOOL_GHOUL 5

//list index corresponds to vamp_age_rank numbers
GLOBAL_LIST_INIT(vamp_max_bloodpool_list, list(
	MAX_BLOODPOOL_GHOUL,
	MAX_BLOODPOOL_NEONATE,
	MAX_BLOODPOOL_ANCILLA,
	MAX_BLOODPOOL_ELDER,
	MAX_BLOODPOOL_METHUSELAH
))



#define HEALTH_BONUS_METHUSELAH 12
#define HEALTH_BONUS_ELDER 6
#define HEALTH_BONUS_ANCILLA 3
#define HEALTH_BONUS_NEONATE 0

//list index corresponds to vamp_age_rank numbers
GLOBAL_LIST_INIT(vamp_health_bonus_list, list(
	HEALTH_BONUS_NEONATE,
	HEALTH_BONUS_NEONATE,
	HEALTH_BONUS_ANCILLA,
	HEALTH_BONUS_ELDER,
	HEALTH_BONUS_METHUSELAH
))
