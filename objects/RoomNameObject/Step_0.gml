if (!returning)
{
	if (yPos < 80) yPos += 2
	else
	{
		if (alarm[0] < 0 and !returning) alarm[0] = 120
	}
}
else
{
	if (yPos > -120) yPos -= 2
	else instance_destroy(id)
}

if (room == EndCreditsRoom) instance_destroy(id)