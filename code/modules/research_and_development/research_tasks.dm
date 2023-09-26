ABSTRACT_TYPE(/datum/rnd_task)
/datum/rnd_task
	var/id = "bad code"
	var/description = "You shouldn't be able to see this."
	var/completed = FALSE

	proc/validate_task(atom/scanned)
		return TRUE

/datum/rnd_task/bulk_chems
	id = "chems"
	description = "Scan a reagent container containing at least 200 units of a specific reagent"
	var/possible_chems = list()
