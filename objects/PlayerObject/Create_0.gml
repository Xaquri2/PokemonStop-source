game = instance_find(GameObject, 0)

canEncounter = true
canWalk = true
canCollide = false
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

camera = instance_create_layer(x,y,"Important",CameraObject)
camera.player = id

grassTimer = -1
fogTimer = -1

normalSpeed = 2
overworldSpeed = 2.25

follower = noone

fogTeleportRange = 32*5
fogTeleportTime = 60*3

alarm[3] = 2

falling = false
BehindTower = false; 
ControlsHidden = true;

if (global.morlockTimer > 0) sprite_index = PlayerMorlockIdleDownSprite

