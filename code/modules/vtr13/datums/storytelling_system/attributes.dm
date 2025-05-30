/// This is the object used to store and manage a character's attributes.
/datum/attributes
	/// A dictionary of attributes. K: path -> V: instance.
	VAR_PRIVATE/list/attributes = list()

/datum/attributes/New()
	. = ..()
	for(var/datum/path as anything in subtypesof(/datum/attribute))
		attributes[path] = new path

/datum/attributes/Destroy()
	. = ..()
	attributes = null

/// Return the total or pure score of the given attribute.
/datum/attributes/proc/get_stat(attribute, include_bonus = TRUE)
	var/datum/attribute/A = attributes[attribute]
	return A.get(include_bonus)

/// Sets the score of the given attribute.
/datum/attributes/proc/set_stat(amount, attribute)
	var/datum/attribute/A = attributes[attribute]
	A.setter(amount)

/// Return the instance of the given attribute.
/datum/attributes/proc/get_attribute(attribute)
	RETURN_TYPE(/datum/attribute)
	var/datum/attribute/A = attributes[attribute]
	return A

/datum/attributes/proc/add_modifier(amount, attribute, source)
	var/datum/attribute/A = get_attribute(attribute)
	LAZYSET(A.modifiers, source, amount)
	A.update_modifiers()

/datum/attributes/proc/remove_modifier(attribute, source)
	var/datum/attribute/A = get_attribute(attribute)
	if(LAZYACCESS(A.modifiers, source))
		A.modifiers -= source
		A.update_modifiers()
