event_inherited();
player = instance_find(PlayerObject, 0)

if (HasFlag("CollectorFirstBattle") and !HasFlag("CollectorFinalBattle")) 
{
	ds_list_add(postBattleTextList, "You think you've won, don't you?!",
	"MEGA-BOT, Activate!!!")
	ds_list_add(postBattleNameList, "The Collector","The Collector")
	ds_list_add(postBattleIconList, TheCollectorSprite,TheCollectorSprite)
	
	var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
	dialogue.textList = postBattleTextList
	dialogue.iconList = iconList
	dialogue.nameList = nameList

	dialogue.name = name
	dialogue.actionNPC = id
	player.talking = true

	if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
}
else if (HasFlag("CollectorFirstBattle") and HasFlag("CollectorFinalBattle"))
{
	ds_list_add(postBattleTextList, "Well, it seems you've earned the Robot Badge.", 
	"Enjoy being an inferior human!")
	ds_list_add(postBattleNameList, "The Collector","The Collector")
	ds_list_add(postBattleIconList, TheCollectorSprite,TheCollectorSprite)
	
	var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
	dialogue.textList = postBattleTextList
	dialogue.iconList = iconList
	dialogue.nameList = nameList

	dialogue.name = name
	dialogue.actionNPC = id
	player.talking = true

	if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
}