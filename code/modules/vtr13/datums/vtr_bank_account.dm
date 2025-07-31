/datum/vtr_bank_account
	var/account_owner = ""
	var/datum/weakref/tracked_owner_mob
	var/bank_id = 0
	var/balance = 0
	var/times_used_without_pin = 0
	var/owner_ckey = ""
	var/code = ""
	var/list/credit_thieves
	var/list/karmic_credit_deducted
	var/list/credit_cards = list()

/datum/vtr_bank_account/New()
	..()
	if(!code || code == "")
		code = create_bank_code()
		var/random_id = rand(1, 999999)
		bank_id = random_id
		GLOB.bank_account_list += src

/datum/vtr_bank_account/proc/modify_balance(amount, mob/living/user = null)
	if(!amount)
		return TRUE

	if((-1 * amount) > balance)
		if(user?.mind)
			to_chat(user, span_alert("The transaction is declined - Insufficient funds."))
		return FALSE
	balance = balance + amount
	return TRUE

/datum/vtr_bank_account/proc/check_pin(mob/living/user, amount, obj/item/source)
	//purchases over $20 require a pin, you have to use one eventually
	if(amount > 20 || times_used_without_pin > 5)
		if(tgui_input_text(user, "Enter the pin number for this card:", "Pin Input", max_length=4, multiline=FALSE) != code)
			to_chat(user, span_alert("The pin you entered for the [source] is incorrect."))
			return FALSE
		else
			to_chat(user, span_notice("You correctly enter the pin for the [source]."))
			times_used_without_pin = 0
	else
		times_used_without_pin += 1
	return TRUE


/datum/vtr_bank_account/proc/process_credit_fraud(mob/living/carbon/human/user, stolen_amt)
	if(!user || !user.mind || !user.real_name || !user.ckey)
		return

	if(tracked_owner_mob)
		var/mob/owner = tracked_owner_mob.resolve()
		if(owner && user == owner)
			return

	if(!credit_thieves)
		credit_thieves = list()

	if(!credit_thieves[user])
		credit_thieves[user] = stolen_amt
	else
		credit_thieves[user] += stolen_amt

	if(!iskindred(user))
		return

	switch(user.humanity)
		if(10)
			if(credit_thieves[user] != 0)
				to_chat(user, span_alert("That money - or any money, in the holistic sense, isn't really yours to use..."))
				user.AdjustHumanity(-1, 9)
		if(9)
			if(credit_thieves[user] >= 300)
				to_chat(user, span_alert("That money isn't yours to use, and you know it."))
				user.AdjustHumanity(-1, 8)
		if(8)
			if(credit_thieves[user] >= 1000)
				to_chat(user, span_alert("That money wasn't yours to use - and you used a lot."))
				user.AdjustHumanity(-1, 7)
