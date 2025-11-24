if (endBattle)
{
	if (!defeat)
	{	
		var battle = instance_find(BattleObject, 0)
		battle.ending = true
		battle.fadeAlpha = 0
	
		if (battle.battleFlag != "" and PostBattleFlagActivation(battle.battleFlag)
		and ds_list_find_index(global.flags, battle.battleFlag) == -1) 
		{
			ds_list_add(global.flags, battle.battleFlag)
		}
	}
	else
	{
		var battle = instance_find(BattleObject, 0)
		battle.ending = true
		battle.defeat = true
		battle.fadeAlpha = 0
	}
}