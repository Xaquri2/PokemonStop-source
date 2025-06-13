teamMembers = GetTrainerTeam(trainerName)
switch (lineSightDir)
{
	case "Up":
		startY -= lineSight
		break
	case "Down":
		finalY += lineSight
		break
	case "Right":
		finalX += lineSight
		break
	case "Left":
		startX -= lineSight
		break
}