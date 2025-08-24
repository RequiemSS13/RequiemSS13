// 'basic' language; spoken by default.
/datum/language/english
	name = "English"
	desc = "Lingua franca of the world."
	key = "0"
	flags = TONGUELESS_SPEECH | LANGUAGE_HIDE_ICON_IF_UNDERSTOOD
	default_priority = 100

	icon_state = "english"

//Syllable Lists
/*
	Sources:
	https://en.wikipedia.org/wiki/Most_common_words_in_English
*/
/datum/language/english/syllables = list(
"the","be","to","of","and","a","in","that","have","I","it","for","not","on","with","he","as","you","do","at",
"this","but","his","by","from","they","we","say","her","she","or","an","will","my","one","all","would","there",
"their","they're","what","so","up","out","if","about","who","get","which","go","me","when","make","can","like",
"time","no","just","him","know","take","people","into","year","your","good","some","could","see","other","than",
"seem","dog","then","now","look","only","come","dancing","city,","its","over","think","because","any","give","day",
"sun","moon","bat","blood","bite","frightening","play","way","first","us","man","woman","eye","politics","hand","life",
"work","number","fact","same","mystery","love","news","friend","rent","food","yes","hello","look","agree","big",
"important","different","good","early","right","ghost"
)
