originRoom = GameObject.backupRoomInfo

for (var i = -5; i < 5; i++)
{
	for (var j = -5; j < 5; j++)
	{
		var nestTile = instance_create_layer(x+32*i,y+32*j,"Instances",NestTileObject)
		nestTile.sprite_index = GetNestRoomTileType(originRoom)
	}
}