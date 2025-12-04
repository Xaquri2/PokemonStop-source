fogController = instance_find(FogControllerObject, 0)

image_alpha = 1-point_distance(x,y,fogController.x,fogController.y)/fogController.spawnRange
dir = OneOrMinusOne()

alarm[0] = 60*2