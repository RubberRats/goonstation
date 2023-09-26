/datum/rnd_manager
	var/max_active_projects = 3
	var/level = 1
	var/projects_completed = 0

	var/list/possible_projects = new/list()
	var/list/active_projects = new/list()
	var/list/datum/rnd_project/completed_projects = new/list()

	proc/setup()
		possible_projects = childrentypesof(/datum/rnd_project)
		for(var/i in 1 to max_active_projects)
			add_project()

	proc/add_project()
		var/selection = pick(possible_projects)
		var/datum/rnd_project/P = new selection()
		active_projects += P
		possible_projects -= selection

	proc/check_scans (atom/scanned)
		for (var/datum/rnd_project P in active_projects)
			var/missing_tasks = FALSE
			for(var/datum/rnd_task task in P.tasks)
				if (task.completed) continue
				if (task.validate_task(scanned))
					task.completed = TRUE
				else
					missing_tasks = TRUE
			if (!missing_tasks)
			complete_project(P)



	proc/complete_project(var/rnd_project R)
		R.researched = TRUE
		active_projects -= R
		completed_projects += R
		add_project()

ABSTRACT_TYPE(/datum/rnd_project)
/datum/rnd_project
	var/name //name of the tech when researched
	var/desc //visible description of researched tech
	var/researched = FALSE //has this tech been researched?
	var/department
	var/list/tasks = list()// list of tasks that need to be completed to finish the project
	var/list/valid_tasks = list()//list of tasks that can be chosen for a given project
	var/list/blueprints = list()// fabricator recipes unlocked by researching the tech

	New()
		create_tasks(1)


	proc/create_tasks(var/task_count = 1)
		for(var/i in 1 to task_count)
			selction = pick(valid_tasks)
			if(ispath(selection))
				datum/research_task/R = new selection()
				tasks += R
				valid_tasks -= selection

	proc/generate_file() //creates a manudrive blueprint file with all associated blueprints
		var/MD = new /datum/computer/file/manudrive
		for (var/X in src.blueprints)
			MD.drivestored += get_schematic_from_path(X)
		return MD
