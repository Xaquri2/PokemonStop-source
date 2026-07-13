if (HasFlag("CreditsDialogueStarted")) {
}
else {
	var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
	dialogue.textList = textList
	dialogue.iconList = iconList
	dialogue.nameList = nameList

	dialogue.name = name
	dialogue.actionNPC = id
	dialogue.isWild = true
	ds_list_add(textList, "Hey!! Andre programmed this!!!")
	ds_list_add(global.flags,"CreditsDialogueStarted")
}