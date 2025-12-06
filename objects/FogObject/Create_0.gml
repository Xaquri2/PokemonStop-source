fogController = instance_find(FogControllerObject, 0)

image_alpha = 0
finalAlpha = 1-point_distance(x,y,fogController.x,fogController.y)/fogController.spawnRange
spawned = false
dir = OneOrMinusOne()

alarm[0] = 60*5