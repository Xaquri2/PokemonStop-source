canWalk = true
menuOpen = false

battle = false
talking = false
nearestNPC = noone
showNPCText = ""

hspeedOld = 0
vspeedOld = 0
arrowOffset = 0
arrowDirection = 0
arrowSpeed = 0

camera = instance_create_layer(x,y,layer,CameraObject)
camera.player = id

grassTimer = -1