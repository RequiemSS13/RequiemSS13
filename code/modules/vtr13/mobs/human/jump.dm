/mob/living/carbon/human/jump(atom/target)
	if(HAS_TRAIT(src, TRAIT_QUICK_JUMP) || do_after(src, 12 - (get_wits()*2), src))
		..()
	return
