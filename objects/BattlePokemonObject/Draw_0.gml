if (alarm[3] > 0 and flashMode == 1)
{
	gpu_set_fog(true,c_white,0,0);
	draw_self()
	gpu_set_fog(false,c_white,0,0);
}
else draw_self()
draw_text(x,y+32,hp) //Health stat for testing