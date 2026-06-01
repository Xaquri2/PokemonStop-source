// Inherit the parent event
event_inherited();

event_inherited();
name = "Zoovac"

if (!HasFlag("ZoovacFirstBattle")) battleFlag = "ZoovacFirstBattle"
else battleFlag = "ZoovacFinalBattle"

ds_list_add(textList, "Greetings.",
"Allow me to introduce myself. I'm ZOOVAC.",
"I have been controlling Team Rocket as I was created by their PARENT ENTITY.",
"Let’s just say… they’re very clever people.",
"I've been watching your progress, young Gash Ketchum.",
"You've been traveling across this region… you’ve encountered three interesting Gym Leaders.",
"One in the mutant path, the Morlock Gorbertron, whose goal is to evolve humans into Morlocks and other forms.",
"Then you encountered the... the Umbrian Lilium, whose goal was to ascend humans into ghostly forms.",
"Finally, you encountered the mad scientist, the Collector, whose goal was to replace humans with robotic forms, which are superior.",
"These people are all working for me and their plans are all part of my plan!")

ds_list_add(nameList, "Zoovac",
"Zoovac","Zoovac",
"Zoovac","Zoovac",
"Zoovac","Zoovac",
"Zoovac","Zoovac",
"Zoovac",)
ds_list_add(iconList, ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP)

ds_list_add(postBattleNameList, "Zoovac",
"Zoovac","Zoovac",
"Zoovac","Zoovac",
"Zoovac","Zoovac",)
ds_list_add(postBattleIconList, ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP,
ZoovacSprite_CLOSEUP)
// "Gorbertron", "Gorbertron", "Gorbertron", global.playerName, "Gorbertron",
//"Gorbertron", "Gorbertron", global.playerName, "Gorbertron", "Gorbertron", "Gorbertron", global.playerName, "Gorbertron",
//global.playerName, "Gorbertron", "Gorbertron", "Gorbertron", "Gorbertron")

zoovacGodzillaDialogueStarted = false;


