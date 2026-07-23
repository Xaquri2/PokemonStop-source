if (HasFlag("GameBeaten")) {
	sprite_index = DarkTowerSprite_SMASHED
}
else {
	var layerID = layer_get_id("Assets_1")
	var graphicID = layer_sprite_get_id(layerID, "graphic_535C764C")

	layer_sprite_destroy(graphicID)
} 