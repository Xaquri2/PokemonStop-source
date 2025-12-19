if (instance_exists(player))
{
	var followerPos = []
	switch (player.sprite_index)
	{
		case PlayerIdleDownSprite:
		case PlayerWalkDownSprite:
			followerPos = [player.x, player.y-40]
			if (randomizePosition and sprite_index != GetFollowerSprite("Down"))
			{
				xOffset = random_range(-32,32)
				yOffset = random_range(-40,-8)
			}
			sprite_index = GetFollowerSprite("Down")
			break

		case PlayerIdleUpSprite:
		case PlayerWalkUpSprite:
			followerPos = [player.x, player.y+40]
			if (randomizePosition and sprite_index != GetFollowerSprite("Up"))
			{
				xOffset = random_range(-32,32)
				yOffset = random_range(8,40)
			}
			sprite_index = GetFollowerSprite("Up")
			break

		case PlayerIdleLeftSprite:
		case PlayerWalkLeftSprite:
			followerPos = [player.x+40, player.y]
			if (randomizePosition and sprite_index != GetFollowerSprite("Left"))
			{
				xOffset = random_range(8,40)
				yOffset = random_range(-32,32)
			}
			sprite_index = GetFollowerSprite("Left")
			break

		case PlayerIdleRightSprite:
		case PlayerWalkRightSprite:
			followerPos = [player.x-40, player.y]
			if (randomizePosition and sprite_index != GetFollowerSprite("Right"))
			{
				xOffset = random_range(-40,-8)
				yOffset = random_range(-32,32)
			}
			sprite_index = GetFollowerSprite("Right")
			break
	}

	if (array_length(followerPos) != 0)
	{
		x = lerp(x+xOffset*0.03, followerPos[0], 0.1)
		y = lerp(y+yOffset*0.03, followerPos[1], 0.1)
	}
}
