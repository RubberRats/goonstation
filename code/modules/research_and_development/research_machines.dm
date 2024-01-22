/obj/machinery/computer/rnd
	name = "research and development console"
	var/obj/item/disk/data/floppy/loaded_disk = null

	attackby(obj/item/W, mob/user)
		if (istype(W, /obj/item/disk/data/floppy))
			if(!loaded_disk)
				user.drop_item()
				W.set_loc(src)
				src.loaded_disk = W
				boutput(user, "You insert [W].")
			else
				boutput(user, "<span class='alert'>There's already a disk inside!</span>")

		. = ..()

	ui_data(mob/user)
		. = list(
			"level" = rndSystem.level,
			"budget" = wagesystem.research_budget,
			"num_researched" = rndSystem.projects_completed,
			"active_projects" = list(),
			"finished_projects" = list(),
		)
		for(var/datum/rnd_project/P as anything in rndSystem.active_projects)
			var/task_list = list()
			for(var/datum/rnd_task/T as anything in P.tasks)
				task_list += list(
					"desc" = T.description,
					"completed" = T.completed
				)
			.["active_projects"] += list(list(
				"ref" = "\ref[P]",
				"name" = P.name,
				"task" = task_list
			))
		for(var/datum/rnd_project/P as anything in rndSystem.completed_projects)
			.["finished_projects"] += list(list(
				"ref" = "\ref[P]",
				"name" = P.name,
				"desc" = P.desc
			))
		if(loaded_disk)
			var/obj/item/disk/data/floppy/D = loaded_disk
			.["disk"] = list(
				"name" = D.title,
				"capacity" = D.file_amount,
				"used" = D.file_used,
			)
			for (var/datum/computer/file/F in D.root.contents)
				.["disk"]["files"] += list(
					"name" = F.name,
					"size" = F.size
				)
		else
			.["disk"] = null



//	ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
//		. = ..()
//		if(.) return
//		swtich(action)
//			if()
