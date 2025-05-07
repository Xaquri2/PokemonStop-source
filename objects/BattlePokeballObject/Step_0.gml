if (vspeed < 3 and !activated) vspeed += 0.1
//if (activated) image_angle += 5

if (activated)
{
	bobbingTimer++
	if (bobbingTimer > 30)
	{
		if (bobbingTimer < 90) 
		{
			if (timesBobbed >= currentBobbing) 
			{
				if (bobbingTimer < 50) angleOffset += angleValue
				else if (bobbingTimer < 70) angleOffset -= angleValue*2
				else angleOffset += angleValue*1
			}
		}
		else 
		{
			bobbingTimer = 0
			if (currentBobbing < timesBobbed) currentBobbing++
			else instance_destroy(id)
		}
	}
}

image_angle = angleOffset