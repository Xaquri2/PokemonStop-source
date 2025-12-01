if (vspeed < 3 and !activated) vspeed += 0.1

if (success)
{
	if (image_alpha > 0) image_alpha -= 0.05
	else instance_destroy(id)
}

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
				 else success = true

				 var textbox = instance_find(BattleTextboxObject, 0)
				 textbox.catching = false
			}
		}
	}
}

if (!activated) image_angle += 5
else image_angle = angleOffset
