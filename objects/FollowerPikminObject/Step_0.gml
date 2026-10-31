//event_inherited();

if (instance_exists(player))
{
	var followerPos = []
	if (RoomHasGravity())
	{
		switch (player.sprite_index)
		{
			case PlayerIdleLeftSprite:
			case PlayerWalkLeftSprite:
            case GhostPlayerIdleLeftSprite:
            case GhostPlayerWalkLeftSprite:
				followerPos = [player.x+6+CountPlace*8, player.y]
				if (randomizePosition and sprite_index != GetFollowerSprite("Left"))
				{
					xOffset = random_range(8,6)
					yOffset = GetGravityFollowerOffset(followerPos[0]+xOffset,followerPos[1])
				}
				sprite_index = GetFollowerSprite("Left")
				break

			case PlayerIdleRightSprite:
			case PlayerWalkRightSprite:
            case GhostPlayerIdleRightSprite:
            case GhostPlayerWalkRightSprite:
				followerPos = [player.x-6-CountPlace*8, player.y]
				if (randomizePosition and sprite_index != GetFollowerSprite("Right"))
				{
					xOffset = random_range(-6,-8)
					yOffset = GetGravityFollowerOffset(followerPos[0]+xOffset,followerPos[1])
				}
				sprite_index = GetFollowerSprite("Right")
				break
		
			default:
				followerPos = [player.x, player.y-CountPlace*8]
				if (randomizePosition and sprite_index != GetFollowerSprite("Down"))
				{
					xOffset = random_range(-32,32)
					yOffset = GetGravityFollowerOffset(followerPos[0]+xOffset,followerPos[1])
				}
				sprite_index = GetFollowerSprite("Down")
				break
		}
	}
	else
	{
		switch (player.sprite_index)
		{
			case PlayerIdleDownSprite:
			case PlayerWalkDownSprite:
            case GhostPlayerIdleDownSprite:
            case GhostPlayerWalkDownSprite:
				followerPos = [player.x, player.y-40-CountPlace*8]
				if (randomizePosition and sprite_index != GetFollowerSprite("Down"))
				{
					xOffset = random_range(-32,32)
					yOffset = random_range(-40,-8)
				}
				sprite_index = GetFollowerSprite("Down")
				break

			case PlayerIdleUpSprite:
			case PlayerWalkUpSprite:
            case GhostPlayerIdleUpSprite:
            case GhostPlayerWalkUpSprite:
				followerPos = [player.x, player.y+40+CountPlace*8]
				if (randomizePosition and sprite_index != GetFollowerSprite("Up"))
				{
					xOffset = random_range(-32,32)
					yOffset = random_range(8,40)
				}
				sprite_index = GetFollowerSprite("Up")
				break

			case PlayerIdleLeftSprite:
			case PlayerWalkLeftSprite:
            case GhostPlayerIdleLeftSprite:
            case GhostPlayerWalkLeftSprite:
				followerPos = [player.x+40+CountPlace*8, player.y]
				if (randomizePosition and sprite_index != GetFollowerSprite("Left"))
				{
					xOffset = random_range(8,40)
					yOffset = random_range(-32,32)
				}
				sprite_index = GetFollowerSprite("Left")
				break

			case PlayerIdleRightSprite:
			case PlayerWalkRightSprite:
            case GhostPlayerIdleRightSprite:
            case GhostPlayerWalkRightSprite:
				followerPos = [player.x-40-CountPlace*8, player.y]
				if (randomizePosition and sprite_index != GetFollowerSprite("Right"))
				{
					xOffset = random_range(-40,-8)
					yOffset = random_range(-32,32)
				}
				sprite_index = GetFollowerSprite("Right")
				break
		}
	}
	
	if (array_length(followerPos) != 0)
	{
		x = lerp(x+xOffset*0.03, followerPos[0]+yOffset, 0.1)
		y = lerp(y+yOffset*0.03, followerPos[1]+yOffset, 0.1)
	}
	else if (RoomHasGravity() and array_length(followerPos) == 0 and array_length(previousPos) != 0)
	{
		yOffset = GetGravityFollowerOffset(previousPos[0]+xOffset,previousPos[1])
		x = lerp(x+xOffset*0.03, previousPos[0]+yOffset, 0.1)
		y = lerp(y+yOffset*0.03, previousPos[1]+yOffset, 0.1)
	}
	
	previousPos = followerPos
}

//if (global.followerType == "Mary")
//{
//	if (sprite_index == MaryWalkDownSprite) or (sprite_index == MaryWalkUpSprite) {
//		xscaleOffset = 1
//		image_yscale = 1.5
//	}
//	else {
//		xscaleOffset = 1.4
//		image_yscale = 1.5
//	}
//}
image_xscale = xscaleDir*xscaleOffset

if (PlayerObject.hspeed == 0) && (PlayerObject.vspeed == 0) {
	image_speed = 0
}
else {
	image_speed = 1;
}