if ((alarm[3] > 0 and flashMode == 1))
{
	gpu_set_fog(true,c_white,0,0);
	draw_self()
	gpu_set_fog(false,c_white,0,0);
}
else 
{
	if (catchEffect)
	{
		image_alpha = catchEffectAlpha
		draw_self()
		image_alpha = 1
	}
	else draw_self()
}