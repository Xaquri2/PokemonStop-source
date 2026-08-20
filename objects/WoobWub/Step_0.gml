// Inherit the parent event
event_inherited();
if (state == "Walk")
{
    if (WobbleDir == "Right")
    {
        image_angle -= 1;

        // Hit the rightmost tilt
        if (image_angle <= 60)
        {
            image_angle = 60;
            WobbleDir = "Left";
        }
    }
    else if (WobbleDir == "Left")
    {
        image_angle += 1;

        // Hit the leftmost tilt
        if (image_angle >= 110)
        {
            image_angle = 110;
            WobbleDir = "Right";
        }
    }
}