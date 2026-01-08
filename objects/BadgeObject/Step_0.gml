var xPos = target.x
var yPos = target.y+target.sprite_height/2
switch (badgeType)
{
	case "ShadowBadge":
		xPos += target.sprite_width/2
		break
	case "RobotBadge":
		xPos += target.sprite_width
		break
}

x = lerp(x, xPos, badgeSpeed)
y = lerp(y, yPos, badgeSpeed)
if (point_distance(x,y,xPos,yPos) < 2) 
{
	instance_destroy(id)
}