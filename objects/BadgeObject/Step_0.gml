// Preserve the badge landing positions from before the centered door target
// moved 33 pixels right and 32 pixels down.
var xPos = target.x-33
var yPos = target.y+target.sprite_height/2-32
switch (badgeType)
{
	case "ShadowBadge":
		xPos += target.sprite_width/2
		yPos -= 40
		break
	case "RobotBadge":
		xPos += target.sprite_width
		break
}

x = lerp(x, xPos, badgeSpeed)
y = lerp(y, yPos, badgeSpeed)
if (point_distance(x,y,xPos,yPos) < 2) 
{
	image_alpha -= 0.1
	if (alarm[0] == -1)  // -1 means the alarm isn't running
    {
        alarm[0] = 12
    }
}
