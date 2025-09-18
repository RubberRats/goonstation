//attempts to make each cooking recipe, to ensure they are all reachable
/datum/unit_test/recipe_picker/Run()
	var/obj/submachine/chef_oven/test_oven = new /obj/submachine/chef_oven
	var/datum/recipe_manager/RM = get_singleton(/datum/recipe_manager)
	for(var/datum/cookingrecipe/R in RM.oven_recipes)
		if(!R.ingredients)
			Fail("Cooking recipe [R] has no ingredients")
			break
		for(var/ingredient in R.ingredients)
			if(!R.ingredients[ingredient])
				Fail("Cooking recipe [R] has ingredients with undefined quantities")
				break
			for(var/i = 0; i<R.ingredients[ingredient]; i++)
				var/obj/item/I
				if(IS_ABSTRACT(ingredient))
					var/ingredient_subtype = pick(concrete_typesof(ingredient))
					I = new ingredient_subtype
				else
					I = new ingredient
				test_oven.load_item(I)
		var/datum/cookingrecipe/C = test_oven.OVEN_get_valid_recipe()
		var/obj/item/test_output = new C.output //remember to clean this when you repath ovens
		if(!test_output)
			Fail("Cooking recipe [R] produced a null result")
		else if(!istype(test_output, R.output))
			Fail("Cooking recipe [R] not reachable, made [test_output.type] instead (expecting [R.output])")
		test_oven.contents = list()
		test_oven.possible_recipes = list()
	var/obj/machinery/mixer/test_mixer = new /obj/machinery/mixer
	for(var/datum/cookingrecipe/R in RM.mixer_recipes)
		if(!R.ingredients)
			Fail("Cooking recipe [R] has no ingredients")
			break
		for(var/ingredient in R.ingredients)
			if(!R.ingredients[ingredient])
				Fail("Cooking recipe [R] has ingredients with undefined quantities")
				break
			for(var/i = 0; i<R.ingredients[ingredient]; i++)
				var/obj/item/I
				if(IS_ABSTRACT(ingredient))
					var/ingredient_subtype = pick(concrete_typesof(ingredient))
					I = new ingredient_subtype
				else
					I = new ingredient
				test_mixer.load_item(I)
		var/obj/item/test_output = test_mixer.finish_cook()
		if(!test_output)
			Fail("Cooking recipe [R] produced a null result")
		else if(!istype(test_output, R.output))
			Fail("Cooking recipe [R] not reachable, made [test_output.type] instead (expecting [R.output])")
		test_mixer.contents = list()
		test_mixer.possible_recipes = list()
