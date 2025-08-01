#define EXP_TYPE_CRONE			"Circle of the Crone"
#define EXP_TYPE_LANCEA			"Lancea et Sanctum"
#define EXP_TYPE_CARTHIAN		"Carthian Movement"
#define EXP_TYPE_INVICTUS		"Invictus"
#define EXP_TYPE_ORDO			"Ordo Dracul"


GLOBAL_LIST_INIT(vampire_factions_list, list(
	EXP_TYPE_CRONE,
	EXP_TYPE_LANCEA,
	EXP_TYPE_CARTHIAN,
	EXP_TYPE_INVICTUS,
	EXP_TYPE_ORDO
))


#define JOB_DISPLAY_ORDER_CITIZEN_VTR 1
GLOBAL_LIST_INIT(citizen_positions, list(
	"Pedestrian",
))

#define JOB_DISPLAY_ORDER_JANITOR_VTR 2
#define JOB_DISPLAY_ORDER_TAXI_VTR 3
#define JOB_DISPLAY_ORDER_BARISTA 4
GLOBAL_LIST_INIT(services_positions, list(
	"Street Janitor",
	"Taxi Driver",
	"Barista"
))

#define JOB_DISPLAY_ORDER_DIRECTOR_VTR 5
#define JOB_DISPLAY_ORDER_DOCTOR_VTR 6
GLOBAL_LIST_INIT(clinic_positions, list(
	"Clinic Director",
	"Doctor"
))

#define JOB_DISPLAY_ORDER_POLICE_CHIEF_VTR 7
#define JOB_DISPLAY_ORDER_POLICE_SERGEANT_VTR 8
#define JOB_DISPLAY_ORDER_POLICE_VTR 9
GLOBAL_LIST_INIT(police_positions, list(
	"Police Chief",
	"Police Sergeant",
	"Police Officer"
))

#define JOB_DISPLAY_ORDER_SENESCHAL_VTR		10
#define JOB_DISPLAY_ORDER_KEEPER			11
#define JOB_DISPLAY_ORDER_SHERIFF_VTR		12
#define JOB_DISPLAY_ORDER_JUDGE				13
#define JOB_DISPLAY_ORDER_HOST				14
#define JOB_DISPLAY_ORDER_DEPUTY			15
#define JOB_DISPLAY_ORDER_PAGE				16
#define JOB_DISPLAY_ORDER_HOUND_VTR			17
#define JOB_DISPLAY_ORDER_BARTENDER_VTR		18
#define JOB_DISPLAY_ORDER_COURTIER			19
GLOBAL_LIST_INIT(command_positions, list(
	"Seneschal",
	"Keeper of Elysium",
	"Sheriff",
	"Judge",
	"Host",
	"Deputy",
	"Page",
	"Hound",
	"Bartender",
	"Courtier"
))

#define JOB_DISPLAY_ORDER_BISHOP 			20
#define JOB_DISPLAY_ORDER_VICAR			21
#define JOB_DISPLAY_ORDER_SANCTIFIED 		22
#define JOB_DISPLAY_ORDER_CLERGY 			23
GLOBAL_LIST_INIT(lancea_positions, list(
	"Bishop",
	"Vicar",
	"Sanctified",
	"Clergy"
))

#define JOB_DISPLAY_ORDER_VOIVODE_VTR		24
#define JOB_DISPLAY_ORDER_CLAW				25
#define JOB_DISPLAY_ORDER_SWORN				26
#define JOB_DISPLAY_ORDER_LIBRARIAN_VTR		27
GLOBAL_LIST_INIT(ordo_positions, list(
	"Voivode",
	"Claw",
	"Sworn",
	"Librarian"
))

#define JOB_DISPLAY_ORDER_HIEROPHANT		28
#define JOB_DISPLAY_ORDER_HARUSPEX			29
#define JOB_DISPLAY_ORDER_ACOLYTE			30
GLOBAL_LIST_INIT(crone_positions, list(
	"Hierophant",
	"Haruspex",
	"Acolyte"
))


#define JOB_DISPLAY_ORDER_REPRESENTATIVE	31
#define JOB_DISPLAY_ORDER_WHIP				32
#define JOB_DISPLAY_ORDER_CARTHIAN			33
GLOBAL_LIST_INIT(carthian_positions, list(
	"Carthian Representative",
	"Whip",
	"Carthian"
))

GLOBAL_LIST_INIT(leader_positions, list(
	"Seneschal",
	"Keeper of Elysium",
	"Sheriff",
	"Bishop",
	"Voivode",
	"Hierophant",
	"Police Chief",
	"Representative",
	"Clinic Director"
	))

GLOBAL_LIST_INIT(position_categories, list(
	EXP_TYPE_OTHER_CITIZEN = list("jobs" = citizen_positions, "color" = "#7e7e7e"),
	EXP_TYPE_SERVICES = list("jobs" = services_positions, "color" = "#e8e6e6"),
	EXP_TYPE_CLINIC = list("jobs" = clinic_positions, "color" = "#80D0F4"),
	EXP_TYPE_POLICE = list("jobs" = police_positions, "color" = "#0059ff"),
	EXP_TYPE_INVICTUS = list("jobs" = command_positions, "color" = "#00027e"),
	EXP_TYPE_LANCEA = list("jobs" = lancea_positions, "color" = "#eeff00"),
	EXP_TYPE_ORDO = list("jobs" = ordo_positions, "color" = "#bb00d4"),
	EXP_TYPE_CRONE = list("jobs" = crone_positions, "color" = "#07d400"),
	EXP_TYPE_CARTHIAN = list("jobs" = carthian_positions, "color" = "#9f1111")
))

GLOBAL_LIST_INIT(exp_jobsmap, list(
	EXP_TYPE_CREW = list("titles" = citizen_positions | services_positions | clinic_positions | police_positions | command_positions | lancea_positions | ordo_positions | crone_positions | carthian_positions), // crew positions
	EXP_TYPE_OTHER_CITIZEN = list("titles" = citizen_positions),
	EXP_TYPE_SERVICES = list("titles" = services_positions),
	EXP_TYPE_CLINIC = list("titles" = clinic_positions),
	EXP_TYPE_POLICE = list("titles" = police_positions),
	EXP_TYPE_INVICTUS = list("titles" = command_positions),
	EXP_TYPE_LANCEA = list("titles" = lancea_positions),
	EXP_TYPE_ORDO = list("titles" = ordo_positions),
	EXP_TYPE_CRONE = list("titles" = crone_positions),
	EXP_TYPE_CARTHIAN = list("titles" = carthian_positions)
))