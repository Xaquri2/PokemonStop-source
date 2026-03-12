if (!battle)
{
	var musicC = instance_find(MusicObject, 0)
	var music = musicC.currentMusic
	audio_stop_sound(music)
	audio_play_sound(GetBattleTheme(name), 1, false)
	musicC.currentMusic = GetBattleTheme(name)
	
	battle = true
	other.talking = false
	other.canWalk = false
	other.battle = true

	var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
	battleObj.enemyTeam = trainerTeam
	battleObj.enemySprite = trainerSprite
	battleObj.enemyName = name
	battleObj.isWild = true
	battleObj.playerX = other.x
	battleObj.playerY = other.y
	battleObj.playerRoom = room

	if (battleFlag != "") battleObj.battleFlag = battleFlag
}
