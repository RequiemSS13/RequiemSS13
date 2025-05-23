/**
 * This is the splat (supernatural type, game line in the World of Darkness) container
 * for all vampire-related code. I think this is stupid and I don't want any of this to
 * be the way it is, but if we're going to work with the code that's been written then
 * my advice is to centralise all stuff directly relating to vampires to here if it isn't
 * already in another organisational structure.
 *
 * The same applies to other splats, like /datum/species/garou or /datum/species/ghoul.
 * Halfsplats like ghouls are going to share some code with their fullsplats (vampires).
 * I dunno what to do about this except a reorganisation to make this stuff actually good.
 * The plan right now is to create a /datum/splat parent type and then have everything branch
 * from there, but that's for the future.
 */

/datum/species/kindred
	name = "Vampire"
	id = "kindred"
	default_color = "FFFFFF"
	toxic_food = MEAT | VEGETABLES | RAW | JUNKFOOD | GRAIN | FRUIT | DAIRY | FRIED | ALCOHOL | SUGAR | PINEAPPLE
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_LIMBATTACHMENT, TRAIT_VIRUSIMMUNE, TRAIT_NOBLEED, TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_TOXIMMUNE, TRAIT_NOCRITDAMAGE)
	use_skintones = TRUE
	limbs_id = "human"
	wings_icon = "Dragon"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	mutantbrain = /obj/item/organ/brain/vampire
	brutemod = 0.5	// or change to 0.8
	heatmod = 1		//Sucking due to overheating	///THEY DON'T SUCK FROM FIRE ANYMORE
	burnmod = 2
	punchdamagelow = 10
	punchdamagehigh = 20
	dust_anim = "dust-h"
	var/datum/vampireclane/clane
	var/list/datum/discipline/disciplines = list()
	selectable = TRUE
	COOLDOWN_DECLARE(torpor_timer)

/datum/species/kindred/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	C.update_body(0)
	C.last_experience = world.time + 5 MINUTES
	// TFN EDIT BEGIN - Memories should be components
	if(C.mind)
		C.mind.refresh_memory()
	// TFN EDIT END
	var/datum/action/give_vitae/vitae = new()
	vitae.Grant(C)

	//this needs to be adjusted to be more accurate for blood spending rates
	var/datum/discipline/bloodheal/giving_bloodheal = new(C.blood_potency)
	C.give_discipline(giving_bloodheal)

	var/datum/action/blood_power/bloodpower = new()
	bloodpower.Grant(C)

	add_verb(C, /mob/living/carbon/human/verb/teach_discipline)

	SScharacter_connection.setup_character_connection_verbs(C)

	//vampires go to -200 damage before dying
	for (var/obj/item/bodypart/bodypart in C.bodyparts)
		bodypart.max_damage *= 1.5

	//vampires die instantly upon having their heart removed
	RegisterSignal(C, COMSIG_CARBON_LOSE_ORGAN, PROC_REF(lose_organ))

	//vampires don't die while in crit, they just slip into torpor after 2 minutes of being critted
	RegisterSignal(C, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION), PROC_REF(slip_into_torpor))

	//vampires resist vampire bites better than mortals
	RegisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_vampire_bitten))

/datum/species/kindred/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_VAMPIRE_SUCKED)
	for(var/datum/action/A in C.actions)
		if(A)
			if(A.vampiric)
				A.Remove(C)

/datum/action/blood_power
	name = "Blood Power"
	desc = "Use vitae to gain supernatural abilities."
	button_icon_state = "bloodpower"
	button_icon = 'code/modules/wod13/UI/actions.dmi'
	background_icon_state = "discipline"
	icon_icon = 'code/modules/wod13/UI/actions.dmi'
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE

/datum/action/blood_power/ApplyIcon(atom/movable/screen/movable/action_button/current_button, force = FALSE)
	if(owner.mind)
		button_icon = 'code/modules/wod13/UI/actions.dmi'
		icon_icon = 'code/modules/wod13/UI/actions.dmi'
	. = ..()

/datum/action/blood_power/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		if (HAS_TRAIT(owner, TRAIT_TORPOR))
			return
		var/mob/living/carbon/human/BD = usr
		if(world.time < BD.last_bloodpower_use+110)
			return
		var/plus = 0
		if(HAS_TRAIT(BD, TRAIT_HUNGRY))
			plus = 1
		if(BD.bloodpool >= 2+plus)
			playsound(usr, 'code/modules/wod13/sounds/bloodhealing.ogg', 50, FALSE)
			button.color = "#970000"
			animate(button, color = "#ffffff", time = 20, loop = 1)
			BD.last_bloodpower_use = world.time
			BD.bloodpool = max(0, BD.bloodpool-(2+plus))
			to_chat(BD, "<span class='notice'>You use blood to become more powerful.</span>")
			BD.dna.species.punchdamagehigh = BD.dna.species.punchdamagehigh+5
			BD.physiology.armor.melee = BD.physiology.armor.melee+15
			BD.physiology.armor.bullet = BD.physiology.armor.bullet+15
			BD.additional_physique += 2
			BD.additional_stamina += 2
			
			if(!HAS_TRAIT(BD, TRAIT_IGNORESLOWDOWN))
				ADD_TRAIT(BD, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
			BD.update_blood_hud()
			spawn(100+BD.discipline_time_plus+BD.bloodpower_time_plus)
				end_bloodpower()
		else
			SEND_SOUND(BD, sound('code/modules/wod13/sounds/need_blood.ogg', 0, 0, 75))
			to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to become more powerful.</span>")

/datum/action/blood_power/proc/end_bloodpower()
	if(owner && ishuman(owner))
		var/mob/living/carbon/human/BD = owner
		to_chat(BD, "<span class='warning'>You feel like your <b>BLOOD</b>-powers slowly decrease.</span>")
		if(BD.dna.species)
			BD.dna.species.punchdamagehigh = BD.dna.species.punchdamagehigh-5
			BD.physiology.armor.melee = BD.physiology.armor.melee-15
			BD.physiology.armor.bullet = BD.physiology.armor.bullet-15
			if(HAS_TRAIT(BD, TRAIT_IGNORESLOWDOWN))
				REMOVE_TRAIT(BD, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
		BD.additional_physique -= 2
		BD.additional_stamina -= 2

/datum/action/give_vitae
	name = "Give Vitae"
	desc = "Give your vitae to someone, make the Blood Bond."
	button_icon_state = "vitae"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/giving = FALSE

/datum/action/give_vitae/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		if(H.bloodpool < 2)
			to_chat(owner, "<span class='warning'>You don't have enough <b>BLOOD</b> to do that!</span>")
			return
		if(istype(H.pulling, /mob/living/simple_animal))
			var/mob/living/L = H.pulling
			L.bloodpool = min(L.maxbloodpool, L.bloodpool+2)
			H.bloodpool = max(0, H.bloodpool-2)
			L.adjustBruteLoss(-25)
			L.adjustFireLoss(-25)
		if(istype(H.pulling, /mob/living/carbon/human))
			var/mob/living/carbon/human/BLOODBONDED = H.pulling
			if(!BLOODBONDED.client && !istype(H.pulling, /mob/living/carbon/human/npc))
				to_chat(owner, "<span class='warning'>You need [BLOODBONDED]'s attention to do that!</span>")
				return
			if(BLOODBONDED.stat == DEAD)
				if(!BLOODBONDED.key)
					to_chat(owner, "<span class='warning'>You need [BLOODBONDED]'s mind to Embrace!</span>")
					return
				message_admins("[ADMIN_LOOKUPFLW(H)] is Embracing [ADMIN_LOOKUPFLW(BLOODBONDED)]!")
			if(giving)
				return
			giving = TRUE
			owner.visible_message("<span class='warning'>[owner] tries to feed [BLOODBONDED] with their own blood!</span>", "<span class='notice'>You started to feed [BLOODBONDED] with your own blood.</span>")
			if(do_mob(owner, BLOODBONDED, 10 SECONDS))
				H.bloodpool = max(0, H.bloodpool-2)
				giving = FALSE
				BLOODBONDED.drunked_of |= "[H.dna.real_name]"

				if(BLOODBONDED.stat == DEAD && !iskindred(BLOODBONDED))
					if (!BLOODBONDED.can_be_embraced || (BLOODBONDED.timeofdeath + 5 MINUTES) < world.time || H?.clane?.name == "Revenant")
						to_chat(H, "<span class='notice'>[BLOODBONDED.name] doesn't respond to your Vitae.</span>")
						return
					log_game("[key_name(H)] has Embraced [key_name(BLOODBONDED)].")
					message_admins("[ADMIN_LOOKUPFLW(H)] has Embraced [ADMIN_LOOKUPFLW(BLOODBONDED)].")
					giving = FALSE
					var/save_data_v = FALSE
					if(BLOODBONDED.revive(full_heal = TRUE, admin_revive = TRUE))
						BLOODBONDED.grab_ghost(force = TRUE)
						to_chat(BLOODBONDED, "<span class='userdanger'>You rise with a start, you're alive! Or not... You feel your soul going somewhere, as you realize you are embraced by a vampire...</span>")
						var/response_v = input(BLOODBONDED, "Do you wish to keep being a vampire on your save slot?(Yes will be a permanent choice and you can't go back!)") in list("Yes", "No")
						if(response_v == "Yes")
							save_data_v = TRUE
						else
							save_data_v = FALSE
					BLOODBONDED.set_species(/datum/species/kindred)
					BLOODBONDED.clane = new H.clane.type()
					
					BLOODBONDED.clane.on_gain(BLOODBONDED)
					BLOODBONDED.clane.post_gain(BLOODBONDED)
					BLOODBONDED.update_body()

					//Gives the Childe the Sire's first three Disciplines
					var/list/disciplines_to_give = list()
					for (var/i in 1 to min(3, H.client.prefs.discipline_types.len))
						disciplines_to_give += H.client.prefs.discipline_types[i]
					BLOODBONDED.blood_potency = 1
					BLOODBONDED.maxbloodpool = 9 + BLOODBONDED.blood_potency

					//Verify if they accepted to save being a vampire
					if (iskindred(BLOODBONDED) && save_data_v)
						var/datum/preferences/BLOODBONDED_prefs_v = BLOODBONDED.client.prefs
						BLOODBONDED_prefs_v.pref_species.id = "kindred"
						BLOODBONDED_prefs_v.pref_species.name = "Vampire"
						BLOODBONDED_prefs_v.clane = BLOODBONDED.clane
						BLOODBONDED_prefs_v.vamp_rank = VAMP_RANK_FLEDGLING
						BLOODBONDED_prefs_v.skin_tone = get_vamp_skin_color(BLOODBONDED.skin_tone)
						//Rarely the new mid round vampires get the 3 brujah skil(it is default)
						//This will remove if it happens
						// Or if they are a ghoul with abunch of disciplines
						if(BLOODBONDED_prefs_v.discipline_types.len > 0)
							for (var/i in 1 to BLOODBONDED_prefs_v.discipline_types.len)
								var/removing_discipline = BLOODBONDED_prefs_v.discipline_types[1]
								if (removing_discipline)
									var/index = BLOODBONDED_prefs_v.discipline_types.Find(removing_discipline)
									BLOODBONDED_prefs_v.discipline_types.Cut(index, index + 1)
									BLOODBONDED_prefs_v.discipline_levels.Cut(index, index + 1)

						if(BLOODBONDED_prefs_v.discipline_types.len == 0)
							for (var/i in 1 to 3)
								BLOODBONDED_prefs_v.discipline_types += BLOODBONDED_prefs_v.clane.clane_disciplines[i]
								BLOODBONDED_prefs_v.discipline_levels.Add(0)
						BLOODBONDED_prefs_v.save_character()

						SScharacter_connection.add_connection(CONNECTION_EMBRACE, BLOODBONDED, H)
						BLOODBONDED.update_auspex_hud_vtr()
					else
						to_chat(owner, "<span class='notice'>[BLOODBONDED] is totally <b>DEAD</b>!</span>")
						giving = FALSE
						return
				else
					if(H?.clane?.name == "Revenant")
						to_chat(owner, "<span class='notice'>[BLOODBONDED] does not respond to your vitae.</span>")
						return
					to_chat(owner, "<span class='notice'>You successfuly fed [BLOODBONDED] with vitae.</span>")
					to_chat(BLOODBONDED, "<span class='userlove'>You feel good when you drink this <b>BLOOD</b>...</span>")


					if(H.reagents)
						if(length(H.reagents.reagent_list))
							H.reagents.trans_to(BLOODBONDED, min(10, H.reagents.total_volume), transfered_by = H, methods = VAMPIRE)
					
					BLOODBONDED.adjustBruteLoss(-25, TRUE)
					
					if(length(BLOODBONDED.all_wounds))
						var/datum/wound/W = pick(BLOODBONDED.all_wounds)
						W.remove_wound()
					
					BLOODBONDED.adjustFireLoss(-25, TRUE)
					BLOODBONDED.bloodpool = min(BLOODBONDED.maxbloodpool, BLOODBONDED.bloodpool+2)
					
					giving = FALSE
					if (iskindred(BLOODBONDED))
						var/datum/species/kindred/species = BLOODBONDED.dna.species
						if (HAS_TRAIT(BLOODBONDED, TRAIT_TORPOR) && COOLDOWN_FINISHED(species, torpor_timer))
							BLOODBONDED.untorpor()

					var/blood_bond_result = 0

					//apply the blood bond to the database
					if(BLOODBONDED.mind)
						blood_bond_result = SScharacter_connection.add_connection(CONNECTION_BLOOD_BOND, BLOODBONDED, H)
						if(blood_bond_result == 3 && BLOODBONDED.mind.enslaved_to != owner)
							BLOODBONDED.mind.enslave_mind_to_creator(owner)
						if(blood_bond_result >= 2 && BLOODBONDED.has_status_effect(STATUS_EFFECT_INLOVE))
							BLOODBONDED.remove_status_effect(STATUS_EFFECT_INLOVE)
							BLOODBONDED.apply_status_effect(STATUS_EFFECT_INLOVE, owner)

					//handle ghouling
					if(!isghoul(BLOODBONDED) && !iskindred(BLOODBONDED) && tgui_alert(owner, "Do you wish to turn [BLOODBONDED] into a ghoul?.", "Confirmation", list("Yes", "No")) == "Yes")
						BLOODBONDED.handle_ghouling(H)

					if(isghoul(BLOODBONDED) && blood_bond_result > 1)
						var/datum/species/ghoul/G = BLOODBONDED.dna.species
						G.last_vitae = world.time
					BLOODBONDED.update_auspex_hud_vtr()
			else
				giving = FALSE

/**
 * Initialises Disciplines for new vampire mobs, applying effects and creating action buttons.
 *
 * If discipline_pref is true, it grabs all of the source's Disciplines from their preferences
 * and applies those using the give_discipline() proc. If false, it instead grabs a given list
 * of Discipline typepaths and initialises those for the character. Only works for ghouls and
 * vampires, and it also applies the Clan's post_gain() effects
 *
 * Arguments:
 * * discipline_pref - Whether Disciplines will be taken from preferences. True by default.
 * * disciplines - list of Discipline typepaths to grant if discipline_pref is false.
 */
/mob/living/carbon/human/proc/create_disciplines(discipline_pref = TRUE, list/disciplines)	//EMBRACE BASIC
	if(client)
		client.prefs.save_preferences()
		client.prefs.save_character()

	if((dna.species.id == "kindred") || (dna.species.id == "ghoul")) //only splats that have Disciplines qualify
		var/list/datum/discipline/adding_disciplines = list()

		if (discipline_pref) //initialise player's own disciplines
			for (var/i in 1 to client.prefs.discipline_types.len)
				var/type_to_create = client.prefs.discipline_types[i]
				var/level = client.prefs.discipline_levels[i]
				if(!level)
					continue
				var/datum/discipline/discipline = new type_to_create(level)

				//prevent Disciplines from being used if not whitelisted for them
				if (discipline.clan_restricted)
					if (!can_access_discipline(src, type_to_create))
						qdel(discipline)
						continue

				adding_disciplines += discipline
		else if (disciplines.len) //initialise given disciplines
			for (var/i in 1 to disciplines.len)
				var/type_to_create = disciplines[i]
				var/datum/discipline/discipline = new type_to_create(1)
				adding_disciplines += discipline

		for (var/datum/discipline/discipline in adding_disciplines)
			give_discipline(discipline)

		if(clane)
			clane.post_gain(src)

	if((dna.species.id == "kuei-jin")) //only splats that have Disciplines qualify
		var/list/datum/chi_discipline/adding_disciplines = list()

		if (discipline_pref) //initialise character's own disciplines
			for (var/i in 1 to client.prefs.discipline_types.len)
				var/type_to_create = client.prefs.discipline_types[i]
				var/datum/chi_discipline/discipline = new type_to_create
				discipline.level = client.prefs.discipline_levels[i]
				adding_disciplines += discipline

		for (var/datum/chi_discipline/discipline in adding_disciplines)
			give_chi_discipline(discipline)

/**
 * Creates an action button and applies post_gain effects of the given Discipline.
 *
 * Arguments:
 * * discipline - Discipline datum that is being given to this mob.
 */
/mob/living/carbon/human/proc/give_discipline(datum/discipline/discipline)
	if (discipline.level > 0)
		var/datum/action/discipline/action = new(discipline)
		action.Grant(src)
	var/datum/species/kindred/species = dna.species
	species.disciplines += discipline

/mob/living/carbon/human/proc/give_chi_discipline(datum/chi_discipline/discipline)
	if (discipline.level > 0)
		var/datum/action/chi_discipline/action = new
		action.discipline = discipline
		action.Grant(src)
	discipline.post_gain(src)

/**
 * Accesses a certain Discipline that a Kindred has. Returns false if they don't.
 *
 * Arguments:
 * * searched_discipline - Name or typepath of the Discipline being searched for.
 */
/datum/species/kindred/proc/get_discipline(searched_discipline)
	for(var/datum/discipline/discipline in disciplines)
		if (ispath(searched_discipline, /datum/discipline))
			if (istype(discipline, searched_discipline))
				return discipline
		else if (istext(searched_discipline))
			if (discipline.name == searched_discipline)
				return discipline

	return FALSE

/datum/species/kindred/check_roundstart_eligible()
	return TRUE

/datum/species/kindred/handle_body(mob/living/carbon/human/H)
	if (!H.clane)
		return ..()

	//deflate people if they're super rotten
	if ((H.clane.alt_sprite == "rotten4") && (H.base_body_mod == "f"))
		H.base_body_mod = ""

	if(H.clane.alt_sprite)
		H.dna.species.limbs_id = "[H.base_body_mod][H.clane.alt_sprite]"

	..()


/**
 * Signal handler for lose_organ to near-instantly kill Kindred whose hearts have been removed.
 *
 * Arguments:
 * * source - The Kindred whose organ has been removed.
 * * organ - The organ which has been removed.
 */
/datum/species/kindred/proc/lose_organ(var/mob/living/carbon/human/source, var/obj/item/organ/organ)
	SIGNAL_HANDLER

	if (istype(organ, /obj/item/organ/heart))
		spawn()
			if (!source.getorganslot(ORGAN_SLOT_HEART))
				source.death()

/datum/species/kindred/proc/slip_into_torpor(var/mob/living/carbon/human/source)
	SIGNAL_HANDLER

	to_chat(source, "<span class='warning'>You can feel yourself slipping into Torpor. You can use succumb to immediately sleep...</span>")
	spawn(2 MINUTES)
		if (source.stat >= SOFT_CRIT)
			source.torpor("damage")

/**
 * Verb to teach your Disciplines to vampires who have drank your blood by spending 10 experience points.
 *
 * Disciplines can be taught to any willing vampires who have drank your blood in the last round and do
 * not already have that Discipline. True Brujah learning Celerity or Old Clan Tzimisce learning Vicissitude
 * get kicked out of their bloodline and made into normal Brujah and Tzimisce respectively. Disciplines
 * are taught at the 0th level, unlocking them but not actually giving the Discipline to the student.
 * Teaching Disciplines takes 10 experience points, then the student can buy the 1st rank for another 10.
 * The teacher must have the Discipline at the 5th level to teach it to others.
 *
 * Arguments:
 * * student - human who this Discipline is being taught to.
 */
/mob/living/carbon/human/verb/teach_discipline(mob/living/carbon/human/student in (range(1, src) - src))
	set name = "Teach Discipline"
	set category = "IC"
	set desc ="Teach a Discipline to a Kindred who has recently drank your blood. Costs 10 experience points."

	var/mob/living/carbon/human/teacher = src
	var/datum/preferences/teacher_prefs = teacher.client.prefs
	var/datum/species/kindred/teacher_species = teacher.dna.species

	if (!student.client)
		to_chat(teacher, "<span class='warning'>Your student needs to be a player!</span>")
		return
	var/datum/preferences/student_prefs = student.client.prefs

	if (!iskindred(student))
		to_chat(teacher, "<span class='warning'>Your student needs to be a vampire!</span>")
		return
	if (student.stat >= SOFT_CRIT)
		to_chat(teacher, "<span class='warning'>Your student needs to be conscious!</span>")
		return
	//checks that the teacher has blood bonded the student, this is something that needs to be reworked when blood bonds are made better
	if (student.mind.enslaved_to != teacher)
		to_chat(teacher, "<span class='warning'>You need to have fed your student your blood to teach them Disciplines!</span>")
		return

	var/possible_disciplines = teacher_prefs.discipline_types - student_prefs.discipline_types
	var/teaching_discipline = input(teacher, "What Discipline do you want to teach [student.name]?", "Discipline Selection") as null|anything in possible_disciplines

	if (teaching_discipline)
		var/datum/discipline/teacher_discipline = teacher_species.get_discipline(teaching_discipline)
		var/datum/discipline/giving_discipline = new teaching_discipline

		//if a Discipline is clan-restricted, it must be checked if the student has access to at least one Clan with that Discipline
		if (giving_discipline.clan_restricted)
			if (!can_access_discipline(student, teaching_discipline))
				to_chat(teacher, "<span class='warning'>Your student is not whitelisted for any Clans with this Discipline, so they cannot learn it.</span>")
				qdel(giving_discipline)
				return

		//ensure the teacher's mastered it, also prevents them from teaching with free starting experience
		if (teacher_discipline.level < 5)
			to_chat(teacher, "<span class='warning'>You do not know this Discipline well enough to teach it. You need to master it to the 5th rank.</span>")
			qdel(giving_discipline)
			return

		var/restricted = giving_discipline.clan_restricted
		if (restricted)
			if (alert(teacher, "Are you sure you want to teach [student] [giving_discipline], one of your Clan's most tightly guarded secrets? This will cost 10 experience points.", "Confirmation", "Yes", "No") != "Yes")
				qdel(giving_discipline)
				return
		else
			if (alert(teacher, "Are you sure you want to teach [student] [giving_discipline]? This will cost 10 experience points.", "Confirmation", "Yes", "No") != "Yes")
				qdel(giving_discipline)
				return

		var/alienation = FALSE
		if (student.clane.restricted_disciplines.Find(teaching_discipline))
			if (alert(student, "Learning [giving_discipline] will alienate you from the rest of the [student.clane], making you just like the false Clan. Do you wish to continue?", "Confirmation", "Yes", "No") != "Yes")
				visible_message("<span class='warning'>[student] refuses [teacher]'s mentoring!</span>")
				qdel(giving_discipline)
				return
			else
				alienation = TRUE
				to_chat(teacher, "<span class='notice'>[student] accepts your mentoring!</span>")

		if (get_dist(student.loc, teacher.loc) > 1)
			to_chat(teacher, "<span class='warning'>Your student needs to be next to you!</span>")
			qdel(giving_discipline)
			return

		visible_message("<span class='notice'>[teacher] begins mentoring [student] in [giving_discipline].</span>")
		if (do_after(teacher, 30 SECONDS, student))
			student_prefs.discipline_types += teaching_discipline
			student_prefs.discipline_levels += 0

			if (alienation)
				var/datum/vampireclane/main_clan
				switch(student.clane.type)
					if (/datum/vampireclane/true_brujah)
						main_clan = new /datum/vampireclane/brujah
					if (/datum/vampireclane/old_clan_tzimisce)
						main_clan = new /datum/vampireclane/tzimisce

				student_prefs.clane = main_clan
				student.clane = main_clan

			student_prefs.save_character()
			teacher_prefs.save_character()

			to_chat(teacher, "<span class='notice'>You finish teaching [student] the basics of [giving_discipline]. [student.p_they(TRUE)] seem[student.p_s()] to have absorbed your mentoring.[restricted ? " May your Clanmates take mercy on your soul for spreading their secrets." : ""]</span>")
			to_chat(student, "<span class='nicegreen'>[teacher] has taught you the basics of [giving_discipline]. You may now spend experience points to learn its first level in the character menu.</span>")

			message_admins("[ADMIN_LOOKUPFLW(teacher)] taught [ADMIN_LOOKUPFLW(student)] the Discipline [giving_discipline.name].")
			log_game("[key_name(teacher)] taught [key_name(student)] the Discipline [giving_discipline.name].")

		qdel(giving_discipline)


//Vampires take 4% of their max health in burn damage every tick they are on fire. Very potent against lower-gens.
//Set at 0.02 because they already take twice as much burn damage.
/datum/species/kindred/handle_fire(mob/living/carbon/human/H, no_protection)
	if(!..())
		H.adjustFireLoss(H.maxHealth * 0.02)

/**
 * Checks a vampire for whitelist access to a Discipline.
 *
 * Checks the given vampire to see if they have access to a certain Discipline through
 * one of their selectable Clans. This is only necessary for "unique" or Clan-restricted
 * Disciplines, as those have a chance to only be available to a certain Clan that
 * the vampire may or may not be whitelisted for.
 *
 * Arguments:
 * * vampire_checking - The vampire mob being checked for their access.
 * * discipline_checking - The Discipline type that access to is being checked.
 */
/proc/can_access_discipline(mob/living/carbon/human/vampire_checking, discipline_checking)
	if (isghoul(vampire_checking))
		return TRUE
	if (!iskindred(vampire_checking))
		return FALSE
	if (!vampire_checking.client)
		return FALSE

	//make sure it's actually restricted and this check is necessary
	var/datum/discipline/discipline_object_checking = new discipline_checking
	if (!discipline_object_checking.clan_restricted)
		qdel(discipline_object_checking)
		return TRUE
	qdel(discipline_object_checking)

	//first, check their Clan Disciplines to see if that gives them access
	if (vampire_checking.clane.clane_disciplines.Find(discipline_checking))
		return TRUE

	//next, go through all Clans to check if they have access to any with the Discipline
	for (var/clan_type in subtypesof(/datum/vampireclane))
		var/datum/vampireclane/clan_checking = new clan_type

		//skip this if they can't access it due to whitelists
		if (clan_checking.whitelisted)
			if (!SSwhitelists.is_whitelisted(checked_ckey = vampire_checking.ckey, checked_whitelist = clan_checking.name))
				qdel(clan_checking)
				continue

		if (clan_checking.clane_disciplines.Find(discipline_checking))
			qdel(clan_checking)
			return TRUE

		qdel(clan_checking)

	//nothing found
	return FALSE

/**
 * On being bit by a vampire
 *
 * This handles vampire bite sleep immunity and any future special interactions.
 */
/datum/species/kindred/proc/on_vampire_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	if(iskindred(being_bitten))
		return COMPONENT_RESIST_VAMPIRE_KISS
