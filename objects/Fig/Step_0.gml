event_inherited();

// Keep a signed angle instead of interpolating through the 0/360 wraparound.
if (state == "Walk")
{
    if (WobbleDir == "Right")
    {
        figWobbleAngle = max(-20, figWobbleAngle-2)
        if (figWobbleAngle <= -20) WobbleDir = "Left"
    }
    else
    {
        figWobbleAngle = min(30, figWobbleAngle+2)
        if (figWobbleAngle >= 30) WobbleDir = "Right"
    }
}
else
{
    if (figWobbleAngle > 0) figWobbleAngle = max(0, figWobbleAngle-2)
    else if (figWobbleAngle < 0) figWobbleAngle = min(0, figWobbleAngle+2)
}
image_angle = figWobbleAngle
