depth = -y

if (RoomHasGravity())
{
	if (vspeed < 3) vspeed += 1.5
}


#region Collision
var collidedTile = collision_rectangle(bbox_left+hspeed, bbox_bottom+vspeed,
bbox_right+hspeed, bbox_top+vspeed, CollisionParent, false, true)

if (instance_exists(collidedTile))
{
	if (collidedTile.object_index == TiltedFloor)
	{
		if (hspeed != 0) y -= 1
	}
	else
	{
		hspeed = 0
		vspeed = 0
	}
}

if (x+hspeed > room_width or x-hspeed < 0 or collision_rectangle(bbox_left+hspeed, bbox_bottom, bbox_right+hspeed, bbox_top, CollisionParent, false, true) != noone) hspeed = 0
if (y+vspeed > room_height or y-vspeed < 0 or collision_rectangle(bbox_left, bbox_bottom+vspeed, bbox_right, bbox_top+vspeed, CollisionParent, false, true) != noone) vspeed = 0
#endregion