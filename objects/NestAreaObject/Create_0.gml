var tileRegion = GetNestRoomTileType(GetAreaKeyOrigin(GameObject.areaKeyInfo))

for (var i = -5; i < 5; i++)
{
	for (var j = -5; j < 5; j++)
	{
		var nestTile = instance_create_layer(x+32*i,y+32*j,"Instances",NestTileObject)
		// Keep logical tile bounds at 32x32, independent of the source atlas.
		nestTile.sprite_index = GreenTileSprite
		nestTile.tileRegion = tileRegion
	}
}

var spawnGrass = instance_find(NestTileObject, irandom(instance_number(NestTileObject)-1))
spawnGrass.spawn = true