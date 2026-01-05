event_inherited();
canWalk = true
walkCoords = []
walkRange = 50
walkSpeed = 1

minWalkTimerValue = 3
maxWalkTimerValue = 6
startTimerExtra = 3 //They always take more time to start walking at first. 
//If you dont want this, set it to zero and they will take the usual time

idleSprite = noone
walkUpSprite = noone
walkDownSprite = noone
walkRightSprite = noone

alarm[0] = random_range(60*minWalkTimerValue+startTimerExtra, 60*maxWalkTimerValue+startTimerExtra)