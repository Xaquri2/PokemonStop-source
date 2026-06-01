event_inherited();
player = instance_find(PlayerObject, 0)

if (HasFlag("ZoovacFirstBattle") && (zoovacGodzillaDialogueStarted == false))
{
	zoovacGodzillaDialogueStarted = true;
	if (!HasFlag("ZoovacFinalBattle")) 
	{
		ds_list_empty(postBattleTextList)
		ds_list_empty(postBattleNameList)
		ds_list_empty(postBattleIconList)
		
		ds_list_add(postBattleTextList, "You think you've won, don't you?!",
		"Godzilla, come out!")
		ds_list_add(postBattleNameList, "Zoovac","Zoovac")
		ds_list_add(postBattleIconList, Zoovac,Zoovac)
		
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		dialogue.textList = postBattleTextList
		dialogue.iconList = iconList
		dialogue.nameList = nameList

		dialogue.name = name
		dialogue.actionNPC = id
		player.talking = true

		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
	}
	else
	{
		ds_list_empty(postBattleTextList)
		ds_list_empty(postBattleNameList)
		ds_list_empty(postBattleIconList)
		
		ds_list_add(postBattleTextList, "Well, well, well!",
		"The first one to beat me...",
		"I'm impressed!",
		"…Even if I'm also a bit pissed. You wrecked my building.",
		"Nonetheless! You won in good faith. Incredible.",
		"If you’d ever like to betray your species and help me finish my quest, I might have a place for you.",
		"In the meantime, much as I hate to admit it, you've earned… THE ULTIMATE BADGE!")
		ds_list_add(postBattleNameList, "Zoovac", "Zoovac", "Zoovac", "Zoovac", "Zoovac", "Zoovac", "Zoovac")
		ds_list_add(postBattleIconList, Zoovac, Zoovac, Zoovac, Zoovac, Zoovac, Zoovac, Zoovac, Zoovac)
		
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		dialogue.textList = postBattleTextList
		dialogue.iconList = iconList
		dialogue.nameList = nameList

		dialogue.name = name
		dialogue.actionNPC = id
		player.talking = true

		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
	}
}