event_inherited();
postBattleTextList = ds_list_create()
postBattleIconList = ds_list_create()
postBattleNameList = ds_list_create()

startX = bbox_left
startY = bbox_top
finalX = bbox_right
finalY = bbox_bottom

targetX = 0
targetY = 0

lineSight = 32 //The range they can see players
lineSightDir = "" //Should be Up, Down, Left or Right
triggered = false
walk = false

dialogueStart = false
alarm[0] = 1