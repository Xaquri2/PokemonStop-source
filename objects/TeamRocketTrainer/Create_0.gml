event_inherited()
name = "Team Rocket"
moveType = "Vertical"
lineSightDir = "Down"
lineSight = 64

ds_list_add(textList, "We, Team Rocket, are Pokemon gangsters!")
ds_list_add(nameList, name)
ds_list_add(iconList, sprite_index)

moveDir = -1
walkTime = 100
alarm[3] = walkTime