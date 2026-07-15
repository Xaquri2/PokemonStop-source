if (HasFlag("CreditsPikalogueStarted")) {
}
else {
	var dialogue = instance_create_depth(x+110,y,-9999999999999,TextboxObject)
	dialogue.textList = textList
	dialogue.iconList = iconList
	dialogue.nameList = nameList

	dialogue.name = name
	dialogue.actionNPC = id
	dialogue.isWild = true
	ds_list_add(textList, "Hi", "How are you?", "Die.")
	ds_list_add(global.flags,"CreditsPikalogueStarted")
	alarm[3] = 100
}