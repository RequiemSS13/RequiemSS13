/datum/merit/flaw/destitute
	name = "Destitute"
	desc = "You are impoverished. The money in your bank account is reduced."
	dots = -1

/datum/merit/flaw/destitute/post_add()
	var/datum/vtr_bank_account/our_account
	for(var/datum/vtr_bank_account/account in GLOB.bank_account_list)
		if(account.tracked_owner_mob && account.tracked_owner_mob.resolve() && (account.tracked_owner_mob.resolve() == merit_holder))
			our_account = account
			break
	if(our_account)
		our_account.balance = rand(0, 100)