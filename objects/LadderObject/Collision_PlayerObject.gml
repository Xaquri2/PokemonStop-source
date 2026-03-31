if (!active and point_distance(x,bbox_bottom,x,other.y) < 20) {
	active = true
	audio_play_sound(Downers3,2,0)
}