event_inherited()
name = "Team Rocket"
moveType = "Vertical"
lineSightDir = "Down"
lineSight = 200

ds_list_add(textList, "We, Team Rocket, are Pokémon gangsters!")
ds_list_add(nameList, name)
ds_list_add(iconList, TeamRocketWalkDownSprite_1)

moveDir = -1
walkTime = 100
alarm[3] = walkTime

if (circuit == true)
{Alarm[4] = walkTime}

//moveType = "Vertical"
//walkTime = 350;