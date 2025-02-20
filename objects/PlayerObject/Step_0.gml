#region Movement
hspeedOld = hspeed
vspeedOld = vspeed
hspeed = 0
vspeed = 0

if (keyboard_check_pressed(ord("E")) and !menuOpen) 
{
	canWalk = false
	menuOpen = true
	var menu = instance_create_layer(x,y,"UserInterface",MenuObject)
	menu.player = id
}

if (canWalk)
{
	if (keyboard_check(ord("W"))) vspeed = -2
	if (keyboard_check(ord("S"))) vspeed = 2
	if (keyboard_check(ord("A"))) hspeed = -2
	if (keyboard_check(ord("D"))) hspeed = 2
}
#endregion

#region Collision
if (x+hspeed > room_width or x-hspeed < 0 or collision_rectangle(bbox_left+hspeed, bbox_bottom, bbox_right+hspeed, bbox_top, CollisionParent, false, true) != noone) hspeed = 0
if (y+vspeed > room_height or y-vspeed < 0 or collision_rectangle(bbox_left, bbox_bottom+vspeed, bbox_right, bbox_top+vspeed, CollisionParent, false, true) != noone) vspeed = 0
#endregion

#region Animation
if (vspeed < 0) sprite_index = PlayerWalkUpSprite
if (vspeed > 0) sprite_index = PlayerWalkDownSprite
if (hspeed > 0) sprite_index = PlayerWalkRightSprite
if (hspeed < 0) sprite_index = PlayerWalkLeftSprite

if (hspeed == 0 and vspeed == 0)
{
	if (vspeedOld < 0) sprite_index = PlayerIdleUpSprite
	if (vspeedOld > 0) sprite_index = PlayerIdleDownSprite
	if (hspeedOld > 0) sprite_index = PlayerIdleRightSprite
	if (hspeedOld < 0) sprite_index = PlayerIdleLeftSprite
}
#endregion