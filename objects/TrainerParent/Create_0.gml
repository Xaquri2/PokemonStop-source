event_inherited();
trainerName = ""
teamMembers = ds_list_create()

startX = bbox_left
startY = bbox_top
finalX = bbox_right
finalY = bbox_bottom

lineSight = 32 //The range they can see players
lineSightDir = "" //Should be Up, Down, Left or Right
triggered = false

alarm[0] = 1