event_inherited();

if (vspeed < 2) vspeed += 0.05

hspeed = lerp(hspeed, 0, 0.05)

image_alpha -= 0.025
if (image_alpha <= 0) instance_destroy(id)