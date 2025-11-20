textList = ds_list_create()
iconList = ds_list_create()
nameList = ds_list_create()
name = ""

item = ""
itemCount = 1

currentText = 0
actionNPC = noone
charCounterMax = 2
charCounter = 0
charNumber = 0

isWild = false
startBattle = false
isDefeatDialogue = false

player = instance_find(PlayerObject, 0)

alarm[0] = 1

//Note: icons' origins must be on the bottom center