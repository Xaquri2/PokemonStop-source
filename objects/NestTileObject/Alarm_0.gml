if (sprite_index == GreenTileSprite) 
{
	if (irandom(1) == 1) instance_create_layer(x,y,"Instances",GrassObject)
}

if (spawn) instance_create_depth(x+sprite_width/2,y+sprite_height/2,depth,NestAreaPokemon)