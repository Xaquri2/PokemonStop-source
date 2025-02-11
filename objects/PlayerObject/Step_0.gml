#region Movement
hspeedOld = hspeed
vspeedOld = vspeed
hspeed = 0
vspeed = 0

if (keyboard_check(ord("W"))) vspeed = -1
if (keyboard_check(ord("S"))) vspeed = 1
if (keyboard_check(ord("A"))) hspeed = -1
if (keyboard_check(ord("D"))) hspeed = 1
#endregion

#region Collision

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