///called in /mob/living/proc/setDir (mob, dir, newdir)
#define COMSIG_LIVING_DIR_CHANGE "living_dir_change"
	#define COMPONENT_LIVING_DIR_CHANGE_BLOCK (1<<0)


#define COMSIG_HUMAN_EXAMINE_OVERRIDE "human_examine_override"
	#define COMPONENT_EXAMINE_CHANGE_RESPONSE (1<<0)

//called in /obj/transfer_point_vamp/Bumped (atom, obj/transfer_point_vamp, turf/new_turf)
#define COMSIG_ATOM_MOVABLE_TRANSFER_POINT_USE "atom_movable_transfer_point_use"

//called in /datum/controller/subsystem/frenzypool/fire 
#define COMSIG_HANDLE_AUTOMATED_FRENZY "handle_automated_frenzy"

///called in /mob/living/proc/try_frenzy (brain, modifier)
#define COMSIG_MIND_TRY_FRENZY "mind_frenzy"

///called in /datum/mind/proc/transfer_to (brain, new_mob)
#define COMSIG_MIND_TRANSFERRED "mind_transferred"

#define COMSIG_MIND_DRAUGR "mind_draugr"


///called in /datum/element/memories/Detach
#define COMSIG_MEMORY_DELETE "memory_delete"

//called in /datum/component/base_memory/get_memory_data (mob/living/carbon/human/owner, is_own_memories)
#define COMSIG_MEMORY_NAME_OVERRIDE "memory_name_override"
	#define COMPONENT_MEMORY_OVERRIDE (1<<0)

//called in /datum/component/base_memory/get_memory_data (mob/living/carbon/human/owner, is_own_memories)
#define COMSIG_MEMORY_SPLAT_TEXT "memory_splat_text"

//called in /datum/discipline_power/vtr/auspex/major_telepathy/proc/ask_memories (datum/mind, mob/living/carbon/human/invader)
#define COMSIG_MEMORY_AUSPEX_INVADE "memory_auspex_invade"

//called in /datum/component/base_memory/proc/get_memory_data
#define COMSIG_MEMORY_DISCIPLINE_TEXT "memory_discipline_text"


//from base of /mob/verb/pointed(): (mob/pointer)
#define COMSIG_MOB_LIVING_POINTED "mob_living_pointed"

//from base of mob/jump(): (atom/target, distance)
#define COMSIG_MOB_LIVING_JUMP "mob_living_jump"

//called in /datum/dominate_act/proc/request_early_removal
#define COMSIG_DOMINATE_ACT_END_EARLY "dominate_act_end_early"

//called in /datum/discipline_power/vtr/majesty/awe/deactivate
#define COMSIG_COMPONENT_ENRAPTURE_REMOVE "component_enrapture_remove"

//called in /datum/discipline_power/vtr/majesty/summon/proc/trigger_summon_end
#define COMSIG_MAJESTY_5_END "majesty_5_end"