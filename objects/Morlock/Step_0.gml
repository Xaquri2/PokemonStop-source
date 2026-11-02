event_inherited();


if (HasFlag(battleFlag)) && ((!HasFlag("Potion") or (HasFlag("Potion") and HasFlag("PotionCure"))) and global.morlockTimer == 0) 
{
	instance_destroy()
}

if ((!HasFlag("Potion") or (HasFlag("Potion") and HasFlag("PotionCure"))) and global.morlockTimer == 0)
{
	var player = instance_find(PlayerObject, 0)
	if (instance_exists(player) and point_distance(x,y,player.x,player.y) <= detectRange)
	{
		speed = 0
		hspeed = lengthdir_x(walkSpeed, point_direction(x,y,player.x,player.y))
		vspeed = lengthdir_y(walkSpeed, point_direction(x,y,player.x,player.y))

		if (RoomHasGravity())
		{
			if (vspeed < 3) vspeed += 1.5
		}
	
		if instance_exists(collision_rectangle(bbox_left+hspeed,bbox_top,
		bbox_right+hspeed,bbox_bottom,TiltedFloor,false,true))
		{
			if !instance_exists(collision_rectangle(x+hspeed,bbox_top-2,
			x+hspeed,bbox_bottom-5,TiltedFloor,false,true))
			{
				y -= 2
			}
			else hspeed = 0
		}
		if instance_exists(collision_rectangle(bbox_left,bbox_top+vspeed,
		bbox_right,bbox_bottom+vspeed,TiltedFloor,false,true))
		{
			vspeed = 0
		}

		if (point_distance(x,y,player.x,player.y) <= global.torchRange and global.torch and global.torchPower > 0)
		{
			move_towards_point(player.x,player.y,-walkSpeed)
		}
	}
	else
	{
	
	}

	if (!player.canWalk) speed = 0
}

if (global.morlockTimer > 0)
{
	if (collision_rectangle(bbox_left+hspeed,bbox_top+vspeed,
	bbox_right+hspeed,bbox_bottom+vspeed,PlayerObject,false,true))
	{
		speed = 0
		state = "Idle"
		walkCoords = []

		image_xscale = abs(image_xscale)
		sprite_index = idleSprite
		alarm[0] = random_range(60*minWalkTimerValue, 60*maxWalkTimerValue)
	}
}

// Chasing and torch avoidance override the parent's movement after its wall check.
// Validate the final velocity so neither behavior can move through an enclosure.
if (hspeed != 0 and collision_rectangle(bbox_left+hspeed, bbox_top,
bbox_right+hspeed, bbox_bottom, CollisionParent, false, true)) hspeed = 0
if (vspeed != 0 and collision_rectangle(bbox_left, bbox_top+vspeed,
bbox_right, bbox_bottom+vspeed, CollisionParent, false, true)) vspeed = 0
// Also block diagonal corner clipping when each separate axis is clear.
if (collision_rectangle(bbox_left+hspeed, bbox_top+vspeed,
bbox_right+hspeed, bbox_bottom+vspeed, CollisionParent, false, true)) speed = 0

if (distance_to_object(MorlockPowerThing) < 0.7) instance_destroy()

CheckForInterruptions()

if ((id == inst_1AA0B45B) && (GrateFalling == false)) { 
	if HasFlag("TiltedGrateOpen") {
		x = lerp(x, 745.5417,.1)
		y = lerp(y, 882.417,.1)
		image_angle = lerp(image_angle, 90, .1)
		if ((x == 745.5417) && (y == 882.417) && (image_angle == 90))
		if (point_distance(x, y, 745.5417, 882.417) < 1
        && abs(image_angle - 90) < 1){
			GrateFalling = true
		}
	}
}
