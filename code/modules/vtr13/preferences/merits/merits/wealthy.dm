/datum/merit/wealthy
	name = "Wealthy"
	desc = "You are wealthy. There is additional, filthy lucre in your bank account."
	dots = 2

/datum/merit/wealthy/post_add()
	var/datum/vtr_bank_account/our_account
	for(var/datum/vtr_bank_account/account in GLOB.bank_account_list)
		if(account.tracked_owner_mob && account.tracked_owner_mob.resolve() && (account.tracked_owner_mob.resolve() == merit_holder))
			our_account = account
			break
	if(our_account)
		our_account.balance *= 1.5