event_inherited();
if (moveDir > 0)
{
	vspeed = 1
	lineSightDir = "Down"
}
else
{
	vspeed = -1
	lineSightDir = "Up"

}

if (collision_rectangle(bbox_left,bbox_top+vspeed,bbox_right,bbox_bottom+vspeed,CollisionObject,false,true) != noone)
{
	moveDir *= -1
	alarm[3] = walkTime
}