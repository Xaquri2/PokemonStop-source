event_inherited();

name = "Collector"

if (!HasFlag("CollectorFirstBattle")) battleFlag = "CollectorFirstBattle"
else battleFlag = "CollectorFinalBattle"

ds_list_add(textList, "Welcome, you come to challenge me for the badge?",
"Well, I assume I assume you've brought inferior biological type Pokemon?")

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
	talking = true

	if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
}
else if (HasFlag("CollectorFirstBattle") and HasFlag("CollectorFinalBattle"))
{
	ds_list_add(postBattleTextList, "Well, it seems you've earned the robot badge.", 
	"Enjoy being an inferior human!")
	ds_list_add(postBattleNameList, "The Collector","The Collector")
	ds_list_add(postBattleIconList, TheCollectorSprite,TheCollectorSprite)
	
	var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
	dialogue.textList = postBattleTextList
	dialogue.iconList = iconList
	dialogue.nameList = nameList

	dialogue.name = name
	dialogue.actionNPC = id
	talking = true

	if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
}