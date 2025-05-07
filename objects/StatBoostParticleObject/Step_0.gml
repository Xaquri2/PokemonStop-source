dirTimer--
if (dirTimer <= 0)
{
	if (dir == 1) dir = -1
	if (dir == -1) dir = 1
	dirTimer = random_range(1,30)
}

hspeed = lerp(hspeed, 1*dir, 0.1)

image_alpha -= 0.025
if (image_alpha <= 0) instance_destroy()