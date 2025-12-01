if (fadingIn and image_alpha < 1)
{
	image_alpha += 0.1
	if (image_alpha == 1)
	{
		alarm[0] = 10
	}
}
else if (!fadingIn and image_alpha > 0)
{
	image_alpha -= 0.1
	if (image_alpha == 0)
	{
		instance_destroy(id)
	}
}
