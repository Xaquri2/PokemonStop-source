event_inherited();

if (vspeed < 2) vspeed += 0.02

if (hspeed > 0) hspeed -= 0.02
else if (hspeed < 0) hspeed += 0.02

image_alpha -= 0.01
if (image_alpha <= 0) instance_destroy(id)