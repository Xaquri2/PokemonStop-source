if (instance_exists(player))
{
	var followerPos = []
	switch (player.sprite_index)
	{
		case PlayerIdleDownSprite:
		case PlayerWalkDownSprite:
			followerPos = [player.x, player.y-40]
			sprite_index = GetFollowerSprite("Down")
			break

		case PlayerIdleUpSprite:
		case PlayerWalkUpSprite:
			followerPos = [player.x, player.y+40]
			sprite_index = GetFollowerSprite("Up")
			break

		case PlayerIdleLeftSprite:
		case PlayerWalkLeftSprite:
			followerPos = [player.x+40, player.y]
			sprite_index = GetFollowerSprite("Left")
			break

		case PlayerIdleRightSprite:
		case PlayerWalkRightSprite:
			followerPos = [player.x-40, player.y]
			sprite_index = GetFollowerSprite("Right")
			break
	}

	if (array_length(followerPos) != 0)
	{
		x = lerp(x, followerPos[0], 0.1)
		y = lerp(y, followerPos[1], 0.1)
	}
}
