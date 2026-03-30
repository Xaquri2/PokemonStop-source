if (y > other.y and (x > other.bbox_left and x < other.bbox_right) && (other.image_alpha > 0.5))
{
	other.image_alpha -= 0.05
	//BehindTower = true
}
else {
	other.image_alpha += 0.005
	//BehindTower = false
}