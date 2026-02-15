event_inherited();

name = "Collector"

if (!HasFlag("CollectorFirstBattle")) battleFlag = "CollectorFirstBattle"
else battleFlag = "CollectorFinalBattle"

ds_list_add(textList, "Welcome, you come to challenge me for the badge?",
"Well, I assume I assume you've brought inferior biological type Pokemon?")
ds_list_add(nameList, "The Collector","The Collector")
ds_list_add(iconList, TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP)