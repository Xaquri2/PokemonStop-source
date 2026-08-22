// Inherit the parent event
event_inherited();

if (state == "Walk")
{
    if (WobbleDir == "Right")
    {
        image_angle -= 2;

        // Hit the rightmost tilt
        if (image_angle <= 340)
        {
            image_angle = 340;
            WobbleDir = "Left";
        }
    }
    else if (WobbleDir == "Left")
    {
        image_angle += 2;

        // Hit the leftmost tilt
        if (image_angle >= 30)
        {
            image_angle = 30;
            WobbleDir = "Right";
        }
    }
}
else {
	if (image_angle > 0) {
		image_angle -= 2
	}
	else if (image_angle < 0) {
		image_angle += 2
	}
}
