if (player != noone)
{
	if (!tpedToPlayer)
	{
		x = player.x
		y = player.y
		tpedToPlayer = true
	}
	else
	{
		if (room == RobotPathShop) {
			x = lerp(x, player.x, 0.2)
			y = lerp(y, player.y, 0.2)
		}
		else {
			x = lerp(x, player.x, 0.2)
			y = lerp(y, player.y, 0.2)
		}
	}
}
else
{
	var attempt = instance_find(PlayerObject, 0)
	if (instance_exists(attempt)) player = attempt
}

// reacquire player if needed
//if (player == noone)
//{
//    var attempt = instance_find(PlayerObject, 0);
//    if (instance_exists(attempt)) player = attempt;
//}
//
//// follow
//if (player != noone)
//{
//    var follow = 0.2;
//
//    if (room == TestTiltedRoom) // use your actual room resource name
//    {
//        if (point_distance(x, y, player.x, player.y) > 300)
//        {
//            follow = 2; // NOT 10
//        }
//    }
//
//    x = lerp(x, player.x, follow);
//    y = lerp(y, player.y, follow);
//}
