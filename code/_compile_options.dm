//#define TESTING				//By using the testing("message") proc you can create debug-feedback for people with this
								//uncommented, but not visible in the release version)

//#define DATUMVAR_DEBUGGING_MODE	//Enables the ability to cache datum vars and retrieve later for debugging which vars changed.

// Comment this out if you are debugging problems that might be obscured by custom error handling in world/Error
#ifdef DEBUG
#define USE_CUSTOM_ERROR_HANDLER
#endif

#ifdef TESTING
#define DATUMVAR_DEBUGGING_MODE

/*
	Enables tools for the AreaGrouper's pathfinding
*/
#define AREA_GROUPER_DEBUGGING


/*
* Enables extools-powered reference tracking system, letting you see what is referencing objects that refuse to hard delete.
*
* * Requires TESTING to be defined to work.
*/
//#define REFERENCE_TRACKING

///Method of tracking references without using extools. Slower, kept to avoid over-reliance on extools.
//#define LEGACY_REFERENCE_TRACKING
#ifdef LEGACY_REFERENCE_TRACKING

///Use the legacy reference on things hard deleting by default.
//#define GC_FAILURE_HARD_LOOKUP
#ifdef GC_FAILURE_HARD_LOOKUP
#define FIND_REF_NO_CHECK_TICK
#endif //ifdef GC_FAILURE_HARD_LOOKUP

#endif //ifdef LEGACY_REFERENCE_TRACKING

#define VISUALIZE_ACTIVE_TURFS	//Highlights atmos active turfs in green
#define TRACK_MAX_SHARE	//Allows max share tracking, for use in the atmos debugging ui
#endif //ifdef TESTING

//#define UNIT_TESTS			//If this is uncommented, we do a single run though of the game setup and tear down process with unit tests in between
			//set to:
#define PRELOAD_RSC	1		//	0 to allow using external resources or on-demand behaviour;						//	1 to use the default behaviour;
								//	2 for preloading absolutely everything;

#ifdef LOWMEMORYMODE
#define FORCE_MAP "_maps/runtimetown.json"
#endif

#if (DM_VERSION < MIN_COMPILER_VERSION || DM_BUILD < MIN_COMPILER_BUILD) && !defined(SPACEMAN_DMM)
//Don't forget to update this part
#error Your version of BYOND is too out-of-date to compile this project. Go to https://secure.byond.com/download and update.
#error You need version 516.1658 or higher
#endif

//Additional code for the above flags.
#ifdef TESTING
#warn compiling in TESTING mode. testing() debug messages will be visible.
#endif

#ifdef CIBUILDING
#define UNIT_TESTS
#endif

#ifdef CITESTING
#define TESTING
#endif

// A reasonable number of maximum overlays an object needs
// If you think you need more, rethink it
#define MAX_ATOM_OVERLAYS 100
