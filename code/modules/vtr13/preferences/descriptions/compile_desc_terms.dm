/datum/preferences/proc/compile_adjectives(mob/user)
	var/list/desc_master = list(list("a dreary","a messy", "an ugly", "a creepy", "a clumsy", "a graceless", "a strange", "a weird", "an odd", "a bizarre", "a freakish", "a nasty", "a gross", "an unappealing", "an unsettling", "a disturbing", "an awful", "a desperate", "a crestfallen", "a haggard"),
		list("a normal", "an ordinary", "a plain", "a regular", "a simple", "a typical", "an everyday", "an average", "an unremarkable", "a basic", "a middling", "a quiet", "a loud", "a reserved", "a bland", "a boring", "a forgettable", "a meek", "a gruff", "a grim", "a rugged", "a stern", "a scrappy", "an eerie"),
		list("a warm", "an affable", "an agreeable", "a friendly","an attractive", "a charming", "a cute", "a pretty", "a neat", "a pleasant", "a stylish", "a well-groomed", "a put-together", "a sharp", "an intimidating", "a scary", "a cold"),
		list("a sexy", "a refined", "a beautiful", "a handsome", "a hot", "a lovely", "an elegant", "a graceful", "a dashing", "a dapper", "a classy", "a foxy", "a suave", "a tasteful", "a darling", "a striking", "a terrifying", "a daunting", "an adorable", "a delightful"),
		list("a gorgeous", "an exquisite", "a breath-taking", "a stunning", "a glamourous", "an immaculate", "an unflappable", "a regal", "a magnificent", "a majestic", "an unforgettable", "a horrifying", "a statuesque"),
		list("an unearthly", "an impossible", "an incomparable", "a transcendent", "a peerless", "an otherworldly", "a divine", "a godlike", "an ethereal", "a perfect", "an angelic", "a demonic", "a devilish", "a hellish", "the"))
	var/real_cha = stats.get_stat(STAT_CHARISMA)
	var/list/available_adj = list("an off-putting")
	if(merit_custom_settings["expertise_stat"] == "Charisma")
		real_cha += 1
	for(var/i = 1; i <= real_cha; i++)
		available_adj += desc_master[i]
	return available_adj


/datum/preferences/proc/compile_nouns(mob/user) //Not level-specific yet, but here to keep all of the descriptor lists in one place
	var/list/noun_master = list("person", "man", "woman", "dude", "lady", "matron", "patron", "maiden", "youth", "senior", "gentleman", "gentleperson", "gentlewoman", "bloke", "presence", "show-off", "guy", "dame", "diva", "doll", "chick", "tomboy", "butch", "femme", "futch", "bear", "twink", "waif", "wastrel", "wretch", "scoundrel", "vagrant", "vagabond", "fella", "bastard", "bitch", "sinner", "freak", "creature", "critter", "hard-ass", "beast", "thing", "goth", "emo", "punk", "hipster", "nerd", "geek", "bro", "gal", "ditz", "jock", "prep", "individual", "figure")
	return noun_master

