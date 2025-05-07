//attempts to make each cooking recipe, to ensure they are all reachable
TEST_FOCUS(/datum/unit_test/recipe_picker)
/datum/unit_test/recipe_picker/Run()
	var/obj/machinery/cookingmachine/oven/test_oven = new /obj/machinery/cookingmachine/oven
	for(var/datum/cookingrecipe/R in concrete_typesof(/datum/cookingrecipe/oven))
		for(var/ingredient/ingredient in R.ingredients)
			for(var/i = 0; i<R.ingredients[ingredient]; i++)
				test_oven.load_item(new ingredient)
		var/obj/item/test_output = test_oven.finish_cook()
		if(!istype(test_output, R.output))
			Fail("Cooking recipe [R] not reachable, made [test_ouput] instead (expecting [R.output])")
		test_oven.contents = list()
		test_oven.possible_recipes = list()

	var/obj/machinery/cookingmachine/mixer/test_mixer = new /obj/machinery/cookingmachine/mixer
	for(var/datum/cookingrecipe/R in concrete_typesof(/datum/cookingrecipe/mixer))
		for(var/ingredient/ingredient in R.ingredients)
			for(var/i = 0; i<R.ingredients[ingredient]; i++)
				test_mixer.load_item(new ingredient)
		var/obj/item/test_output = test_mixer.finish_cook()
		if(!istype(test_output, R.output))
			Fail("Cooking recipe [R] not reachable, made [test_ouput] instead (expecting [R.output])")
		test_mixer.contents = list()
		test_mixer.possible_recipes = list()
