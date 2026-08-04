if (HasItem("Poke Flute"))
{
	var optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
	optionMenu.menu = id
	optionMenu.question = "Would you like to wake it up?"
	ds_list_add(optionMenu.optionList, "Wake it up")
	ds_list_add(optionMenu.optionList, "Leave")
	optionMenu.target = id
}