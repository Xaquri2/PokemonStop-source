if (FakeGashMoving == true) {
	y = lerp(y, y+1, 1)
	sprite_index = PlayerWalkDownSprite
}
else {
	sprite_index = PlayerIdleDownSprite
}