if (state == "Walk")
{
	draw_line(x,y,walkCoords[0],walkCoords[1])
	draw_text(x,y-30,distance_to_point(walkCoords[0], walkCoords[1]))
}
draw_self()
