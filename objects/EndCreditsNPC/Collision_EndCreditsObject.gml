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
	ds_list_add(textList, "Hey!! Andre programmed this!!!","Don't walk away, I'm talking to you!","I said Andre programmed this!! GET BACK HERE, you schmuck!!")
	ds_list_add(global.flags,"CreditsDialogueStarted")
	alarm[1] = 60
}