if (HasItem("Poke Flute"))
{
	var optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
	optionMenu.menu = id
	optionMenu.question = "Would you like to wake it up?"
	optionMenu.option1 = "Wake it up"
	optionMenu.option2 = "Leave"
	optionMenu.target = id
}