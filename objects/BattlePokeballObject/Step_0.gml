if (vspeed < 3 and !activated) vspeed += 0.1
//if (activated) image_angle += 5

if (activated)
{
	bobbingTimer++
	if (bobbingTimer > 30)
	{
		if (bobbingTimer < 90) 
		{
			if (currentBobbing <= timesBobbed) 
			{
				if (bobbingTimer < 50) angleOffset += angleValue
				else if (bobbingTimer < 70) angleOffset -= angleValue*2
				else angleOffset += angleValue*1
			}
		}
		else 
		{
			bobbingTimer = 0
			currentBobbing++
			if (currentBobbing > timesBobbed)
			{
				 if (timesBobbed < 3) instance_destroy(id)
				 //else (If successful at catching, spawn stars upwards)
			}
		}
	}
}

image_angle = angleOffset