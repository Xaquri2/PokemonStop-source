name = ""
state = "Idle"

textList = ds_list_create()
iconList = ds_list_create()
nameList = ds_list_create()
trainerTeam = ds_list_create()
trainerSprite = noone
battleFlag = ""

defeatTextList = ds_list_create()
ds_list_add(defeatTextList, "You've beaten me!")
isWild = false

originX = x
originY = y

alarm[0] = 1

//ds_list_add(textList, "Gash!!", "You look so handsome, I'm so proud of you...!", "DONT..")
//ds_list_add(iconList, sprite_index,  sprite_index,  sprite_index)
//ds_list_add(nameList, "Gash's Mom", "Gash's Mom", "Gash's Mom")
