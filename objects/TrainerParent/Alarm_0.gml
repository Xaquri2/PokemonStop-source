event_inherited()
switch (lineSightDir)
{
	case "Up":
		startY -= lineSight
		break
	case "Down":
		finalY += lineSight
		break
	case "Right":
		finalX += lineSight
		break
	case "Left":
		startX -= lineSight
		break
}

if (trainerSprite == noone and sprite_index != noone)
{
	trainerSprite = sprite_index
}