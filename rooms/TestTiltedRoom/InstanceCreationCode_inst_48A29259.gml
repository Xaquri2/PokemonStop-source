sprite_index = TeamRocketWalkDownSprite_1

ds_list_add(postBattleTextList, "Very well! I yield!")
ds_list_add(postBattleNameList, "Team Rocket Hexagonni")
ds_list_add(postBattleIconList, TeamRocketWalkDownSprite_1)

// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Rocket_Tilted_inst_48A29259";
if (HasFlag(battleFlag)) nameX = "dsjknsdkcn";
else
{
	// === BATTLE FLAG (auto) END ===

	name = "Team Rocket Hexagonni"
	moveType = ""
	walkTime = 0
}