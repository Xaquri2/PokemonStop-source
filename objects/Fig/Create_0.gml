// Inherit the parent event
event_inherited();

name = "Fig"

battleFlag = id

if HasFlag(battleFlag) {
	instance_destroy(self)
	}

canWalk = true;

walkDownSprite = FigOverworldSprite
walkUpSprite = FigOverworldSprite
walkRightSprite = FigOverworldSprite
idleSprite = FigOverworldSprite

alarm[0]=1

minWalkTimerValue = 2
maxWalkTimerValue = 3

WobbleDir = "Right"
figWobbleAngle = 0

AddPokemonTrainer(trainerTeam,1,"Fig",8,GetRandomGender(30),FigOverworldSprite)

